## Session History & Logging Rules

At the start of every new session:
1. Read `PROJECT_SUMMARY.md` to understand what was done in previous sessions and check the pending TODOs.

When ending a session:
- If the user hasn't asked to update `PROJECT_SUMMARY.md`, remind them to consider adding a new entry.
- Only write to `PROJECT_SUMMARY.md` when the user explicitly requests it.
- Don't make any "git status", "git add" or "git commit" commands if not explicitly requested.

### Logging Format Enforcement
When the user requests a log update, you MUST follow this precise Markdown structure:

## Session [Number] - [YYYY-MM-DD]

### Task
[Brief description of the initial user request]

### What was done
- [Bullet points of specific technical changes]
- [Compilation/build steps used]
- [Verification/Testing results]

### Files modified
- `filename` - [short description of changes]

### TODO / Next Steps
- [ ] [Immediate task for next session]
- [ ] [Refactoring or optimization needed]
- [ ] [Testing/Verification still pending]

### Notes
- [Important observations, warnings, or example outputs]
