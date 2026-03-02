<template>
  <section id="about" class="content-section">
    <h2 class="section-title">About Me</h2>

    <div class="about-container section-inner">
      <p class="bio-text intro-text">
        Full-stack software engineer with 6+ years of experience building secure, high-reliability web systems in
        regulated and mission-critical environments. Experienced in designing privacy-conscious architectures,
        evolving
        complex front-end/back-end integrations, and improving system maintainability under real-world operational
        constraints. Strong ownership mindset with a track record of leading migrations, improving performance, and
        collaborating closely across teams.
      </p>

      <h2 class="about-subtitle">How I Build Software</h2>

      <div class="principles-grid">
        <SurfaceCard accent="var(--accent-cyan)">
          <p class="principle-text">
            I approach software as a set of interconnected systems rather than isolated features. I value clear
            boundaries between layers, predictable data flow, and designs that scale in complexity without collapsing
            under maintenance.
          </p>
          <p class="principle-text">
            I prefer explicit contracts, well-defined ownership, and thoughtful trade-offs over quick abstractions. For
            me, shipping software includes considering reliability, data integrity, and how future developers will
            reason about the system.
          </p>
        </SurfaceCard>
      </div>
    </div>
  </section>
</template>

<script setup>
import SurfaceCard from './SurfaceCard.vue';

</script>

<style scoped>
#about {
  background-color: var(--vt-c-black);
  color: #fff;
}

.about-container {
  max-width: 900px;
}

.bio-text {
  font-size: 1.2rem;
  line-height: 1.9;
  text-align: center;
  color: #fff;
  text-shadow: 1px 3px 11px rgba(0, 0, 0, .5);
}

.intro-text {
  margin-bottom: 35px;
}

.about-subtitle {
  text-align: center;
  font-size: 2rem;
  margin-bottom: 14px;
  color: #f5f5f5;
  text-shadow: 1px 3px 11px rgba(0, 0, 0, 0.55);
}

.principles-grid {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(220px, 1fr));
  gap: 20px;
}

.principle-title {
  font-size: 1.25rem;
  margin-bottom: 12px;
  text-shadow: 1px 3px 11px rgba(0, 0, 0, .5);
}

.principle-text {
  font-size: 1rem;
  line-height: 1.75;
  opacity: 0.97;
}

@media (max-width: 562px) {
  .bio-text {
    font-size: 1em;
    text-align: left;
  }

  .about-subtitle {
    font-size: 1.5rem;
    text-align: left;
  }
}
</style>