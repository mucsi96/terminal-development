# terminal-development

Cheat sheet and flashcards for learning Vim, following the structure of [mucsi96/ckad](https://github.com/mucsi96/ckad).

## Building the PDF

The repo ships a Nix flake with the full toolchain (pandoc + XeLaTeX + fonts), so on WSL/Linux/macOS with [Nix installed](https://nixos.org/download/):

```sh
nix build                 # → result/vim-cheat-sheet.pdf
nix build .#compact       # landscape variant with tight margins
nix develop               # shell with pandoc + LaTeX for manual runs
```

See the bottom of [vim-cheat-sheet.md](vim-cheat-sheet.md) for non-Nix alternatives.

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
