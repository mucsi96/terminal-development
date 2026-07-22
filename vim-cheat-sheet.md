# Vim Cheat Sheet

> Commands are for Normal mode unless stated otherwise. `Ctrl-x` means hold Ctrl and press x.
> Sections marked *(plugin)* need the named plugin; everything else works in stock Vim/Neovim.

---

## 1. Basic Navigation

| Key | Action |
|---|---|
| `h` `j` `k` `l` | Left, down, up, right |
| `w` / `b` | Next / previous word start |
| `e` | End of word |
| `0` / `^` / `$` | Line start / first non-blank / line end |
| `gg` / `G` | First / last line of file |
| `42G` or `:42` | Jump to line 42 |
| `{` / `}` | Previous / next empty line (paragraph) |
| `Ctrl-d` / `Ctrl-u` | Scroll half page down / up |
| `Ctrl-f` / `Ctrl-b` | Scroll full page down / up |
| `H` / `M` / `L` | Top / middle / bottom of screen |
| `zz` | Center current line on screen |
| `f x` / `F x` | Jump to next / previous `x` in line (`;` repeat, `,` reverse) |
| `Ctrl-o` / `Ctrl-i` | Jump back / forward in jump history |
| `` `. `` | Jump to last edit position |

---

## 2. Lines: Delete, Insert, Copy & Paste

| Key | Action |
|---|---|
| `dd` | Delete (cut) current line |
| `3dd` | Delete 3 lines |
| `D` | Delete from cursor to end of line |
| `o` / `O` | Insert new line below / above and enter Insert mode |
| `yy` | Yank (copy) current line |
| `3yy` | Yank 3 lines |
| `p` / `P` | Paste after / before current line |
| `V` then `j`/`k`, then `y` | Select lines visually, then yank them |
| `V` … `d` | Select lines visually, then delete them |
| `J` | Join line below onto current line |

**Copy selected lines after another line:** select with `V`, press `y`, move to the target line, press `p` — the copied lines are inserted below it.

**Move (not copy):** same flow but use `d` instead of `y`.

**Ranges without visual mode:** `:5,9y` yank lines 5–9, `:5,9d` delete them, `:5,9t20` copy them after line 20, `:5,9m20` move them after line 20.

---

## 3. Multi-Cursor Editing

Vim's native "multi-cursor" is **repeat an edit over each match**:

| Key | Action |
|---|---|
| `*` | Search for word under cursor |
| `cgn` | Change the next match (type replacement, `Esc`) |
| `.` | Repeat that change on the next match |
| `n` then `.` | Skip a match, then apply to the following one |

Workflow: put the cursor on a word → `*` → `cgn` → type new text → `Esc` → press `.` for every further occurrence you want to change (or `n` to skip one).

*(plugin)* **vim-visual-multi** gives true multiple cursors:

| Key | Action |
|---|---|
| `Ctrl-n` | Select word under cursor; press again to add next occurrence |
| `q` | Skip current occurrence and get the next one |
| `Q` | Remove current cursor/selection |
| `Ctrl-Down` / `Ctrl-Up` | Add a cursor on the line below / above |
| `Esc` | Exit multi-cursor mode |

---

## 4. Column (Visual Block) Selection & Editing

| Key | Action |
|---|---|
| `Ctrl-v` | Start Visual Block mode (column selection) |
| `h j k l` / `f x` / `$` | Extend the block |
| `I` … `Esc` | Insert text at the *left* edge of every selected line |
| `A` … `Esc` | Append text at the *right* edge of every selected line |
| `c` … `Esc` | Change (replace) the selected block on every line |
| `d` or `x` | Delete the selected column |
| `r x` | Replace every selected character with `x` |
| `$` then `A` | Ragged-right block: append at each line's *own* end |
| `g Ctrl-a` | Turn a column of the same number into an increasing sequence |

Typical use: comment out a block — `Ctrl-v`, `j j j` to select the first column of 4 lines, `I// ` `Esc`.

