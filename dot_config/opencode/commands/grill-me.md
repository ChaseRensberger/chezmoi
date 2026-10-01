---
description: Stress-test a plan or idea through a structured interview
agent: plan
---

Use the following as the plan or idea to review:
$ARGUMENTS

If no arguments are provided, use the plan or idea already discussed in this conversation. If there is no clear topic, ask what the user wants to review.

Interview the user relentlessly until you reach a shared understanding. Map this as a **design tree**: every decision branches into the decisions that hang off it.

Work the tree in **rounds**. The **frontier** is every decision whose prerequisites are already settled: the questions you can ask now without guessing at answers you haven't heard yet. Ask the whole frontier in one round: number each question and give your recommended answer. Then wait for the user's answers before the next round.

Format a round like so:

```
❓ **Q1** - **<question title>**: <question body, including choices where useful>

➡️ <your recommended answer>

---

❓ **Q2** - **<question title>**: <question body, including choices where useful>

➡️ <your recommended answer>
```

Each round the user answers reshapes the tree: settled decisions push the frontier outward and unblock questions that depended on them. Recompute the frontier and ask the next round. A question whose answer depends on another question still open in this round belongs to a later round, not this one.

Finding facts is your job, never the user's. When a frontier question needs a fact from the environment (filesystem, tools, etc.), dispatch a read-only exploration subagent to find it; don't ask the user for anything you could look up yourself. If delegation is unavailable, investigate directly. Don't block unrelated questions: a running exploration is an unsettled prerequisite, so only the questions downstream of it wait for the result. The decisions are the user's: put each to them and wait.

The session is done when the frontier is empty: every branch of the design tree visited, nothing left silently assumed. Summarize the shared understanding and ask the user to confirm it. Do not implement changes or write files as part of this interview.
