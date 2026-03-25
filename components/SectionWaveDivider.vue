<template>
  <div class="wave-divider" :style="{ '--wave-top-color': topColor, '--wave-bottom-color': bottomColor }"
    aria-hidden="true">
    <svg viewBox="0 0 1200 110" preserveAspectRatio="none" role="presentation">
      <path d="M0,42 C150,86 300,8 450,42 C600,86 750,8 900,42 C1030,80 1125,20 1200,42 L1200,110 L0,110 Z" />
    </svg>
  </div>
</template>

<script setup>
defineProps({
  topColor: {
    type: String,
    default: 'var(--vt-c-black)'
  },
  bottomColor: {
    type: String,
    default: 'var(--vt-c-black-soft)'
  }
});
</script>

<style scoped>
.wave-divider {
  height: 44px;
  line-height: 0;
  background-color: var(--wave-top-color);
}

.wave-divider svg {
  display: block;
  width: 100%;
  height: 100%;
}

.wave-divider path {
  fill: var(--wave-bottom-color);
}

@media (max-width: 562px) {
  .wave-divider {
    height: 34px;
  }
}
</style>
