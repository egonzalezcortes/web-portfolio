<template>
  <span class="tech-badge" :title="label" :aria-label="label">
    <i :class="iconClass" aria-hidden="true"></i>
    <span class="tech-label">{{ label }}</span>
  </span>
</template>

<script setup>
defineProps({
  iconClass: {
    type: String,
    required: true
  },
  label: {
    type: String,
    required: true
  }
});
</script>

<style scoped>
.tech-badge {
  display: inline-flex;
  align-items: center;
  gap: 8px;
  padding: 4px 10px;
  border-radius: 999px;
  border: 1px solid rgba(255, 255, 255, 0.2);
  background: rgba(255, 255, 255, 0.06);
  font-size: 0.85rem;
  line-height: 1;
}

.tech-badge i {
  font-size: 1rem;
}

.tech-badge i.devicon-amazonwebservices-plain,
.tech-badge i.devicon-amazonwebservices-original {
  color: #ff9900;
}

.tech-label {
  opacity: 0.95;
}
</style>
