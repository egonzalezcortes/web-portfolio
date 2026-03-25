import { defineNuxtConfig } from 'nuxt/config'

export default defineNuxtConfig({
  compatibilityDate: '2026-03-25',

  // Use Nitro prerendering for SSG (do not set ssr: false)
  nitro: {
    prerender: {
      routes: ['/'],
    },
    autoSubfolderIndex: false,
  },

  // Ensure all routes are prerendered by default
  routeRules: {
    '/**': { prerender: true },
  },

  // Runtime config populated from NUXT_PUBLIC_* environment vars at build time
  runtimeConfig: {
    public: {
      analyticsProvider: process.env.NUXT_PUBLIC_ANALYTICS_PROVIDER || '',
      analyticsHosts: process.env.NUXT_PUBLIC_ANALYTICS_HOSTS || '',
      gaMeasurementId: process.env.NUXT_PUBLIC_GA_MEASUREMENT_ID || '',
    },
  },

  // Preserve existing project CSS entrypoint
  css: ['~/assets/css/main.css'],

  app: {
    head: {
      htmlAttrs: {
        lang: 'en',
      },
      title: 'Edgar González-Cortés — Full Stack Software Engineer',
      meta: [
        {
          name: 'description',
          content:
            'Full stack engineer with 6+ years building production systems in Node.js, Go, Vue, React, and PostgreSQL. Based in Denver.',
        },
        { property: 'og:type', content: 'website' },
        { property: 'og:url', content: 'https://egonzalezcortes.com' },
        { property: 'og:title', content: 'Edgar González-Cortés — Full Stack Software Engineer' },
        {
          property: 'og:description',
          content:
            'Full stack engineer with 6+ years building production systems in Node.js, Go, Vue, React, and PostgreSQL. Based in Denver.',
        },
        { property: 'og:image', content: 'https://egonzalezcortes.com/images/bg-img2-1600.avif' },
        { name: 'twitter:card', content: 'summary_large_image' },
        { name: 'twitter:title', content: 'Edgar González-Cortés — Full Stack Software Engineer' },
        {
          name: 'twitter:description',
          content:
            'Full stack engineer with 6+ years building production systems in Node.js, Go, Vue, React, and PostgreSQL. Based in Denver.',
        },
      ],
      link: [
        // Font preloads (self-hosted in /public/fonts/)
        {
          rel: 'preload',
          href: '/fonts/orbitron-latin-600-normal.woff2',
          as: 'font',
          type: 'font/woff2',
          crossorigin: 'anonymous',
        },
        {
          rel: 'preload',
          href: '/fonts/orbitron-latin-700-normal.woff2',
          as: 'font',
          type: 'font/woff2',
          crossorigin: 'anonymous',
        },
        // Hero image preloads (from /public/images/)
        { rel: 'preload', href: '/images/bg-img2-960.avif', as: 'image' },
        { rel: 'preload', href: '/images/bg-img2-1600.avif', as: 'image' },
        { rel: 'canonical', href: 'https://egonzalezcortes.com' },
      ],
    },
  },

  vite: {
    optimizeDeps: {
      include: ['three'],
    },
  },

  modules: [],
})
