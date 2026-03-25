import { defineNuxtConfig } from 'nuxt/config'

export default defineNuxtConfig({
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
      ],
    },
  },

  modules: [],
})
