<template>
  <component :is="as" class="surface-card" :style="{
    '--surface-border': borderColor,
    '--surface-accent': accent,
    '--surface-bg': background,
    '--surface-shadow': shadow,
    '--surface-padding': padding,
    '--surface-padding-mobile': mobilePadding
  }">
    <slot />
  </component>
</template>

<script setup>
defineProps({
  as: {
    type: String,
    default: 'article'
  },
  accent: {
    type: String,
    default: 'var(--accent-matrix)'
  },
  borderColor: {
    type: String,
    default: 'rgba(255, 255, 255, 0.2)'
  },
  background: {
    type: String,
    default: 'rgba(255, 255, 255, 0.06)'
  },
  shadow: {
    type: String,
    default: '0 8px 20px rgba(0, 0, 0, 0.2)'
  },
  padding: {
    type: String,
    default: '24px'
  },
  mobilePadding: {
    type: String,
    default: '16px'
  }
});
</script>

<style scoped>
.surface-card {
  border: 1px solid var(--surface-border);
  border-left: 4px solid var(--surface-accent);
  border-radius: 12px;
  padding: var(--surface-padding);
  background: var(--surface-bg);
  box-shadow: var(--surface-shadow);
  transition: transform 0.22s ease, box-shadow 0.22s ease, border-color 0.22s ease;
}

@media (hover: hover) {
  .surface-card:hover {
    transform: translateY(-3px);
    border-color: rgba(255, 255, 255, 0.3);
    box-shadow: 0 12px 26px rgba(0, 0, 0, 0.26);
  }
}

@media (prefers-reduced-motion: reduce) {
  .surface-card {
    transition: none;
  }

  .surface-card:hover {
    transform: none;
  }
}

@media (max-width: 562px) {
  .surface-card {
    padding: var(--surface-padding-mobile);
  }
}
</style>
