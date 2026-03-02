<template>
  <section id="competencies">
    <h2 class="section-title">Core Competencies</h2>

    <div class="competencies-container">
      <article class="competency-card competency-card--systems">
        <h3 class="competency-title">Systems & Backend</h3>
        <ul class="competency-list">
          <li>
            REST API design and contract definition
          </li>
          <li>
            Relational schema modeling in PostgreSQL
          </li>
          <li>
            Query optimization and indexing strategies
          </li>
          <li>
            Transaction-aware backend logic
          </li>
        </ul>
      </article>

      <article class="competency-card competency-card--frontend">
        <h3 class="competency-title">Frontend</h3>
        <ul class="competency-list">
          <li>Component-driven architecture in Vue and React</li>
          <li>State synchronization across complex UI flows</li>
          <li>Performance optimization and rendering efficiency</li>
        </ul>
      </article>

      <article class="competency-card competency-card--cloud">
        <h3 class="competency-title">Cloud & Infrastructure</h3>
        <ul class="competency-list">
          <li>Linux server provisioning and maintenance</li>
          <li>Nginx reverse proxy configuration</li>
          <li>AWS S3 integration and IAM policy management</li>
          <li>Deployment and environment isolation</li>
        </ul>
      </article>
    </div>
  </section>
</template>

<script setup>
</script>

<style scoped>
#competencies {
  background-color: #181818;
  color: #fff;
}

.section-title {
  font-size: 75px;
  text-align: center;
  padding-top: 75px;
}

.competencies-container {
  max-width: 1100px;
  margin: 0 auto;
  padding: 20px 30px 70px;
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(280px, 1fr));
  gap: 20px;
}

.competency-card {
  border: 1px solid rgba(255, 255, 255, 0.16);
  border-top: 4px solid var(--card-accent, var(--bs-info));
  border-radius: 12px;
  padding: 20px;
  background: rgba(255, 255, 255, 0.04);
}

.competency-card--systems {
  --card-accent: #4af626;
}

.competency-card--frontend {
  --card-accent: #F6511D;
}

.competency-card--cloud {
  --card-accent: #548687;
}

.competency-title {
  font-size: 1.15rem;
  letter-spacing: 0.8px;
  text-transform: uppercase;
  margin-bottom: 14px;
  text-shadow: 1px 3px 11px rgba(0, 0, 0, .5);
}

.competency-list {
  margin: 0;
  padding-left: 20px;
}

.competency-list li {
  font-size: 0.98rem;
  line-height: 1.6;
  margin-bottom: 8px;
}

@media (max-width: 562px) {
  .section-title {
    font-size: 50px;
    padding-top: 50px;
  }

  .section-intro {
    text-align: left;
    padding: 0 20px;
  }

  .competencies-container {
    padding: 20px;
    grid-template-columns: 1fr;
  }

  .competency-card {
    padding: 16px;
  }
}
</style>
