# web-porfolio

This template should help get you started developing with Vue 3 in Vite.

## Recommended IDE Setup

[VSCode](https://code.visualstudio.com/) + [Volar](https://marketplace.visualstudio.com/items?itemName=Vue.volar) (and disable Vetur).

## Customize configuration

See [Vite Configuration Reference](https://vite.dev/config/).

## Project Setup

```sh
npm install
```

### Compile and Hot-Reload for Development

```sh
npm run dev
```

### Compile and Minify for Production

```sh
npm run build
```

### Lint with [ESLint](https://eslint.org/)

```sh
npm run lint
```

## Staging and analytics

### Build modes

```sh
# Production build
npm run build

# Staging build (uses .env.staging)
npm run build:staging
```

### Analytics behavior

- Analytics initializes only when all of the following are true:
  - build is production (`import.meta.env.PROD`)
  - `VITE_GA_MEASUREMENT_ID` is set
  - current hostname is in `VITE_ANALYTICS_HOSTS`
- Configure values in:
  - `.env.production`
  - `.env.staging`

### Staging robots behavior

- Staging robots policy is served by Nginx (not app static files) and should return:
  - `User-agent: *`
  - `Disallow: /`
- Use the template in `docs/nginx-staging.egonzalezcortes.com.conf`.

### DNS for staging subdomain

- In your DNS panel, create an `A` record with:
  - Type: `A`
  - Host: `staging`
  - Value: `<your-server-ip>`

### Deploy scripts

```sh
# Staging deploy (positional form)
./scripts/deploy-staging.sh egonzalezcortes@203.0.113.10

# Production deploy (positional form)
./scripts/deploy-prod.sh egonzalezcortes@203.0.113.10

# Target directories are hard-coded in scripts:
# - staging -> /var/www/egonzalezcortes-staging
# - production -> /var/www/egonzalezcortes.com

# Optional overrides
REMOTE=egonzalezcortes@203.0.113.10 TARGET_PORT=2222 ./scripts/deploy-staging.sh
```

Backward compatibility is preserved with `TARGET_USER` + `TARGET_HOST` if preferred.
