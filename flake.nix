{
  description = "Vim cheat sheet & flashcards — pandoc + LaTeX toolchain for building the printable PDF";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
  };

  outputs = { self, nixpkgs }:
    let
      systems = [ "x86_64-linux" "aarch64-linux" "x86_64-darwin" "aarch64-darwin" ];
      forAllSystems = f: nixpkgs.lib.genAttrs systems (system: f nixpkgs.legacyPackages.${system});
    in
    {
      devShells = forAllSystems (pkgs: {
        default = pkgs.mkShell {
          packages = [
            pkgs.pandoc
            (pkgs.texliveSmall.withPackages (ps: [ ps.collection-fontsrecommended ]))
            pkgs.dejavu_fonts
          ];
          # Make the DejaVu fonts visible to xelatex even on bare systems
          FONTCONFIG_FILE = pkgs.makeFontsConf { fontDirectories = [ pkgs.dejavu_fonts ]; };
        };
      });

      packages = forAllSystems (pkgs:
        let
          tex = pkgs.texliveSmall.withPackages (ps: [ ps.collection-fontsrecommended ]);
          fontsConf = pkgs.makeFontsConf { fontDirectories = [ pkgs.dejavu_fonts ]; };
          mkPdf = name: pandocArgs: pkgs.stdenvNoCC.mkDerivation {
            inherit name;
            src = ./.;
            nativeBuildInputs = [ pkgs.pandoc tex ];
            FONTCONFIG_FILE = fontsConf;
            buildPhase = ''
              pandoc vim-cheat-sheet.md -o vim-cheat-sheet.pdf \
                --pdf-engine=xelatex \
                -V mainfont="DejaVu Serif" \
                -V sansfont="DejaVu Sans" \
                -V monofont="DejaVu Sans Mono" \
                ${pandocArgs}
            '';
            installPhase = ''
              mkdir -p $out
              cp vim-cheat-sheet.pdf $out/
            '';
          };
        in
        {
          # nix build → result/vim-cheat-sheet.pdf (portrait, A4-ish margins)
          default = mkPdf "vim-cheat-sheet-pdf"
            ''-V geometry:margin=1.5cm -V fontsize=10pt'';

          # nix build .#compact → landscape with tight margins for a denser printout
          compact = mkPdf "vim-cheat-sheet-pdf-compact"
            ''-V geometry:landscape,margin=1cm -V fontsize=9pt'';
        });
    };
}
