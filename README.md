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
  - `backText` — Markdown containing one fenced code block with a single Vim command or shortcut, ready to compare with the user's typed answer
  - `category` — the cheat sheet topic the card belongs to
  - `id` — stable unique id

## Answer format for automated checking

An automated AI-based solution checker compares the user's typed answer with the solution in `backText`. Every card must store a single canonical solution in a Markdown code fence for readable display. The fences are presentation only; the command or shortcut inside is the expected typed answer.

- Use exactly one fenced code block containing a single nonempty line with only the command or shortcut. Use a `vim` language tag for Ex commands and an untagged fence for shortcuts.
- Omit explanations, links, alternative answers, annotations, and text outside the code block.
- For Ex commands, include the leading `:` and any concrete arguments required by the question, for example `:edit src/utils/format.js` or `:cd ~/project`. Pressing Enter to execute the command is implicit; omit `<Enter>` from the answer.
- Write Ctrl shortcuts as `Ctrl-d`. Separate successive shortcuts with a space, for example `Ctrl-w Ctrl-w`.
- If a key must be held, put that instruction in `frontText` and store only the key inside the `backText` code block, for example `j`.
- Keep any supporting context in `frontText` or the cheat sheet.

These requirements also apply when restoring cards from Git history. See [AGENTS.md](AGENTS.md) for agent instructions.

## Status

The active deck follows progress through Vim Masterclass on Coursera. Currently it covers the navigation commands in `~/Vim-Masterclass/nav.txt`, half-screen scrolling, opening files, changing Vim's working directory, and using the built-in terminal.

Add cards as further exercises are completed, preserving existing card IDs. Cards for later topics can be restored from Git history when those topics are reached.

| Category | Cards |
| --- | --- |
| Basic Navigation | 18 |
| File Switching | 2 |
| Terminal | 3 |
| **Total** | **23** |

Example JSON card:

```json
[
  {
    "id": "file-07",
    "frontText": "Open `src/utils/format.js` in the current Vim window. Use the full Ex command name.",
    "backText": "```vim\n:edit src/utils/format.js\n```",
    "category": "File Switching"
  }
]
```
