const TRACKED_HOSTS = (
  import.meta.env.VITE_ANALYTICS_HOSTS || 'egonzalezcortes.com,www.egonzalezcortes.com'
)
  .split(',')
  .map((host) => host.trim())
  .filter(Boolean)

const ANALYTICS_PROVIDER = (import.meta.env.VITE_ANALYTICS_PROVIDER || 'none').toLowerCase()

const isTrackedHost = () => TRACKED_HOSTS.includes(window.location.hostname)

const appendScript = (src, id) => {
  if (id && document.getElementById(id)) return

  const script = document.createElement('script')
  script.async = true
  script.src = src
  if (id) script.id = id
  document.head.appendChild(script)
}

const initSimpleAnalytics = () => {
  appendScript('https://scripts.simpleanalyticscdn.com/latest.js', 'simple-analytics-script')
}

const initGa4 = () => {
  const gaId = import.meta.env.VITE_GA_MEASUREMENT_ID
  if (!gaId) return

  appendScript(`https://www.googletagmanager.com/gtag/js?id=${gaId}`, 'ga4-script')

  window.dataLayer = window.dataLayer || []
  function gtag() {
    window.dataLayer.push(arguments)
  }

  gtag('js', new Date())
  gtag('config', gaId)
}

export const initAnalytics = () => {
  if (!import.meta.env.PROD) return
  if (!isTrackedHost()) return

  if (ANALYTICS_PROVIDER === 'simple') {
    initSimpleAnalytics()
    return
  }

  if (ANALYTICS_PROVIDER === 'ga4') {
    initGa4()
  }
}
