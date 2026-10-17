# Agent instructions

## Flashcard answers

The automated AI-based solution checker compares a user's typed answer with the accepted solutions in the card's `backText`. Each solution is a complete valid answer; Markdown code fences format it for display and are not part of the typed answer.

- Every card in `flashcards.json` tests one operation. Whenever Vim provides a valid abbreviated form or compact built-in alias, always list both the full form and its shorter form in `backText`. Fully expand Ex command names in the first block and preserve previously accepted equivalent spellings.
- Put each accepted spelling in its own fenced code block containing a single nonempty line with only the Vim command or shortcut. Any one block is a valid answer; the blocks are alternatives, not a sequence to execute. Examples include `:edit` and `:e`, `:chdir` and `:cd`, and `Ctrl-w Ctrl-w` and `Ctrl-w w`. Terminal cards must also retain `:botright term` and `:bo term`, and `:botright vertical term` and `:bo vert ter`, alongside fully expanded forms using `terminal`.
- When there is no distinct shorter spelling, such as for single-key motions, `Ctrl-d`, or line addresses like `:32` and `:$`, use one canonical fenced answer. Do not invent abbreviations or duplicate an answer merely to create a second block.
- Use a `vim` language tag for Ex commands and an untagged code fence for shortcuts. Do not include prose, reference links, unrelated alternative answers, explanatory annotations, or any text outside the code blocks in `backText`.
- For Ex commands, include the leading `:` and concrete arguments matching the question, such as `:edit src/utils/format.js`, `:cd ~/project`, or `:botright term`. Omit `<Enter>`; executing the command is implicit.
- Use `Ctrl-d` notation for Ctrl shortcuts and spaces between successive shortcuts, such as `Ctrl-w Ctrl-w`.
- If the solution involves holding a key, describe holding it in `frontText` and put only the key inside the `backText` code block, such as `j`.
- Keep questions concrete and atomic, with enough context in `frontText` to identify the expected solution. Do not require the full command name when an accepted abbreviation is listed. Supporting explanations belong in `frontText` or the cheat sheet.
- Apply these rules to new, edited, and restored cards. Normalize historical answers before restoring them.

Preserve stable card IDs and keep the category counts and total in `README.md` in sync with `flashcards.json`. Validate the JSON, unique IDs, fenced format with one solution line per accepted spelling, and full/abbreviated-form coverage after editing cards.