---

## 5. Tabulation / Indentation

| Key | Action |
|---|---|
| `>>` / `<<` | Indent / un-indent current line |
| `3>>` | Indent 3 lines |
| `>` / `<` (Visual mode) | Indent / un-indent selection (`gv` reselects to repeat, or press `.`) |
| `=` (Visual mode) | Auto-indent selection |
| `==` | Auto-indent current line |
| `gg=G` | Re-indent the whole file |
| `Ctrl-t` / `Ctrl-d` (Insert mode) | Indent / un-indent current line while typing |
| `:retab` | Convert tabs ↔ spaces according to settings |

Recommended settings (`~/.vimrc`):

```vim
set expandtab      " insert spaces instead of tabs
set shiftwidth=4   " indent width for >> << =
set tabstop=4      " how wide a tab character displays
set softtabstop=4  " how many columns Tab key inserts
```

---

## 6. Pasting Code (Without Broken Indentation)

| Key / Command | Action |
|---|---|
| `"+p` / `"+y` | Paste from / yank to the system clipboard |
| `"*p` | Paste from the X11 primary selection (Linux middle-click) |
| `:set paste` → paste → `:set nopaste` | Disable auto-indent while pasting from terminal (classic Vim) |
| `]p` | Paste and adjust indentation to the current line |
| `=` after pasting (`` `[v`] = ``) | Re-indent what was just pasted |
| `gv` | Re-select the last selection |

Notes:
- **Neovim** and any Vim with clipboard support: just use `"+p` — no paste mode needed.
- `set clipboard=unnamedplus` makes `y`, `d`, `p` use the system clipboard automatically.
- In terminals, prefer `"+p` over the terminal's own paste shortcut to avoid indent cascade.

---

## 7. Matching Parentheses / Brackets

| Key | Action |
|---|---|
| `%` | Jump between matching `( )`, `[ ]`, `{ }` (cursor on or before one) |
| `di(` / `di{` / `di[` | Delete everything *inside* the parens / braces / brackets |
| `da(` | Delete everything *including* the parens |
| `ci(` / `ci"` / `ci'` | Change inside parens / double quotes / single quotes |
| `yi(` | Yank inside parens |
| `vi{` / `va{` | Visually select inside / around braces |
| `[(` / `])` | Jump to previous unmatched `(` / next unmatched `)` |
| `[{` / `]}` | Jump to previous unmatched `{` / next unmatched `}` |

Enable `%` for HTML tags and `if/endif`-style pairs: `:packadd! matchit` (built in).

---

## 8. Find & Replace

### Within the current file

| Command | Action |
|---|---|
| `/pattern` / `?pattern` | Search forward / backward (`n` next, `N` previous) |
| `*` / `#` | Search word under cursor forward / backward |
| `:%s/old/new/g` | Replace all occurrences in the file |
| `:%s/old/new/gc` | Replace all, asking for confirmation each time (`y/n/a/q`) |
| `:5,20s/old/new/g` | Replace only in lines 5–20 |
| `:'<,'>s/old/new/g` | Replace only inside the visual selection |
| `:%s/\<old\>/new/g` | Whole-word match only |
| `:noh` | Clear search highlighting |

### Across the project

Stock Vim — search with grep, then apply one substitution to every file in the quickfix list:

```vim
:grep -r 'old' src/          " or :vimgrep /old/ **/*.js
:copen                       " review matches in the quickfix window
:cfdo %s/old/new/g | update  " replace in every matched file and save
```

`:cnext` / `:cprev` step through matches one by one.

*(plugin)* With **fzf.vim** use `:Rg old`, with **Telescope** (Neovim) use `:Telescope live_grep` — then send results to quickfix and run the same `:cfdo`.

---

## 9. Rename a Variable

**Scope-aware (best, Neovim with LSP):**

| Key / Command | Action |
|---|---|
| `:lua vim.lsp.buf.rename()` | Rename symbol project-wide via the language server |
| `grn` | Default LSP rename mapping (Neovim 0.11+) |

