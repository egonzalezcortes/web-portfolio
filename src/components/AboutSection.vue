<template>
  <section id="about">
    <h1 class="section-title">About Me</h1>

    <div class="about-container">
      <p class="bio-text intro-text">
        Full-stack software engineer with 6+ years of experience building secure, high-reliability web systems in
        regulated and mission-critical environments. Experienced in designing privacy-conscious architectures, evolving
        complex front-end/back-end integrations, and improving system maintainability under real-world operational
        constraints. Strong ownership mindset with a track record of leading migrations, improving performance, and
        collaborating closely across teams.
      </p>

      <h2 class="about-subtitle">How I Build Software</h2>

      <div class="principles-grid">
        <article class="principle-card">
          <h3 class="principle-title">Systems Thinking</h3>
          <p class="principle-text">
            I build software as interconnected systems, not isolated features. I design boundaries between frontend,
            backend, and data layers intentionally, with APIs and schemas planned up front.
          </p>
        </article>

        <article class="principle-card">
          <h3 class="principle-title">Maintainability First</h3>
          <p class="principle-text">
            I prioritize maintainability and correctness over shortcuts through clear contracts, relational integrity,
            practical indexing strategies, and frontends that reflect backend realities.
          </p>
        </article>

        <article class="principle-card">
          <h3 class="principle-title">End-to-End Ownership</h3>
          <p class="principle-text">
            I enjoy working across the stack—from modeling data in PostgreSQL to building Express APIs and designing
            interfaces in Vue or React—taking systems from development through deployment.
          </p>
        </article>
      </div>
    </div>
  </section>
</template>

<script setup>

</script>

<style scoped>
#about {
  background-color: #181818;
  color: #fff;
}

.section-title {
  font-size: 75px;
  text-align: center;
  padding-top: 75px;
}

.about-container {
  max-width: 900px;
  margin: 0 auto;
  padding: 20px 30px 70px;
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
  margin-bottom: 25px;
}

.principles-grid {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(220px, 1fr));
  gap: 20px;
}

.principle-card {
  border: 1px solid rgba(255, 255, 255, 0.2);
  border-radius: 12px;
  padding: 20px;
  background: rgba(255, 255, 255, 0.03);
}

.principle-title {
  font-size: 1.25rem;
  margin-bottom: 10px;
  text-shadow: 1px 3px 11px rgba(0, 0, 0, .5);
}

.principle-text {
  font-size: 1rem;
  line-height: 1.7;
}

@media (max-width: 562px) {
  .section-title {
    font-size: 50px;
    padding-top: 50px;
  }

  .about-container {
    padding: 20px;
  }

  .bio-text {
    font-size: 1em;
    text-align: left;
  }

  .about-subtitle {
    font-size: 1.5rem;
    text-align: left;
  }

  .principle-card {
    padding: 16px;
  }
}
</style>