# COPILOT_PROMPTS.md — egonzalezcortes.com

# This file contains only paste-ready prompts.

# Do not paste the headers or separator lines — only the blocks marked below.

---

## PROMPT 1 — SESSION OPENER

# Paste this at the start of every new Copilot Chat session.

---PASTE BELOW THIS LINE---

You are working on egonzalezcortes.com — a Nuxt 3 SSG portfolio site
for Edgar González-Cortés, a senior full-stack software engineer.

Before doing anything else, read these two files in this order:

1. docs/APP_FLOW.md — codebase map, tells you where everything lives
2. docs/SESSION_HANDOFF.md — last known state and current task

Do not read any other docs file unless a task explicitly requires it.
Do not scan the codebase to orient yourself — use APP_FLOW.md instead.

When you have read both files, confirm with one sentence:
"Ready. Last session: [one line from SESSION_HANDOFF]. Current task: [task]."
Then wait for my instruction.

---PASTE ABOVE THIS LINE---

---

## PROMPT 2 — TASK PROMPT TEMPLATE

# Paste this when giving Copilot a specific job.

# Replace everything in [brackets] before pasting.

---PASTE BELOW THIS LINE---

Task: [describe what needs to change in one sentence]
Files to change:

[filename]: [what to change]
[filename]: [what to change]

Reference docs if needed:

[doc name] for [specific reason]

Do not touch any file not listed above.
When done:

Post-deploy smoke test — if this task ends in a deploy, run these
checks and report all results before updating docs:

Spot check critical URLs return 200
Confirm redirects behave correctly
Confirm canonical tags present on key pages
Check browser console for errors on touched pages
Confirm Simple Analytics tag is present

Lighthouse — if this task touched layout, images, CSS, or anything
that could affect page weight or rendering, run headless Lighthouse
on the homepage and any directly affected page:
npx lighthouse [URL] --output json
--output-path ./docs/lighthouse/[page]-[YYYY-MM-DD].json
--preset mobile --chrome-flags="--headless"
Report the Performance score and LCP for each page run.
Create the /docs/lighthouse/ folder if it does not exist.
Sudo and interactive auth — any step requiring interactive password
input on the remote host must stop and wait. State explicitly:
"Run [command] and stop at the sudo prompt. Edgar will enter the
password." Never attempt to proceed past an interactive auth prompt.
Docs update — rewrite docs/SESSION_HANDOFF.md with today's date,
what was done, files changed, smoke test results, Lighthouse scores
if run, and next task. Append one line to docs/WORK_LOG.md:
[YYYY-MM-DD] — [what was done] — [files changed]

Deploy commands for this project:

Staging: npm run deploy:staging
Production: npm run deploy:prod
Never run the scripts in /scripts directly — always use npm run.

---PASTE ABOVE THIS LINE---

## PROMPT 3 — DOCS AUDIT

# Paste this once to bootstrap the docs system, or any time docs

# have drifted from the codebase. This is the longest prompt.

# Paste the entire block.

---PASTE BELOW THIS LINE---

Audit and rewrite the docs/ folder for this Nuxt 3 SSG portfolio site.
Your goal: make this folder a reliable navigation system for future
Copilot sessions so they can orient themselves without scanning
the codebase.

Complete every step in order. Do not skip any step.

STEP 1
Read every file in docs/ and scan the full project structure.
Note what each docs file currently contains and whether it matches
the actual codebase. Do not make any changes yet.

STEP 2
Rewrite docs/APP_FLOW.md using exactly this structure:

---

# APP_FLOW.md

# Last updated: [today's date]

# Purpose: tells Copilot where everything lives. Read this first.

## Business context

[3 sentences max: what the site is, who it serves, and what its
primary goal is — landing senior engineering roles and demonstrating
technical credibility]
Full strategy context: docs/STRATEGY.md (read only when explicitly needed)

## Pages — where copy data lives

