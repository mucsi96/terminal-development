# Agent instructions

## Flashcard answers

The automated AI-based solution checker compares a user's typed answer with the card's `backText`. Treat `backText` as the expected input, not as an explanation.

- Every card in `flashcards.json` must have exactly one canonical solution in `backText`: a single plain-text line containing only the Vim command or shortcut.
- Do not include Markdown, code fences, prose, reference links, alternative answers, or explanatory annotations in `backText`.
- For Ex commands, include the leading `:` and concrete arguments matching the question, such as `:edit src/utils/format.js`, `:cd ~/project`, or `:botright term`. Omit `<Enter>`; executing the command is implicit.
- Use `Ctrl-d` notation for Ctrl shortcuts and spaces between successive shortcuts, such as `Ctrl-w Ctrl-w`.
- If the solution involves holding a key, describe holding it in `frontText` and put only the key in `backText`, such as `j`.
- Keep questions concrete and atomic, with enough context in `frontText` to identify the expected solution. Supporting explanations belong in `frontText` or the cheat sheet.
- Apply these rules to new, edited, and restored cards. Normalize historical answers before restoring them.

Preserve stable card IDs and keep the category counts and total in `README.md` in sync with `flashcards.json`. Validate the JSON, unique IDs, and answer-only format after editing cards.
