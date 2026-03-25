<template>
  <section id="contact" class="content-section">
    <h2 class="section-title glitch-title" data-text="Contact Me">Contact Me</h2>

    <div class="contact-container section-inner">
      <SurfaceCard as="div" accent="var(--accent-cyan)">
        <p class="contact-text">
          If you're building something serious and need a senior engineer, I'd like to talk.
        </p>

        <p class="contact-text">
          Email:
          <a class="contact-link" href="mailto:exgc12@gmail.com">exgc12@gmail.com</a>
        </p>

        <p class="contact-text">
          LinkedIn:
          <a class="contact-link" href="https://www.linkedin.com/in/egonzalezcortes/" target="_blank"
            rel="noopener noreferrer">linkedin.com/in/egonzalezcortes</a>
        </p>
      </SurfaceCard>
    </div>
  </section>
</template>

<script setup>
import SurfaceCard from './SurfaceCard.vue';
</script>

<style scoped>
#contact {
  background-color: var(--vt-c-black);
  color: #fff;
}

.contact-container {
  max-width: 900px;
}

.contact-container :deep(.surface-card) {
  display: grid;
  gap: 12px;
}

.contact-text {
  font-size: 1rem;
  line-height: 1.75;
  color: #fff;
  text-shadow: 1px 3px 11px rgba(0, 0, 0, 0.5);
  opacity: 0.97;
}

.contact-link {
  color: var(--accent-cyan);
  text-decoration: none;
  font-weight: 600;
}

.contact-link:hover {
  text-decoration: underline;
}
</style>
