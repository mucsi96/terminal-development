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
    };
}
