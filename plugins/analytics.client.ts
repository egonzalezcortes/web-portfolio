export default defineNuxtPlugin(() => {
  const runtimeConfig = useRuntimeConfig()

  const provider = String(runtimeConfig.public.analyticsProvider || '')
    .trim()
    .toLowerCase()
  if (provider !== 'simple') return

  const hosts = String(runtimeConfig.public.analyticsHosts || '')
    .split(',')
    .map((host) => host.trim().toLowerCase())
    .filter(Boolean)

  const currentHost = window.location.hostname.toLowerCase()
  if (!hosts.includes(currentHost)) return

  if (document.querySelector('script[data-simple-analytics="true"]')) return

  const script = document.createElement('script')
  script.async = true
  script.defer = true
  script.src = 'https://scripts.simpleanalyticscdn.com/latest.js'
  script.setAttribute('data-collect-dnt', 'true')
  script.setAttribute('data-simple-analytics', 'true')

  document.head.appendChild(script)
})
