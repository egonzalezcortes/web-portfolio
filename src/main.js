import './assets/main.css'

import { createApp } from 'vue'
import App from './App.vue'
import { initAnalytics } from './lib/analytics'

initAnalytics()
createApp(App).mount('#app')
