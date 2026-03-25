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
          Led a nearly two-year full rewrite of a deprecated Polymer frontend to Vue 3, maintaining 1:1 functional
          parity while the legacy system stayed in production.
        </p>
        <p class="experience-text">Built two distinct Vue applications: a per-device
          capability dashboard and a server-side fleet management interface, enabling operators to monitor and remotely
          control up to 10 networked military communication devices.
        </p>
        <p class="experience-text">Implemented UI-layer throttling to cap render
          updates at 1/second against a 100 updates/second data stream from OS-level sensors.
        </p>
        <p class="experience-text">Established frontend test
          coverage from 0% to roughly 40-60% using Jest, introducing contract-based testing focused on component
          behavior rather than implementation details.
        </p>
      </SurfaceCard>

      <SurfaceCard accent="var(--accent-nintendo-red)" border-color="rgba(255, 255, 255, 0.24)"
        shadow="0 8px 20px rgba(0, 0, 0, 0.22)" padding="22px">
        <header class="experience-header">
          <h3 class="company-role">Borilabs LLC — Co-Founder & Lead Full Stack Developer</h3>
          <p class="experience-years">2019 – 2021</p>
        </header>
        <div class="tech-row">
          <TechBadge v-for="tech in borilabsTech" :key="tech.label" :icon="tech.icon" :label="tech.label" />
        </div>

        <p class="experience-text">
          Co-founded a software consultancy delivering production systems across five client domains over two years.
        </p>
        <p class="experience-text">
          Built a fault-tolerant gate access control system integrating RF vehicle sensors and hardware controllers with
          a SQLite local database that synced to a central Node.js/GraphQL backend when connectivity was restored,
          designed specifically for Puerto Rico's unreliable power infrastructure.
        </p>
        <p class="experience-text">
          Developed a special education assessment platform with dynamic test rendering and automated PDF report
          generation.
        </p>
        <p class="experience-text">
          Built a nonprofit registry now hosting 1,169 verified organizations and tracking $439K in donations.
        </p>
        <p class="experience-text">
          Resolved a React
          performance bottleneck in an SMS platform serving 50,000+ contacts by memoizing the contact list component.
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
