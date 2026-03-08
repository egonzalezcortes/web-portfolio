<template>
  <section id="about" class="content-section">
    <h2 class="section-title glitch-title" data-text="About Me">About Me</h2>

    <div class="about-container section-inner">
      <p class="bio-text intro-text">I’m a full-stack software engineer with 6+ years of experience helping teams build
        reliable web applications. I work across the stack—from user interfaces to backend systems—turning complex
        requirements into software that is secure, maintainable, and built to last.
      </p>
      <p class="bio-text intro-text">
        I enjoy working in small, collaborative teams where engineers bring complementary strengths and solve difficult
        problems together.
      </p>

      <h2 class="about-subtitle">How I Build Software</h2>

      <div class="principles-grid">
        <SurfaceCard accent="var(--accent-cyan)">
          <p class="principle-text">
            I approach software as a set of interconnected systems rather than isolated features. When applications
            grow, complexity grows with them, so I focus on designing systems that remain understandable and
            maintainable over time.
          </p>
        </SurfaceCard>
      </div>

      <h2 class="about-subtitle">How I Work With Teams</h2>

      <div class="principles-grid">
        <SurfaceCard accent="var(--accent-matrix)">
          <p class="principle-text">
            The best software I’ve built has come from small, collaborative teams where people bring different strengths
            to the table. I value environments where engineers communicate openly, challenge ideas constructively, and
            take shared ownership of the systems they build.
          </p>
          <p class="principle-text">
            My background in the military shaped how I approach teamwork: clear communication, trust, and
            accountability. I enjoy helping teams stay aligned and focused on solving the real
            problem behind the software we build.
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
  margin: 2em 0 .5em;
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
  margin: 14px 0;
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