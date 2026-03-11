<template>
  <section id="about" class="content-section">
    <h2 class="section-title glitch-title" data-text="About Me">About Me</h2>

    <div class="about-container section-inner">
      <p class="bio-text intro-text">I'm a full-stack software engineer with 6+ years building production systems across
        defense, civic, and commercial domains. I've led multi-year migrations, architected fault-tolerant systems for
        infrastructure-constrained environments, and shipped software that real people depend on.
      </p>
      <p class="bio-text intro-text">
        Before writing software professionally, I spent 12 years in the US Army Signal Corps, deploying to Iraq and
        Kuwait to establish and maintain tactical communications networks. In 2017, I led a team to restore satellite
        communications for a field hospital set up in a coliseum after Hurricane María devastated Puerto Rico. That
        experience shaped how I think about reliability, accountability, and what it means to build something that
        cannot fail.
      </p>

      <h2 class="about-subtitle">How I Build Software</h2>

      <div class="principles-grid">
        <SurfaceCard accent="var(--accent-cyan)">
          <p class="principle-text">
            I think about software as interconnected systems, not isolated features. Complexity compounds as
            applications grow, so I focus early on clean boundaries, honest contracts between components, and tests that
            reflect how a system actually behaves rather than just that the code ran.
          </p>
          <p class="principle-text">
            I've worked in environments where the cost of a bad deployment is high: defense systems, compliance-driven
            platforms, hardware-integrated applications. That context has made me deliberate about architecture
            decisions and honest about tradeoffs.
          </p>
        </SurfaceCard>
      </div>

      <h2 class="about-subtitle">How I Work With Teams</h2>

      <div class="principles-grid">
        <SurfaceCard accent="var(--accent-matrix)">
          <p class="principle-text">
            The best work I've done has been in small, close-knit teams where people know each other well, communicate
            directly, and take shared ownership of what they build. Most of my closest friends are people I've worked
            with. That's not a coincidence. I think the quality of the relationships on a team directly affects the
            quality of the software it ships.
          </p>
          <p class="principle-text">
            My approach to leadership comes from the military: you lead by developing the people around you until they
            don't need you for that anymore. I've mentored developers from their first pull request to owning entire
            projects independently. Several have gone on to become mid and senior engineers. That outcome matters more
            to me than any individual feature I've shipped.
          </p>
          <p class="principle-text">
            I also believe teams need to take care of themselves. Delivery matters, because without it there's no
            company. But a team that ignores its own health won't deliver for long. I try to be someone who notices that
            and says something.
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