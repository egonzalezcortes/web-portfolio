<template>
  <section id="production" class="content-section">
    <h2 class="section-title glitch-title" data-text="From Code to Production">From Code to Production</h2>

    <div class="production-container section-inner">
      <SurfaceCard as="div" accent="var(--accent-synth)">
        <div class="tech-row">
          <TechBadge v-for="tech in productionTech" :key="tech.label" :icon="tech.icon" :label="tech.label" />
        </div>

        <p class="production-text">
          Most engineers don't own their infrastructure. I do. This includes configuring Nginx as a reverse proxy,
          managing SSL
          certificates, enforcing firewall rules, and maintaining system updates. I treat deployment as part of the
          engineering process, not an afterthought. Owning infrastructure decisions has strengthened my understanding of
          networking boundaries, runtime environments, and operational responsibility.
        </p>
      </SurfaceCard>
    </div>
  </section>
</template>

<script setup>
import SurfaceCard from './SurfaceCard.vue';
import TechBadge from './TechBadge.vue';

const productionTech = [
  { icon: 'digitalocean', label: 'DigitalOcean' },
  { icon: 'linux', label: 'Linux' },
  { icon: 'nginx', label: 'Nginx' },
  { icon: 'aws', label: 'AWS' }
];
</script>

<style scoped>
#production {
  background-color: var(--vt-c-black-soft);
  color: #fff;
}

.production-container {
  max-width: 900px;
}

.production-container :deep(.surface-card) {
  display: grid;
  gap: 16px;
}

.tech-row {
  display: flex;
  flex-wrap: wrap;
  gap: 8px;
  margin-bottom: 2px;
}

.production-text {
  font-size: 1rem;
  line-height: 1.75;
  color: #fff;
  text-shadow: 1px 3px 11px rgba(0, 0, 0, 0.5);
  opacity: 0.97;
}

@media (max-width: 562px) {
  .production-text {
    font-size: 1rem;
    line-height: 1.75;
  }
}
</style>
