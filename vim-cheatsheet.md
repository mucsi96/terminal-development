# VIM Cheat Sheet

> Keys are case-sensitive: `G` means `Shift+g`. `Ctrl-v` is written as `<C-v>`.
> Commands starting with `:` are typed in command-line mode and finished with `Enter`.

---

## 1. Basic Navigation

| Keys | Action |
|------|--------|
| `h` `j` `k` `l` | Left / down / up / right |
| `w` / `b` | Next / previous word start |
| `e` | End of current word |
| `0` / `^` / `$` | Line start / first non-blank char / line end |
| `gg` / `G` | First / last line of file |
| `42G` or `:42` | Jump to line 42 |
| `{` / `}` | Previous / next empty line (paragraph) |
| `<C-d>` / `<C-u>` | Scroll half page down / up |
| `<C-f>` / `<C-b>` | Scroll full page down / up |
| `zz` | Center current line on screen |
| `H` / `M` / `L` | Top / middle / bottom of visible screen |
| `f x` / `F x` | Jump to next / previous `x` on the line (`;` repeats, `,` reverses) |
| `<C-o>` / `<C-i>` | Jump back / forward in jump history |
| `''` (two quotes) | Back to line before the last jump |

---

## 2. Delete Line, Insert Line, Copy Lines

### Delete (cut)

| Keys | Action |
|------|--------|
| `dd` | Delete current line (goes to register — can be pasted) |
| `5dd` | Delete 5 lines |
| `dj` / `dk` | Delete current line + line below / above |
| `D` | Delete from cursor to end of line |
| `:10,20d` | Delete lines 10–20 |

### Insert new line

| Keys | Action |
|------|--------|
| `o` | Open new line **below**, enter insert mode |
| `O` | Open new line **above**, enter insert mode |
| `i` / `a` | Insert before / after cursor |
| `I` / `A` | Insert at line start / line end |

### Copy (yank) and paste selected lines

| Keys | Action |
|------|--------|
| `yy` | Yank (copy) current line |
| `5yy` | Yank 5 lines |
| `V` then move, then `y` | Select whole lines visually, then yank |
| `p` | Paste **after** cursor / below current line |
| `P` | Paste **before** cursor / above current line |
| `:10,20t.` | Copy lines 10–20 to below the current line |
| `:t.` | Duplicate current line |

**Workflow — copy selected lines after another place:**
`V` → extend with `j`/`k` → `y` → move cursor to target line → `p`

---

## 3. Multi-Cursor Editing (Vim-native ways)

Vim has no built-in multiple cursors, but these achieve the same result:

### `cgn` — change next match, repeat with `.`

1. Put cursor on a word, press `*` (search for word under cursor)
2. `cgn` — change the next match, type replacement, press `Esc`
3. Press `.` to apply to the next match, or `n` to skip one

### `:normal` on a range — run keystrokes on many lines

| Command | Action |
|---------|--------|
| `:'<,'>norm A;` | Append `;` to end of every selected line |
| `:'<,'>norm I// ` | Insert `// ` at start of every selected line |
| `:%norm dw` | Delete first word of every line in file |

(Select lines with `V` first — the `'<,'>` range appears automatically.)

### Macros — record once, replay anywhere

| Keys | Action |
|------|--------|
| `qa` … `q` | Record keystrokes into register `a`, stop with `q` |
| `@a` | Replay macro `a` |
| `10@a` | Replay 10 times |
| `:'<,'>norm @a` | Replay macro on every selected line |

