<template>
  <section id="competencies" class="content-section">
    <h2 class="section-title glitch-title" data-text="Core Competencies">Core Competencies</h2>

    <div class="competencies-container section-inner">
      <article class="competency-card competency-card--systems">
        <h3 class="competency-title">Systems & Backend</h3>
        <div class="tech-row">
          <TechBadge v-for="tech in systemsTech" :key="tech.label" :icon="tech.icon" :label="tech.label" />
        </div>
        <ul class="competency-list">
          <li>
            Multi-client API design with strict backward compatibility
          </li>
          <li>
            GraphQL query optimization and overfetch reduction
          </li>
          <li>
            Multi-tenant schema modeling with complex permission hierarchies
          </li>
          <li>
            Offline/online state sync across distributed data layers
          </li>
        </ul>
      </article>

      <article class="competency-card competency-card--frontend">
        <h3 class="competency-title">Frontend</h3>
        <div class="tech-row">
          <TechBadge v-for="tech in frontendTech" :key="tech.label" :icon="tech.icon" :label="tech.label" />
        </div>
        <ul class="competency-list">
          <li>Legacy framework migration with zero functionality regression</li>
          <li>High-frequency data stream throttling for real-time interfaces</li>
          <li>Rendering performance optimization in large dataset components</li>
          <li>Dynamic form systems with variable input types and PDF output</li>
        </ul>
      </article>

      <article class="competency-card competency-card--cloud">
        <h3 class="competency-title">Infrastructure & Deployment</h3>
        <div class="tech-row">
          <TechBadge v-for="tech in cloudTech" :key="tech.label" :icon="tech.icon" :label="tech.label" />
        </div>
        <ul class="competency-list">
          <li>Linux server provisioning and reverse proxy configuration</li>
          <li>SSL termination, firewall management, and environment isolation</li>
          <li>AWS S3 asset storage with least-privilege IAM policies</li>
          <li>CI/CD pipeline setup and containerized deployments</li>
        </ul>
      </article>
    </div>
  </section>
</template>

<script setup>
import TechBadge from './TechBadge.vue';

const systemsTech = [
  { icon: 'nodejs', label: 'Node.js' },
  { icon: 'express', label: 'Express' },
  { icon: 'postgresql', label: 'PostgreSQL' }
];

const frontendTech = [
  { icon: 'vue', label: 'Vue' },
  { icon: 'react', label: 'React' }
];

const cloudTech = [
  { icon: 'linux', label: 'Linux' },
  { icon: 'nginx', label: 'Nginx' },
  { icon: 'aws', label: 'AWS' }
];
</script>

<style scoped>
#competencies {
  background-color: var(--vt-c-black-soft);
  color: #fff;
}

.competencies-container {
  max-width: 1100px;
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(280px, 1fr));
  gap: 20px;
}

.competency-card {
  border: 1px solid rgba(255, 255, 255, 0.24);
  border-top: 4px solid var(--card-accent, var(--bs-info));
  border-radius: 12px;
  padding: 20px;
  background: rgba(0, 0, 0, 0.22);
  box-shadow: 0 8px 22px rgba(0, 0, 0, 0.18);
  transition: transform 0.22s ease, box-shadow 0.22s ease, border-color 0.22s ease;
}

@media (hover: hover) {
  .competency-card:hover {
    transform: translateY(-3px);
    border-color: rgba(255, 255, 255, 0.34);
    box-shadow: 0 12px 26px rgba(0, 0, 0, 0.26);
  }
}

@media (prefers-reduced-motion: reduce) {
  .competency-card {
    transition: none;
  }

  .competency-card:hover {
    transform: none;
  }
}

.competency-card--systems {
  --card-accent: var(--accent-matrix);
}

.competency-card--frontend {
  --card-accent: var(--accent-phosphor);
}

.competency-card--cloud {
  --card-accent: var(--accent-cyan);
}

.competency-title {
  font-size: 1.15rem;
  letter-spacing: 0.8px;
  text-transform: uppercase;
  margin-bottom: 10px;
  text-shadow: 1px 3px 11px rgba(0, 0, 0, .5);
}

.tech-row {
  display: flex;
  flex-wrap: wrap;
  gap: 8px;
  margin-bottom: 14px;
}

.competency-list {
  margin: 0;
  padding-left: 20px;
}

.competency-list li {
  font-size: 0.98rem;
  line-height: 1.6;
  margin-bottom: 8px;
  opacity: 0.95;
}

@media (max-width: 562px) {
  .competencies-container {
    grid-template-columns: 1fr;
  }

  .competency-card {
    padding: 16px;
  }
}
</style>
