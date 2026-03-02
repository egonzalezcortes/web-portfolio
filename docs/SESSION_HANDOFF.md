# Session Handoff

Date: 2026-03-02
Project: `web-porfolio` (Vue 3 + Vite)

## Current state (ready to continue)

- Performance optimization pass completed; latest Lighthouse run in this workspace reached:
  - Performance: **93**
  - Accessibility: **100**
  - Best Practices: **100**
  - SEO: **92**
  - FCP: **2.5s**, LCP: **2.6s**, TBT: **0ms**, CLS: **0**
- Hero image delivery is responsive and modern-format-first (`AVIF`/`WebP`) with JPG fallback.
- Three.js hero logic is deferred and gated for better LCP/TBT.
- Orbitron is now self-hosted locally (Google Fonts runtime chain removed).

## Important files changed this session

- `src/components/HomeSection.vue`
  - Added `picture` + responsive image sources.
  - Kept LCP image `fetchpriority="high"` and eager loading.
  - Three.js initialization deferred and gated (`desktop`, no reduced motion, no save-data).
  - Reduced renderer workload (`pixelRatio` cap, lower geometry segments).
- `src/lib/three-home-deps.js`
  - Trimmed exports to only classes used by hero.
- `src/assets/main.css`
  - Replaced package-imported Orbitron CSS with explicit local `@font-face` rules.
  - Fonts now load from stable public URLs:
    - `/fonts/orbitron-latin-600-normal.woff2`
    - `/fonts/orbitron-latin-700-normal.woff2`
  - Removed unused large-screen body layout rule.
- `src/assets/base.css`
  - Removed unused Vue starter theme variables and dark-mode semantic block.
  - Kept only base tokens/reset relevant to this site.
- `index.html`
  - Removed Google Fonts preconnect/stylesheet lines.
- `package.json`
  - Added dependency: `@fontsource/orbitron`.
- Added responsive hero assets:
  - `src/assets/imgs/bg-img2-960.avif`
  - `src/assets/imgs/bg-img2-1600.avif`
  - `src/assets/imgs/bg-img2-960.webp`
  - `src/assets/imgs/bg-img2-1600.webp`

## Continuation addendum (same date)

### SEO/crawlability additions

- Added `public/robots.txt`:
  - `User-agent: *`
  - `Allow: /`
  - `Sitemap: https://egonzalezcortes.com/sitemap.xml`
- Added `public/sitemap.xml` with entries for:
  - `https://egonzalezcortes.com/`
  - `https://egonzalezcortes.com/about`
  - `https://egonzalezcortes.com/competencies`
  - `https://egonzalezcortes.com/experience`
  - `https://egonzalezcortes.com/production`

### Performance follow-up work

- Investigated Lighthouse console `405` warning for random hash-like paths.
  - Confirmed app code is not issuing those requests.
  - Reproduced behavior as method-specific on unknown paths (`GET/HEAD 200`, `POST/OPTIONS 405`) in production.
  - Provided Nginx hardening guidance for method handling and SPA fallback behavior.
- Added critical font optimization:
  - Font preload in `index.html` for Orbitron 600.
  - Moved font files to `public/fonts/` for stable, cacheable URLs.
- Added responsive hero image preload in `index.html` using `imagesrcset` + `imagesizes` and `fetchpriority="high"`.

### Hero typography/layout fix

- Updated `src/components/HomeSection.vue` hero styles to avoid clipping on desktop/large screens:
  - Reduced and responsive `h1` size via `clamp(...)`.
  - Removed negative left margin on the hero title.
  - Made hero container width/left offset responsive to prevent cutoff.

### Additional deployment notes

- For new public fonts, add long-lived cache policy in Nginx:
  - `location /fonts/ { expires 1y; add_header Cache-Control "public, max-age=31536000, immutable" always; try_files $uri =404; }`
- Keep Certbot include lines unchanged; avoid duplicating `ssl_protocols` if already defined in Certbot-managed include.

### Staging environment scaffolding added

- Added deploy scripts:
  - `scripts/deploy-staging.sh`
  - `scripts/deploy-prod.sh`
- Added staging Nginx template:
  - `docs/nginx-staging.egonzalezcortes.com.conf`
- Template includes:
  - SPA fallback + cache rules for `/assets/` and `/fonts/`
  - basic auth guard for staging (`auth_basic`)
  - `X-Robots-Tag: noindex, nofollow, noarchive`

Quick usage:

```bash
# Staging deploy
TARGET_HOST=<server-ip-or-dns> TARGET_USER=<ssh-user> ./scripts/deploy-staging.sh

# Production deploy
TARGET_HOST=<server-ip-or-dns> TARGET_USER=<ssh-user> ./scripts/deploy-prod.sh
```

Staging server bootstrap checklist:

```bash
sudo cp /path/to/repo/docs/nginx-staging.egonzalezcortes.com.conf /etc/nginx/sites-available/staging.egonzalezcortes.com
sudo ln -s /etc/nginx/sites-available/staging.egonzalezcortes.com /etc/nginx/sites-enabled/staging.egonzalezcortes.com
sudo htpasswd -c /etc/nginx/.htpasswd-staging <staging-user>
sudo nginx -t && sudo systemctl reload nginx
```

## Lighthouse reports generated in repo

- `lighthouse-after-pass.json`
- `lighthouse-after-picture.json`
- `lighthouse-after-three-refactor.json`
- and additional prior snapshots (`lighthouse-after*.json`)

## Deployment / Nginx recommendations prepared

For DigitalOcean + Nginx self-hosting:

1. Cache hashed assets for 1 year + immutable:
   - `location /assets/ { expires 1y; Cache-Control: public, max-age=31536000, immutable; }`
2. Keep HTML uncached/short-lived:
   - `location = /index.html { no-cache, no-store, must-revalidate; }`
3. SPA fallback:
   - `location / { try_files $uri $uri/ /index.html; }`
4. Enable HTTP/2:
   - `listen 443 ssl http2;`
5. Keep Certbot SSL include lines unchanged.
6. Update global SSL protocols to modern set:
   - `ssl_protocols TLSv1.2 TLSv1.3;`

## Likely source of Lighthouse console 404 warning

- Stale hashed asset requests after deploy (old tab or cached HTML referencing removed chunk).
- Mitigation:
  - Atomic deploys (release folders + symlink swap).
  - Keep previous release assets for a short overlap window.

## Suggested next actions when resuming

1. Deploy latest build (includes robots/sitemap + font/image preload + hero typography fix).
2. Ensure Nginx includes cache rules for both `/assets/` and `/fonts/`.
3. Run `nginx -t` and reload.
4. Re-run 3–5 Lighthouse passes and take median for stability.
5. If needed, continue tuning JS payload (notably `vendor-three`) and critical path.

## Quick verification commands

```bash
npm run build
npm run preview -- --port 4177
npx --yes lighthouse@12.8.2 http://localhost:4177 \
  --output=json --output-path=./lighthouse-resume.json \
  --only-categories=performance,accessibility,best-practices,seo \
  --chrome-flags='--headless --no-sandbox --disable-gpu' --quiet
```
