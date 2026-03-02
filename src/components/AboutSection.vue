<template>
  <section id="about">
    <h1 class="section-title">About Me</h1>

    <div class="about-container">
      <p class="bio-text">
        Full-stack software engineer with 6+ years of experience building secure, high-reliability web systems in
        regulated and mission-critical environments. Experienced in designing privacy-conscious architectures, evolving
        complex front-end/back-end integrations, and improving system maintainability under real-world operational
        constraints. Strong ownership mindset with a track record of leading migrations, improving performance, and
        collaborating closely across teams.
      </p>
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
}
</style>