> Plugin option: **vim-visual-multi** provides true multiple cursors (`<C-n>` to select next occurrence, like VS Code's `Ctrl+D`).

---

## 4. Column Selection and Editing (Visual Block)

| Keys | Action |
|------|--------|
| `<C-v>` | Start **visual block** (column) selection |
| `h j k l` / `$` | Extend the block (use `$` for ragged line ends) |
| `I` text `Esc` | Insert text **before** the block on all lines |
| `A` text `Esc` | Append text **after** the block on all lines |
| `c` text `Esc` | Change (replace) the block on all lines |
| `d` or `x` | Delete the column block |
| `r x` | Replace every char in block with `x` |
| `g <C-a>` | Turn a column of equal numbers into an increasing sequence |

**Workflow — comment out a block of lines:**
`<C-v>` → `j j j` (select first column of 4 lines) → `I` → type `# ` → `Esc`

**Workflow — add `,` to end of ragged lines:**
`<C-v>` → `3j` → `$` → `A` → type `,` → `Esc`

---

## 5. Tabulation (Indenting)

| Keys | Action |
|------|--------|
| `>>` / `<<` | Indent / un-indent current line by one `shiftwidth` |
| `5>>` | Indent 5 lines |
| `>` / `<` (in Visual mode) | Indent / un-indent selection (`gv` reselects to repeat) |
| `.` | Repeat last indent |
| `=` (in Visual mode) | Auto-indent selection per file type rules |
| `gg=G` | Re-indent the **whole file** |
| `==` | Auto-indent current line |
| `<C-t>` / `<C-d>` (in Insert mode) | Indent / un-indent while typing |

### Useful settings (put in `~/.vimrc`)

```vim
set tabstop=4       " a tab displays as 4 columns
set shiftwidth=4    " >> indents by 4
set expandtab       " insert spaces instead of tab chars
set autoindent      " keep indent of previous line
```

| Command | Action |
|---------|--------|
| `:retab` | Convert existing tabs ↔ spaces per current settings |
| `:set list` | Make tabs/trailing spaces visible (`:set nolist` to hide) |

---

## 6. Pasting Code (without broken indentation)

| Command / Keys | Action |
|----------------|--------|
| `:set paste` | Disable auto-indent before pasting from terminal — **then paste** |
| `:set nopaste` | Re-enable normal editing afterwards |
| `"+p` | Paste directly from **system clipboard** (no paste mode needed) |
| `"+y` | Yank selection **to** system clipboard |
| `]p` | Paste and adjust indentation to current line |
| `u` | Undo a botched paste |

> Modern Vim/Neovim with *bracketed paste* handles terminal pasting correctly
> without `:set paste`. Clipboard registers (`"+`) require Vim compiled with
> `+clipboard` (check via `vim --version | grep clipboard`).

```vim
" optional: use the system clipboard for all yanks/pastes
set clipboard=unnamedplus
```

---

## 7. Finding Matching Parentheses / Brackets

| Keys | Action |
|------|--------|
| `%` | Jump between matching `( )`, `[ ]`, `{ }` (cursor on or before one) |
| `[(` / `])` | Jump to previous unmatched `(` / next unmatched `)` |
| `[{` / `]}` | Jump to previous unmatched `{` / next unmatched `}` |
| `di(` / `da(` | Delete **inside** / **around** parentheses |
| `ci{` / `ci"` / `ci'` | Change inside braces / double quotes / single quotes |
| `vi(` / `va{` | Visually select inside parens / around braces |
| `y%` | Yank from cursor to the matching bracket |

> With the built-in **matchit** plugin (`:packadd! matchit` in `.vimrc`),
> `%` also jumps between `if/endif`, HTML tags, `do/end`, etc.

---

## 8. Find & Replace — in File and Across Project

### Search in current file

| Keys | Action |
|------|--------|
| `/pattern` | Search forward (`?pattern` = backward) |
| `n` / `N` | Next / previous match |
| `*` / `#` | Search word under cursor forward / backward |
| `:noh` | Clear search highlighting |

### Replace in current file

| Command | Action |
|---------|--------|
| `:s/old/new/` | Replace first match on current line |
| `:s/old/new/g` | Replace all matches on current line |
| `:%s/old/new/g` | Replace all matches in **whole file** |
| `:%s/old/new/gc` | Same, but **confirm** each (`y`/`n`/`a`=all/`q`=quit) |
| `:10,20s/old/new/g` | Replace only in lines 10–20 |
| `:'<,'>s/old/new/g` | Replace only in visual selection |
| `:%s/old/new/gi` | Case-insensitive replace |

### Replace across the project

```vim
" 1. Find all occurrences (populates the quickfix list)
:grep -r "old" --include="*.js" .
"    or built-in, no external grep needed:
:vimgrep /old/gj **/*.js

" 2. Review matches
:copen

" 3. Replace in every file that has a match, then save all
:cfdo %s/old/new/g | update
```

| Command | Action |
|---------|--------|
| `:copen` / `:cclose` | Open / close quickfix result list |
| `:cnext` / `:cprev` | Jump to next / previous match |
| `:cfdo <cmd>` | Run a command in **each file** in the quickfix list |

> Tip: install `ripgrep` and add `set grepprg=rg\ --vimgrep` for fast project search.

---

## 9. Rename a Variable

### Whole file (safe, word-boundary match)

```vim
:%s/\<oldName\>/newName/g
```

`\<` and `\>` match word boundaries, so `count` won't touch `counter`.
Add `c` (`:%s/\<oldName\>/newName/gc`) to confirm each change.

### Quick interactive rename with `.` repeat

1. Cursor on the variable → `*` (searches exact word)
2. `cgn` → type new name → `Esc`
3. `.` to rename next occurrence, `n` to skip

### Only inside current function/block

1. `vi{` — select inside the current `{ }` block (use `va{` from inside nested code)
2. `:'<,'>s/\<oldName\>/newName/g`

### Across the whole project

```vim
:grep -rw "oldName" .
:cfdo %s/\<oldName\>/newName/g | update
```

> In Neovim with LSP: `:lua vim.lsp.buf.rename()` performs a true
> semantic rename (scope-aware, project-wide). In Vim with coc.nvim: `<leader>rn`.

---

## Bonus: Essentials

| Keys | Action |
|------|--------|
| `u` / `<C-r>` | Undo / redo |
| `.` | Repeat last change |
| `:w` / `:q` / `:wq` / `:q!` | Save / quit / save+quit / quit without saving |
| `Esc` or `<C-[>` | Back to normal mode |
| `gv` | Re-select last visual selection |

---

*Convert to PDF: `pandoc vim-cheatsheet.md -o vim-cheatsheet.pdf` (or print the rendered markdown from your browser/editor).*
