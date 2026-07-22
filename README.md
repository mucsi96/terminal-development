# terminal-development

Cheat sheet and flashcards for learning Vim, following the structure of [mucsi96/ckad](https://github.com/mucsi96/ckad).

## Files

- **[vim-cheat-sheet.md](vim-cheat-sheet.md)** — printable Vim cheat sheet in markdown, easy to convert to PDF (pandoc commands included at the bottom of the sheet).
- **[flashcards.json](flashcards.json)** — flashcards derived from the cheat sheet. Only stock Vim/Neovim commands — cards requiring plugin installation (vim-visual-multi, fzf.vim, Telescope, LSP rename) are intentionally excluded. Each card has:
  - `frontText` — task description (markdown)
  - `backText` — the keys/command to use, a short description, and a link to the Vim reference docs (markdown)
  - `category` — the cheat sheet topic the card belongs to
  - `id` — stable unique id

## Status

| Category | Cards |
| --- | --- |
| Basic Navigation | 9 |
| Line Operations | 6 |
| Multi-Cursor Editing | 2 |
| Visual Block (Column) Editing | 5 |
| Indentation | 5 |
| Pasting Code | 4 |
| Brackets & Text Objects | 4 |
| Find & Replace | 6 |
| Rename Variable | 2 |
| File Switching | 4 |
| **Total** | **47** |

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
