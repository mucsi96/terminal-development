# Vim Cheat Sheet

A practical, printable reference. In Vim, most commands work in **Normal mode**
(press `Esc` to get there). `Insert mode` is for typing text.

> **Convert to PDF:** see [Printing to PDF](#printing-to-pdf) at the bottom.

---

## Basic Navigation

Move around without leaving the home row.

| Key | Action |
| --- | --- |
| `h` `j` `k` `l` | Left, Down, Up, Right |
| `w` / `b` | Next / previous word start |
| `e` / `ge` | Next / previous word end |
| `0` / `^` / `$` | Start of line / first non-blank / end of line |
| `gg` / `G` | First line / last line of file |
| `{N}G` or `:{N}` | Jump to line number `N` |
| `Ctrl-d` / `Ctrl-u` | Half page down / up |
| `Ctrl-f` / `Ctrl-b` | Full page forward / back |
| `%` | Jump to matching bracket (see below) |
| `{` / `}` | Previous / next paragraph (blank line) |
| `H` / `M` / `L` | Top / middle / bottom of screen |
| `f{c}` / `F{c}` | Jump forward / back to char `c` on line |
| `t{c}` / `T{c}` | Jump just before / after char `c` |
| `;` / `,` | Repeat last `f`/`t` forward / backward |
| `zz` / `zt` / `zb` | Center / top / bottom current line on screen |
| `Ctrl-o` / `Ctrl-i` | Jump back / forward in jump history |

---

## Delete Line, Insert Line, Copy Lines

### Deleting

| Command | Action |
| --- | --- |
| `dd` | Delete (cut) current line |
| `{N}dd` | Delete `N` lines |
| `D` | Delete from cursor to end of line |
| `dw` | Delete to next word |
| `x` / `X` | Delete character under / before cursor |
| `d}` | Delete to end of paragraph |

### Inserting

| Command | Action |
| --- | --- |
| `i` / `a` | Insert before / after cursor |
| `I` / `A` | Insert at line start / line end |
| `o` / `O` | Open new line below / above and insert |
| `Esc` | Return to Normal mode |

### Copy (yank) & Paste

| Command | Action |
| --- | --- |
| `yy` or `Y` | Yank (copy) current line |
| `{N}yy` | Yank `N` lines |
| `yw` / `y$` | Yank word / to end of line |
| `p` / `P` | Paste after / before cursor |

**Copy selected lines and paste them after a target line:**

1. `Vjjy` — visually select lines and yank (or `{N}yy`).
2. Move to the target line.
3. `p` — the yanked lines are pasted **after** the current line.

Line-wise yanks always paste as whole lines: `p` puts them below, `P` above.

---

## Multi-Cursor Editing

Vim has no true multiple cursors, but these idioms cover the same ground.

### The `.` repeat + dot workflow

| Command | Action |
| --- | --- |
| `ciw` `new` `Esc` | Change inner word to `new` |
| `n` | Jump to next search match |
| `.` | Repeat the last change |

Search for the word (`*` or `/word`), edit the first with `ciw...Esc`, then
alternate `n` and `.` to apply the same change to each occurrence.

### Edit the same column across many lines (Visual Block)

| Command | Action |
| --- | --- |
| `Ctrl-v` | Start Visual Block selection |
| `j` / `k` | Extend selection down / up |
| `I{text}` `Esc` | Insert `text` at start of every selected line |
| `A{text}` `Esc` | Append `text` at end of every selected line |
| `c{text}` `Esc` | Replace the block on every line |

> The inserted text appears on all lines only **after** you press `Esc`.

### Apply a command to all matching lines

```vim
:%s/\<old\>/new/g        " replace on every line
:g/pattern/normal Aend   " append 'end' to each matching line
```

**Plugin alternative:** `vim-visual-multi` gives genuine multiple cursors —
`Ctrl-n` selects the word and each press adds the next occurrence as a cursor.

---

## Column Selection & Editing (Visual Block)

`Ctrl-v` selects a rectangular block, ideal for columns of text.

| Command | Action |
| --- | --- |
| `Ctrl-v` | Enter Visual Block mode |
| `j` `k` `h` `l` | Grow the block in any direction |
| `$` | Extend block to end of each line (ragged) |
| `I` … `Esc` | Insert before the block on all lines |
| `A` … `Esc` | Append after the block on all lines |
| `c` … `Esc` | Change the block on all lines |
| `d` / `x` | Delete the selected column block |
| `y` | Yank the block |
| `r{c}` | Replace every char in block with `c` |
| `~` / `u` / `U` | Toggle / lower / upper case of block |

**Example — comment out a block of lines:**
`Ctrl-v`, select the lines with `j`, then `I# ` and `Esc`.

---

## Tabulation & Indentation

### Indenting

| Command | Action |
| --- | --- |
| `>>` / `<<` | Indent / un-indent current line |
| `{N}>>` | Indent `N` lines |
| `>}` | Indent to end of paragraph |
| `>i{` | Indent inside the current `{ }` block |
| `=` | Auto-indent selection |
| `gg=G` | Re-indent the whole file |
| `Vjj>` | Indent a visual selection (`.` repeats) |

In Visual mode, `>` and `<` shift the whole selection; press `.` to shift again.

### Tabs vs. spaces settings

```vim
:set expandtab      " use spaces instead of tab characters
:set noexpandtab    " use real tab characters
:set tabstop=4      " a tab is displayed as 4 columns
:set shiftwidth=4   " >> shifts by 4 columns
:set softtabstop=4  " Tab key inserts 4 columns of whitespace
:retab              " convert existing tabs per current settings
```

---

## Pasting Code (without mangled indentation)

When pasting into a terminal Vim, auto-indent can cascade and wreck the layout.

| Command | Action |
| --- | --- |
| `:set paste` | Turn off auto-indent/auto-format for pasting |
| `:set nopaste` | Turn it back on when done |
| `"+p` | Paste from the system clipboard |
| `"+y` | Yank into the system clipboard |
| `Ctrl-r +` | Paste system clipboard while in Insert mode |
| `Ctrl-r "` | Paste last yank while in Insert mode |

**Recommended flow:**

```vim
:set paste
i            " enter insert mode, paste with your terminal (Ctrl-Shift-V)
<Esc>
:set nopaste
```

> Modern Vim/Neovim with `clipboard=unnamedplus` and bracketed paste often
> handles this automatically — try a normal `"+p` first.

---

## Finding Matching Parentheses

| Command | Action |
| --- | --- |
| `%` | Jump between matching `()`, `[]`, `{}` |
| `di(` or `dib` | Delete inside the parentheses |
| `da(` or `dab` | Delete parentheses and contents |
| `ci{` or `ciB` | Change inside `{ }` block |
| `yi[` | Yank inside `[ ]` |
| `vi(` | Visually select inside `( )` |
| `[(` / `])` | Jump to unmatched enclosing `(` / `)` |
| `[{` / `]}` | Jump to unmatched enclosing `{` / `}` |

`:set showmatch` briefly highlights the matching bracket as you type one.
The `i`/`a` object (inner/around) works with any pair: `(` `[` `{` `<` `"` `'`.

---

## Find & Replace

### Search within a file

| Command | Action |
| --- | --- |
| `/pattern` | Search forward |
| `?pattern` | Search backward |
| `n` / `N` | Next / previous match |
| `*` / `#` | Search word under cursor forward / back |
| `:set hlsearch` | Highlight all matches |
| `:set ignorecase` | Case-insensitive search |
| `:noh` | Clear search highlight |

### Substitute within a file

```vim
:s/old/new/           " replace first match on current line
:s/old/new/g          " replace all matches on current line
:%s/old/new/g         " replace all matches in the file
:%s/old/new/gc        " ...with confirmation for each (y/n/a/q)
:%s/\<word\>/new/g    " whole-word match only
:10,20s/old/new/g     " only on lines 10 through 20
:'<,'>s/old/new/g     " only within a visual selection
```

### Find & replace across the whole project

**Using Vim's built-in `vimgrep` + `cdo`:**

```vim
:vimgrep /pattern/gj **/*.js   " search all .js files, populate quickfix
:copen                          " open the quickfix list
:cdo s/old/new/g | update       " run substitution on every match & save
```

**Using external grep (faster on large trees):**

```vim
:grep -rn "pattern" .           " uses grepprg (ripgrep if configured)
:cdo s/old/new/gc | update
```

> Set `:set grepprg=rg\ --vimgrep` to use ripgrep. Plugins like
> **fzf.vim** (`:Rg`) or **telescope.nvim** make project-wide search far nicer.

---

## Rename a Variable

### Within one file (all occurrences)

```vim
:%s/\<oldName\>/newName/g       " every occurrence, whole word
:%s/\<oldName\>/newName/gc      " confirm each one
```

`\<` and `\>` are word boundaries, so `oldName` won't match inside `oldNameX`.

### Interactive, occurrence-by-occurrence

1. Put the cursor on the variable.
2. `*` to search for it.
3. `ciw` type the new name, then `Esc`.
4. Press `n` then `.` to update each remaining occurrence.

### Scope-aware rename (LSP, in Neovim)

With a language server attached, a true semantic rename respects scope:

```vim
:lua vim.lsp.buf.rename()       " default key is often  grn  or  <leader>rn
```

This renames only the actual symbol references, not lookalike text — the
safest option for real code.

---

## Printing to PDF

Render this Markdown to a printable PDF with any of these:

```sh
# Using pandoc (nice typography)
pandoc vim-cheatsheet.md -o vim-cheatsheet.pdf

# Landscape, smaller margins — fits more per page
pandoc vim-cheatsheet.md -o vim-cheatsheet.pdf \
  -V geometry:landscape -V geometry:margin=1.5cm

# Using a Markdown viewer: open the file and use the browser's
# "Print > Save as PDF". VS Code's "Markdown PDF" extension also works.
```

---

*Tip: press `Esc` when in doubt, and `:q!` to quit without saving.*
