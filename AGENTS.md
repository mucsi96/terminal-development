# Agent instructions

## Flashcard answers

The automated AI-based solution checker compares a user's typed answer with the solution in the card's `backText`. The solution is the expected input; Markdown code fences format it for display and are not part of the typed answer.

- Every card in `flashcards.json` must have exactly one canonical solution in `backText`: one Markdown fenced code block containing a single nonempty line with only the Vim command or shortcut.
- Use a `vim` language tag for Ex commands and an untagged code fence for shortcuts. Do not include prose, reference links, alternative answers, explanatory annotations, or any text outside the code block in `backText`.
- For Ex commands, include the leading `:` and concrete arguments matching the question, such as `:edit src/utils/format.js`, `:cd ~/project`, or `:botright term`. Omit `<Enter>`; executing the command is implicit.
- Use `Ctrl-d` notation for Ctrl shortcuts and spaces between successive shortcuts, such as `Ctrl-w Ctrl-w`.
- If the solution involves holding a key, describe holding it in `frontText` and put only the key inside the `backText` code block, such as `j`.
- Keep questions concrete and atomic, with enough context in `frontText` to identify the expected solution. Supporting explanations belong in `frontText` or the cheat sheet.
- Apply these rules to new, edited, and restored cards. Normalize historical answers before restoring them.

Preserve stable card IDs and keep the category counts and total in `README.md` in sync with `flashcards.json`. Validate the JSON, unique IDs, and single-solution fenced format after editing cards.
