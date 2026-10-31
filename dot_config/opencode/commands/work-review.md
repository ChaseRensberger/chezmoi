---
description: Review the whole task and verify its acceptance criteria
subagent: false
---

Review the task from optional guidance, earlier messages, and its local record.
Use OpenCode's built-in `/review` principles without replacing that command.

1. Establish the target. By default, review all task changes since the recorded starting commit, including staged, unstaged, and untracked files.
2. Read changed files in full. Inspect relevant callers, tests, and repository instructions. A diff alone is not enough.
3. Find concrete bugs, security issues, broken error handling, unintended behavior changes, and violations of established patterns.
4. Investigate uncertain findings. Explain the realistic input or environment that causes each defect. Do not report speculation as a bug.
5. Flag performance problems only when the impact is clear. Avoid style preferences and unrelated pre-existing defects.
6. Run required repository checks and task-specific tests against the acceptance criteria. Confirm server isolation before sending requests.
7. Report actionable findings first, with severity and file locations. Then report acceptance criteria, check results, skipped checks, and remaining user decisions.
8. Record the reviewed commit, fingerprints of uncommitted changes, and verification results in the local task record.

Do not edit source code, stage changes, commit, or publish during review.

User guidance:
$ARGUMENTS
