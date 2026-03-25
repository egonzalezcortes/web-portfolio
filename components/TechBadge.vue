<template>
  <span class="tech-badge" :title="label" :aria-label="label">
    <img :class="['tech-icon', `tech-icon--${icon}`]" :src="iconSrc" :alt="`${label} icon`" loading="lazy"
      decoding="async" />
    <span class="tech-label">{{ label }}</span>
  </span>
</template>

<script setup>
import { computed } from 'vue';
import awsIcon from '@/assets/tech-icons/aws.svg';
import digitaloceanIcon from '@/assets/tech-icons/digitalocean.svg';
import expressIcon from '@/assets/tech-icons/express.svg';
import linuxIcon from '@/assets/tech-icons/linux.svg';
import nginxIcon from '@/assets/tech-icons/nginx.svg';
import nodejsIcon from '@/assets/tech-icons/nodejs.svg';
import postgresqlIcon from '@/assets/tech-icons/postgresql.svg';
import reactIcon from '@/assets/tech-icons/react.svg';
import vueIcon from '@/assets/tech-icons/vue.svg';

const iconMap = {
  aws: awsIcon,
  digitalocean: digitaloceanIcon,
  express: expressIcon,
  linux: linuxIcon,
  nginx: nginxIcon,
  nodejs: nodejsIcon,
  postgresql: postgresqlIcon,
  react: reactIcon,
  vue: vueIcon
};

const props = defineProps({
  icon: {
    type: String,
    required: true
  },
  label: {
    type: String,
    required: true
  }
});

const iconSrc = computed(() => iconMap[props.icon] || '');
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

.tech-icon {
  width: 17px;
  height: 17px;
  object-fit: contain;
  flex: 0 0 auto;
}

.tech-icon--aws,
.tech-icon--digitalocean {
  width: 22px;
  height: 14px;
}

.tech-icon--express {
  width: 20px;
  height: 15px;
}

.tech-icon--nginx,
.tech-icon--postgresql {
  width: 16px;
  height: 16px;
}

.tech-label {
  opacity: 0.95;
}
</style>