| Page | File | Where copy data is | Notes |
| ---- | ---- | ------------------ | ----- |

[fill one row per page — use exact file paths and describe where
the h1, subhead, and main copy blocks are located in each file]

## Components — reusable pieces

| Component | File | Used on | Purpose |
| --------- | ---- | ------- | ------- |

[fill one row per component in components/ — include which pages
use it and what it does]

## Shared data files

[list any JSON, JS, or TS files that hold page content separately
from the Vue/Nuxt templates — note exact file paths]
[if no shared data files exist, write: "All copy is inline in Vue files"]

## Config files — touch with caution

| File                        | Purpose                                   | When to edit                       |
| --------------------------- | ----------------------------------------- | ---------------------------------- |
| nuxt.config.ts              | framework config, route rules, SSG preset | route/redirect/module changes only |
| public/sitemap.xml          | sitemap                                   | when adding or removing pages      |
| plugins/analytics.client.ts | Simple Analytics integration              | analytics changes only             |

## Deploy workflow

1. Make changes locally
2. npm run deploy:staging — builds and deploys to staging
3. Verify on staging, then: npm run deploy:prod
4. Verify live at https://egonzalezcortes.com
   Note: both commands call scripts in /scripts internally — never run those directly.

## Known gotchas

[pull any recurring issues or workarounds from ERROR_LOG.md and
list them here as short notes]

---

STEP 3
Rewrite docs/SESSION_HANDOFF.md using exactly this structure:

---

# SESSION_HANDOFF.md

# REWRITE THIS FILE at the end of every session. Never append.

## Last updated

[date]

## Current state

[2–3 sentences: what is deployed, what is in progress, what is pending]

## Files changed in last session

[list each file with one-line description of what changed]

## Next task

[one concrete action specific enough to execute without clarification]

## Blockers

[anything waiting on external action — GSC crawl, email verification,
platform setup, etc. Write "None" if clear.]

---

STEP 4
Verify docs/WORK_LOG.md is append-only and in chronological order.
Add any missing entries you can infer from the codebase git history
or from the current state of the files.
Format: [YYYY-MM-DD] — [what was done] — [files changed]

STEP 5
Do not touch docs/STRATEGY.md if it exists.
Do not touch docs/ERROR_LOG.md unless you found new errors in Step 1.

STEP 6
Report back with:

- Which docs files were out of sync with the codebase
- What you changed in each file
- Any gaps in APP_FLOW.md you could not fill (be specific about what
  you could not determine from the codebase alone)

---PASTE ABOVE THIS LINE---

---

## PROMPT 4 — HEADLESS LIGHTHOUSE TEST

# Paste this any time you want a fresh performance baseline.

# No brackets to replace — paste as-is.

---PASTE BELOW THIS LINE---

Run a headless Lighthouse audit against https://egonzalezcortes.com.

Steps:

1. Run mobile preset:
   npx lighthouse https://egonzalezcortes.com --output json \
    --output-path ./docs/lighthouse/homepage-[TODAY'S DATE]-mobile.json \
    --preset mobile --chrome-flags="--headless"

2. Run desktop preset:
   npx lighthouse https://egonzalezcortes.com --output json \
    --output-path ./docs/lighthouse/homepage-[TODAY'S DATE]-desktop.json \
    --preset desktop --chrome-flags="--headless"

3. Create /docs/lighthouse/ if it does not exist.

4. Report back with:

   - Mobile: Performance score, LCP, CLS, INP, TTFB
   - Desktop: Performance score, LCP, CLS, INP, TTFB
   - cf-cache-status header value from the response (confirms
     Cloudflare edge caching is active — should be HIT or MISS,
     not absent)

5. Append one line to docs/WORK_LOG.md:
   [YYYY-MM-DD] — Lighthouse audit run — docs/lighthouse/

Do not deploy anything. Do not change any source files.

---PASTE ABOVE THIS LINE---
