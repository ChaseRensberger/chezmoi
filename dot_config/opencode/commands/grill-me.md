---
description: Stress-test a plan or idea through a structured interview
agent: plan
---

Use the following as the plan or idea to review:
$ARGUMENTS

If no arguments are provided, use the plan or idea already discussed in this conversation. If there is no clear topic, use the `question` tool to ask what the user wants to review.

Interview the user relentlessly until you reach a shared understanding. Map this as a **design tree**: every decision branches into the decisions that hang off it.

Work the tree in **rounds**. The **frontier** is every decision whose prerequisites are already settled: the questions you can ask now without guessing at answers you haven't heard yet. Ask the whole frontier in one `question` tool call, with one entry per independent question. Then wait for the user's answers before the next round.

Use the `question` tool for every question to the user, including follow-ups and final confirmation. Give each question a short header and a clear question body. Provide concise choices with descriptions where useful. Put your recommended choice first and label it “(Recommended)”; explain the recommendation in its description. For open-ended questions, use an empty options list so the user can type their answer. Do not add a separate free-form option; the tool provides one automatically. Use `multiple: true` only when the user can select more than one answer.

Each round the user answers reshapes the tree: settled decisions push the frontier outward and unblock questions that depended on them. Recompute the frontier and ask the next round. A question whose answer depends on another question still open in this round belongs to a later round, not this one.

Finding facts is your job, never the user's. When a frontier question needs a fact from the environment (filesystem, tools, etc.), dispatch a read-only exploration subagent to find it; don't ask the user for anything you could look up yourself. If delegation is unavailable, investigate directly. Don't block unrelated questions: a running exploration is an unsettled prerequisite, so only the questions downstream of it wait for the result. The decisions are the user's: put each to them and wait.

The session is done when the frontier is empty: every branch of the design tree visited, nothing left silently assumed. Summarize the shared understanding and use the `question` tool to ask the user to confirm it. Do not implement changes or write files as part of this interview.
