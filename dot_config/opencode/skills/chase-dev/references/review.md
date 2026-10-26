# Review the task

Use OpenCode's built-in `/review` principles without replacing that command.

1. Establish the review target. By default, review all task changes since the recorded starting commit, including staged, unstaged, and untracked files.
2. Read changed files in full and inspect relevant callers, tests, and repository instructions. A diff alone is not enough.
3. Find concrete bugs, security issues, broken error handling, unintended behavior changes, and violations of established patterns.
4. Investigate uncertain findings. Explain the realistic input or environment that causes each defect. Do not report speculation as a bug.
5. Flag performance problems only when the impact is clear. Avoid style preferences and unrelated pre-existing defects.
6. Run repository checks and task-specific tests that prove the acceptance criteria. Honor restrictions on browser automation.
7. For server checks, confirm the task's API target, credentials, ports, and data paths before sending requests.
8. Report actionable findings first, with severity and file locations. Then report acceptance criteria, check results, skipped checks, and remaining user decisions.

Do not edit source code, stage changes, commit, or publish during review.
Record the reviewed commit, the state of uncommitted changes, and check results in the local task record.
If source files change afterward, treat the affected review and checks as stale.
