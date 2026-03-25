# Work Log

- 2026-03-24: Moved Lighthouse reports from `docs/perf/lighthouse/` to `docs/lighthouse/` and standardized folder layout.
  [2026-03-24] — Step 2: Lighthouse folder standardized — moved JSON reports from docs/perf/lighthouse/ to docs/lighthouse/
  [2026-03-24] — Step 6: Images moved to public/images/ — src/assets/imgs/ removed
  [2026-03-24] — Step 7: VITE* renamed to NUXT_PUBLIC* in .env example files
  [2026-03-24] — Step 11: Deploy scripts updated — dist/ replaced with .output/public/
  [2026-03-24] — Step 3: Nuxt 3 SSG initialized — nuxt.config.ts created, dependencies installed, CSS assets copied
  [2026-03-24] — Step 4: Session B migration — created `app.vue`, `layouts/default.vue`, `pages/index.vue`; updated `HomeSection.vue` image paths; ran `nuxi generate` (SSG successful)
  [2026-03-24] — NavBar SSR fix + build verification — components/NavBar.vue, .output/public confirmed
  [2026-03-25] — Steps 8-9: nginx config updated, Lighthouse baseline recorded — docs/nginx-production.example.conf, docs/nginx-staging.example.conf, docs/lighthouse/index-2026-03-24-mobile.json, docs/lighthouse/index-2026-03-24-desktop.json
  [2026-03-25] — Session D closeout: migration marked complete, legacy Vite files removed, deploy/docs finalized — docs/SESSION_HANDOFF.md
  [2026-03-25] — SEO fundamentals added: canonical, lang, OG tags, analytics plugin, robots.txt and sitemap verified
  [2026-03-25] — Copy updates: hero subheader, section headers, production section opener, contact CTA
