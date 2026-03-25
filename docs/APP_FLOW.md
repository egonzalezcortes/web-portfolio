# APP_FLOW.md

## Project

Personal portfolio migrated to Nuxt 3 SSG (static site generation); built with Nuxt/Vite and deployed by generating the static output (`.output/public/`) and serving it from an Nginx-hosted Linux server (deploy scripts rsync `.output/public/` to the target host).

## Stack

- Framework: Nuxt 3 (Vue 3)
- Build tool: Vite + Nitro prerender (SSG)
- CSS approach: Plain CSS files (`assets/css/base.css`, `assets/css/main.css`) with custom CSS variables and a self-hosted `Orbitron` font in `/public/fonts/`
- Deployment target: Linux server (DigitalOcean-like) with Nginx reverse proxy; deploy via `rsync` over SSH (scripts in `scripts/`)
- Analytics: optional runtime analytics via `src/lib/analytics.js` supporting `simple` or `ga4` providers (configured via `NUXT_PUBLIC_*` runtime env vars)

## Entry points

- `app.vue` — root app wrapper that renders the global `NavBar`, the page content (`<NuxtPage/>`) and `SiteFooter`.
- `layouts/default.vue` — default layout that includes `NavBar` and `SiteFooter` and wraps page `slot` in a `main` element.
- `pages/index.vue` — top-level home page that composes the sections: `HomeSection`, `AboutSection`, `CompetenciesSection`, `ExperienceSection`, `ProductionSection`, and `ContactSection`.

## Components

- `NavBar.vue` — site navigation bar with toggle, scroll-aware styling, and click-triggered section sound playback.
- `SiteFooter.vue` — footer with tech badges, back-to-top link, and year copyright.
- `HomeSection.vue` — hero section with responsive picture sources and a Three.js-powered canvas animation (deferred/opt-in for mobile/low-power devices).
- `AboutSection.vue` — "About Me" content and `SurfaceCard`-driven principles.
- `CompetenciesSection.vue` — lists core competencies grouped by Systems, Frontend, and Cloud with `TechBadge` icons.
- `ExperienceSection.vue` — professional experience cards rendered with `SurfaceCard` and `TechBadge` entries.
- `ProductionSection.vue` — notes about deployment and infrastructure, lists production tech badges.
- `ContactSection.vue` — contact block with email and LinkedIn links.
- `SectionWaveDivider.vue` — decorative SVG wave divider between sections.
- `SurfaceCard.vue` — reusable card component wrapping content and exposing accent/border/shadow props.
- `TechBadge.vue` — small badge component that imports SVG icons from `assets/tech-icons/` and displays a label.
- `components/icons/*` — small inline SVG icon components (`IconDocumentation.vue`, `IconSupport.vue`, `IconEcosystem.vue`, `IconCommunity.vue`, `IconTooling.vue`).

## Assets

- `assets/css/` — contains `base.css` (root variables, resets, core styles) and `main.css` (imports `base.css`, declares fonts and site layout rules).
- `assets/sounds/` — `index.js` (exports) plus `.m4a` files: `home.m4a`, `about.m4a`, `competencies.m4a`, `contact.m4a`, `experience.m4a`, `production.m4a` used by `NavBar` and sections.
- `assets/tech-icons/` — SVG icons referenced by `TechBadge` (examples: `aws.svg`, `digitalocean.svg`, `express.svg`, `linux.svg`, `nginx.svg`, `nodejs.svg`, `postgresql.svg`, `react.svg`, `vue.svg`).
- `lib/` — `lib/three-home-deps.js` (re-exports Three.js primitives used by `HomeSection`); `src/lib/analytics.js` initializes analytics scripts conditionally.
- `public/` — notable files: hero/background images (`images/bg-img2-*.avif|.webp|.jpg`), `ex-logo.svg`, `favicons/*` including `site.webmanifest`, `public/fonts/orbitron-latin-600-normal.woff2` and `orbitron-latin-700-normal.woff2`, `robots.txt`, and `sitemap.xml`.

## Configuration

- `nuxt.config.ts` — configured for SSG via Nitro `prerender` (routes: ['/']), `routeRules` to prerender all routes, `css` entry `~/assets/css/main.css`, `app.head.link` preloads for self-hosted fonts and hero images, and `runtimeConfig.public` keys for analytics: `analyticsProvider`, `analyticsHosts`, `gaMeasurementId` (populated from `NUXT_PUBLIC_*` env vars at build time).
- Environment variables — `.env.example` exposes the NUXT*PUBLIC*\* keys used in runtime:
  - `NUXT_PUBLIC_ANALYTICS_PROVIDER` (none | simple | ga4)
  - `NUXT_PUBLIC_GA_MEASUREMENT_ID` (GA4 ID)
  - `NUXT_PUBLIC_ANALYTICS_HOSTS` (comma-separated hostnames where analytics is allowed)

## Deploy

- Build command: `npm run build` (Nuxt/Vite build configured in `package.json`; session notes use `npx nuxi generate` to validate SSG output).
- Output directory: `.output/public/` (static files to be served by Nginx).
- Deploy scripts: `scripts/staging-deploy.sh` and `scripts/prod-deploy.sh` — both `rsync` `.output/public/` to the target server directory; `scripts/migrate-to-nuxt.sh` contains idempotent migration steps used during the Nuxt migration.

## Docs

- `docs/SESSION_HANDOFF.md` — current session handoff and migration status (lists completed steps and remaining steps; next task Session C: update nginx configs and run Lighthouse baseline).
- `docs/WORK_LOG.md` — chronological migration/work log entries and step confirmations.
- `docs/nginx-staging.example.conf` — example Nginx config for staging static serving pattern (shows `root`, caching headers, fonts/assets handling, and redirects to HTTPS).
- `docs/nginx-production.example.conf` — example Nginx config for production static serving pattern.
- `docs/lighthouse/` — curated Lighthouse JSON reports for baseline and after-optimizations audits (multiple JSON files used for comparison).
