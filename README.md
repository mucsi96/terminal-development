# terminal-development

Cheat sheet and flashcards for learning Vim, following the structure of [mucsi96/ckad](https://github.com/mucsi96/ckad).

## Building the PDF

The repo ships a Nix flake ([flake.nix](flake.nix)) whose dev shell contains the full conversion toolchain, so nothing needs to be installed system-wide:

- **pandoc** — converts the markdown to PDF
- **XeLaTeX** (`texliveSmall` + recommended fonts collection) — the PDF engine; XeLaTeX is required because the sheet contains Unicode characters (`→`, `↔`, `…`) that the default pdflatex engine rejects
- **DejaVu fonts** — cover those Unicode glyphs; `FONTCONFIG_FILE` is set inside the shell so XeLaTeX finds them even on a bare system

### One-time setup (WSL / Linux / macOS)

1. [Install Nix](https://nixos.org/download/) — on WSL the single-user install is the simplest:

   ```sh
   sh <(curl -L https://nixos.org/nix/install) --no-daemon
   ```

2. Enable flakes by adding this line to `~/.config/nix/nix.conf` (create the file if needed):

   ```
   experimental-features = nix-command flakes
   ```

### Build

```sh
nix develop               # enter the shell (first run downloads the toolchain)

pandoc vim-cheat-sheet.md -o vim-cheat-sheet.pdf \
  --pdf-engine=xelatex \
  -V mainfont="DejaVu Serif" -V monofont="DejaVu Sans Mono" \
  -V geometry:margin=1.5cm -V fontsize=10pt

exit                      # leave the shell when done
```

For a denser printout, swap the last two `-V` flags for a landscape layout with tight margins:

```sh
  -V geometry:landscape,margin=1cm -V fontsize=9pt
```

See the bottom of [vim-cheat-sheet.md](vim-cheat-sheet.md) for non-Nix alternatives (apt packages, VS Code extension).

## Files

- **[vim-cheat-sheet.md](vim-cheat-sheet.md)** — printable Vim cheat sheet in markdown, easy to convert to PDF (pandoc commands included at the bottom of the sheet).
- **[flashcards.json](flashcards.json)** — atomic, game-style flashcards derived from the cheat sheet. Each front is a small concrete challenge (a code snippet, a cursor position, a goal); each card has exactly one answer — a single shortcut or command. Only stock Vim/Neovim commands — cards requiring plugin installation (vim-visual-multi, fzf.vim, Telescope, LSP rename) are intentionally excluded. Each card has:
  - `frontText` — task description (markdown)
  - `backText` — the keys/command to use, a short description, and a link to the Vim reference docs (markdown)
  - `category` — the cheat sheet topic the card belongs to
  - `id` — stable unique id

## Status

| Category | Cards |
| --- | --- |
| Basic Navigation | 29 |
| Line Operations | 12 |
| Multi-Cursor Editing | 4 |
| Visual Block (Column) Editing | 8 |
| Indentation | 10 |
| Pasting Code | 5 |
| Brackets & Text Objects | 8 |
| Find & Replace | 14 |
| Rename Variable | 2 |
| File Switching | 10 |
| **Total** | **102** |

Expected JSON schema:

```json
[
  {
    "id": "Stable unique id (required)",
    "frontText": "Question (Markdown)",
    "backText": "Answer (Markdown)",
    "category": "Optional category"
  }
]
```
