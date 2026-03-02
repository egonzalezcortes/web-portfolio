# Lighthouse Reports

This directory stores **kept** Lighthouse checkpoints (not every local run).

## What to keep

Keep only meaningful reports:

- One baseline report for a major period
- Milestone reports after significant performance/SEO changes
- One report near release/deploy validation

Avoid committing every ad-hoc run.

## Naming convention

Use this filename format:

`YYYY-MM-DD_target_scope_note.json`

Examples:

- `2026-03-02_prod_full_baseline.json`
- `2026-03-02_prod_perf_image-preload.json`
- `2026-03-02_staging_full_post-nginx-cache.json`

### Field meanings

- `YYYY-MM-DD`: date the run was taken
- `target`: `local`, `staging`, or `prod`
- `scope`: `full` (all categories) or focused (`perf`, `seo`, `bp`, `a11y`)
- `note`: short kebab-case context for the change tested

## Suggested workflow

1. Run multiple passes (3-5) for the same target.
2. Keep the median or representative pass.
3. Save only selected checkpoint files here.
4. Keep temporary runs in `tmp/lighthouse/` (ignored by git).
