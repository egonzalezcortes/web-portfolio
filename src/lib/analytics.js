const TRACKED_HOSTS = (
  import.meta.env.VITE_ANALYTICS_HOSTS || 'egonzalezcortes.com,www.egonzalezcortes.com'
)
  .split(',')
  .map((host) => host.trim())
  .filter(Boolean)

const isTrackedHost = () => TRACKED_HOSTS.includes(window.location.hostname)

const appendScript = (src) => {
  const script = document.createElement('script')
  script.async = true
  script.src = src
  document.head.appendChild(script)
}

export const initAnalytics = () => {
  const gaId = import.meta.env.VITE_GA_MEASUREMENT_ID

  if (!import.meta.env.PROD) return
  if (!gaId) return
  if (!isTrackedHost()) return

  appendScript(`https://www.googletagmanager.com/gtag/js?id=${gaId}`)

  window.dataLayer = window.dataLayer || []
  function gtag() {
    window.dataLayer.push(arguments)
  }

  gtag('js', new Date())
  gtag('config', gaId)
}