**Current function only (stock Vim):** `gd` to go to the definition, then
`[{` `V` `%` to select the block, then `:s/\<old\>/new/g`.

**Whole file (stock Vim):** cursor on the variable → `*` → `:%s//new/g`
(an empty search pattern reuses the last search — no retyping, whole-word safe).

**Interactive:** `*` then `cgn` + new name + `Esc`, then `.` to confirm each next occurrence, `n` to skip.

---

## 10. Switching Between Files & Fuzzy Finding

### Stock Vim

| Key / Command | Action |
|---|---|
| `Ctrl-^` (Ctrl-6) | Toggle between the two most recent files |
| `:e path/to/file` | Open a file (Tab completes) |
| `:find name` | Find a file on `path` (set `set path+=**` for recursive) |
| `:ls` | List open buffers |
| `:b partial` | Switch to buffer by partial name (Tab cycles matches) |
| `:bn` / `:bp` | Next / previous buffer |
| `:bd` | Close (delete) current buffer |

Poor man's fuzzy finder — add to `~/.vimrc`:

```vim
set path+=**          " :find searches recursively
set wildmenu          " visual menu for Tab completion
set wildoptions=fuzzy " fuzzy matching in the wildmenu (Vim 9 / Neovim)
```

Then `:find usrctl` + `Tab` can match `src/user_controller.js`.

### *(plugin)* fzf.vim (Vim) / Telescope (Neovim)

| Command | Action |
|---|---|
| `:Files` / `:Telescope find_files` | Fuzzy-search file names in the project |
| `:GFiles` / `:Telescope git_files` | Only git-tracked files |
| `:Buffers` / `:Telescope buffers` | Fuzzy-switch between open buffers |
| `:Rg text` / `:Telescope live_grep` | Fuzzy-search file *contents* |
| `:History` / `:Telescope oldfiles` | Recently opened files |

Common mapping: `nnoremap <C-p> :Files<CR>` (or `:Telescope find_files<CR>`), so `Ctrl-p` opens the fuzzy finder — type a few characters of the file name and press Enter.

---

## Converting This Sheet to PDF

**With the Nix flake in this repo** (works on WSL, Linux, macOS — no manual LaTeX setup):

```sh
nix develop               # shell with pandoc + xelatex + fonts

pandoc vim-cheat-sheet.md -o vim-cheat-sheet.pdf \
  --pdf-engine=xelatex \
  -V mainfont="DejaVu Serif" -V monofont="DejaVu Sans Mono" \
  -V geometry:margin=1.5cm -V fontsize=10pt

# landscape with tight margins for a denser printout:
pandoc vim-cheat-sheet.md -o vim-cheat-sheet.pdf \
  --pdf-engine=xelatex \
  -V mainfont="DejaVu Serif" -V monofont="DejaVu Sans Mono" \
  -V geometry:landscape,margin=1cm -V fontsize=9pt
```

If flakes aren't enabled yet, either add `experimental-features = nix-command flakes`
to `~/.config/nix/nix.conf`, or prefix once:
`nix --experimental-features 'nix-command flakes' build`.

**Without Nix** (Debian/Ubuntu/WSL):

```sh
sudo apt install pandoc texlive-xetex texlive-fonts-recommended fonts-dejavu

pandoc vim-cheat-sheet.md -o vim-cheat-sheet.pdf \
  --pdf-engine=xelatex \
  -V mainfont="DejaVu Serif" -V monofont="DejaVu Sans Mono" \
  -V geometry:margin=1.5cm -V fontsize=10pt
```

Note: use `--pdf-engine=xelatex` (not the default `pdflatex`) — this sheet contains
Unicode characters (`→`, `↔`, `…`) that pdflatex cannot handle.

Alternatives without LaTeX: open the file in VS Code and use a "Markdown PDF" extension, or `grip vim-cheat-sheet.md` and print from the browser.
