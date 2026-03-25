<template>
  <footer class="site-footer">
    <a href="#home" class="back-to-top" @click.prevent="scrollToTop">Back to top</a>

    <p class="footer-built-with">Built with:</p>

    <div class="footer-tech" aria-label="Built with technologies">
      <TechBadge v-for="tech in footerTech" :key="tech.label" :icon="tech.icon" :label="tech.label" />
    </div>

    <p class="footer-text">
      © {{ currentYear }} Edgar X. Gonzalez-Cortes
    </p>
  </footer>
</template>

<script setup>
import TechBadge from './TechBadge.vue';

const currentYear = new Date().getFullYear();

const footerTech = [
  { icon: 'linux', label: 'Linux' },
  { icon: 'nginx', label: 'Nginx' },
  { icon: 'nodejs', label: 'Node.js' },
  { icon: 'vue', label: 'Vue' },
  { icon: 'digitalocean', label: 'DigitalOcean' }
];

const scrollToTop = () => {
  const home = document.querySelector('#home');
  if (home) {
    home.scrollIntoView({ behavior: 'smooth', block: 'start' });
    return;
  }

  window.scrollTo({ top: 0, behavior: 'smooth' });
};
</script>

<style scoped>
.site-footer {
  position: relative;
  background-color: var(--vt-c-black-soft);
  border-top: 1px solid rgba(255, 255, 255, 0.12);
  padding: 34px 16px 24px;
  text-align: center;
}

.footer-built-with {
  margin: 0 0 8px;
  color: rgba(255, 255, 255, 0.9);
  font-size: 0.9rem;
  line-height: 1.2;
  font-weight: 600;
  font-family: var(--font-display);
}

.footer-tech {
  display: flex;
  justify-content: center;
  align-items: center;
  flex-wrap: wrap;
  gap: 8px;
  margin-bottom: 12px;
}

.footer-tech :deep(.tech-badge) {
  padding: 6px;
  border-color: rgba(255, 255, 255, 0.2);
  background: rgba(255, 255, 255, 0.06);
}

.footer-tech :deep(.tech-label) {
  display: none;
}

.back-to-top {
  position: absolute;
  top: 0;
  left: 50%;
  transform: translate(-50%, -50%);
  padding: 7px 14px;
  border-radius: 999px;
  border: 1px solid rgba(255, 255, 255, 0.26);
  background-color: rgba(24, 24, 24, 0.94);
  color: var(--accent-cyan);
  font-size: 0.85rem;
  font-weight: 600;
  line-height: 1;
  text-decoration: none;
}

.footer-text {
  margin: 0;
  color: rgba(255, 255, 255, 0.88);
  font-size: 0.92rem;
  line-height: 1.6;
}

.back-to-top:hover {
  text-decoration: underline;
}

@media (max-width: 562px) {
  .site-footer {
    padding: 32px 14px 22px;
  }

  .footer-tech {
    gap: 6px;
    margin-bottom: 10px;
  }

  .footer-text {
    font-size: 0.86rem;
    line-height: 1.7;
  }

  .back-to-top {
    font-size: 0.8rem;
    padding: 7px 12px;
  }
}
</style>
