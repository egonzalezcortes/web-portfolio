<template>
  <section id="experience" class="content-section">
    <h2 class="section-title glitch-title" data-text="Professional Experience">Professional Experience</h2>

    <div class="experience-container section-inner">
      <SurfaceCard accent="var(--accent-phosphor)" border-color="rgba(255, 255, 255, 0.24)"
        shadow="0 8px 20px rgba(0, 0, 0, 0.22)" padding="22px">
        <header class="experience-header">
          <h3 class="company-role">CACI — Full Stack Software Engineer</h3>
          <p class="experience-years">2021 – 2025</p>
        </header>
        <div class="tech-row">
          <TechBadge v-for="tech in caciTech" :key="tech.label" :icon="tech.icon" :label="tech.label" />
        </div>

        <p class="experience-text">
          Led the migration of a legacy frontend system to Vue 2 and later Vue 3 within a secure, mission-critical
          environment. Extended Node/Express backend services to support multiple interfaces while maintaining backward
          compatibility and system stability.
        </p>
        <p class="experience-text">
          Improved architecture across frontend and backend layers to enhance maintainability and reduce regression risk
          during major system transitions. Introduced automated testing practices to improve reliability in a
          compliance-driven environment.
        </p>
      </SurfaceCard>

      <SurfaceCard accent="var(--accent-nintendo-red)" border-color="rgba(255, 255, 255, 0.24)"
        shadow="0 8px 20px rgba(0, 0, 0, 0.22)" padding="22px">
        <header class="experience-header">
          <h3 class="company-role">Borilabs — Full Stack Developer</h3>
          <p class="experience-years">2019 – 2021</p>
        </header>
        <div class="tech-row">
          <TechBadge v-for="tech in borilabsTech" :key="tech.label" :icon="tech.icon" :label="tech.label" />
        </div>

        <p class="experience-text">
          Designed and implemented a role-based access control system governing user permissions across large
          residential communities. Optimized React application performance by over 60% through query refactoring and
          component restructuring.
        </p>
        <p class="experience-text">
          Integrated AWS S3 for secure asset storage and configured IAM policies to enforce least-privilege access
          patterns across application services.
        </p>
      </SurfaceCard>
    </div>
  </section>
</template>

<script setup>
import SurfaceCard from './SurfaceCard.vue';
import TechBadge from './TechBadge.vue';

const caciTech = [
  { icon: 'vue', label: 'Vue' },
  { icon: 'nodejs', label: 'Node.js' },
  { icon: 'express', label: 'Express' }
];

const borilabsTech = [
  { icon: 'react', label: 'React' },
  { icon: 'aws', label: 'AWS S3/IAM' }
];
</script>

<style scoped>
#experience {
  background-color: var(--vt-c-black);
  color: #fff;
}

.experience-container {
  max-width: 1000px;
  display: grid;
  gap: 18px;
}

.experience-header {
  display: flex;
  justify-content: space-between;
  align-items: baseline;
  gap: 16px;
  margin-bottom: 12px;
}

.company-role {
  font-size: 1.3rem;
  font-weight: 600;
  text-shadow: 1px 3px 11px rgba(0, 0, 0, 0.5);
}

.experience-years {
  font-size: 0.95rem;
  opacity: 1;
  white-space: nowrap;
}

.experience-text {
  font-size: 1rem;
  line-height: 1.75;
  margin-bottom: 10px;
  opacity: 0.95;
}

.tech-row {
  display: flex;
  flex-wrap: wrap;
  gap: 8px;
  margin-bottom: 14px;
}

.experience-text:last-child {
  margin-bottom: 0;
}

@media (max-width: 768px) {
  .experience-header {
    flex-direction: column;
    align-items: flex-start;
    gap: 6px;
  }
}

@media (max-width: 562px) {
  .company-role {
    font-size: 1.1rem;
  }
}
</style>
