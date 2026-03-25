<template>
  <nav ref="navRef" class="site-nav navbar-custom" :class="{ 'navbar-scrolled': isScrolled || isNavOpen }">
    <div class="site-nav-inner">
      <a class="site-brand" href="#home">Edgar X. Gonzalez-Cortes</a>
      <button class="site-toggle" type="button" @click="toggleNav" aria-controls="mainNavbar"
        :aria-expanded="String(isNavOpen)" aria-label="Toggle navigation" :class="{ collapsed: !isNavOpen }">
        <span class="site-toggle-icon" aria-hidden="true">{{ isNavOpen ? '✕' : '☰' }}</span>
      </button>
      <div class="site-menu" id="mainNavbar" :class="{ show: isNavOpen }">
        <ul class="site-links">
          <li class="site-item">
            <a class="site-link" href="#home" @click="handleNavClick($event, 'home')">/home</a>
          </li>
          <li class="site-item">
            <a class="site-link" href="#about" @click="handleNavClick($event, 'about')">/about</a>
          </li>
          <li class="site-item">
            <a class="site-link" href="#competencies" @click="handleNavClick($event, 'competencies')">/competencies</a>
          </li>
          <li class="site-item">
            <a class="site-link" href="#experience" @click="handleNavClick($event, 'experience')">/experience</a>
          </li>
          <li class="site-item">
            <a class="site-link" href="#production" @click="handleNavClick($event, 'production')">/production</a>
          </li>
          <li class="site-item">
            <a class="site-link" href="#contact" @click="handleNavClick($event, 'contact')">/contact</a>
          </li>
        </ul>
      </div>
    </div>
  </nav>
</template>

<script setup>
import { onBeforeUnmount, onMounted, ref } from 'vue';
import { home, about, competencies, contact, experience, production } from '@/assets/sounds/index.js';

const isNavOpen = ref(false);
const isScrolled = ref(false);
const navRef = ref(null);
let sounds = {};

const play = (name) => {
  const a = sounds[name];
  if (!a) return;
  a.currentTime = 0;
  a.play().catch(() => { });
};

const toggleNav = () => {
  isNavOpen.value = !isNavOpen.value;
};

const handleNavClick = (event, soundName) => {
  if (soundName) play(soundName);
  const target = event.currentTarget?.getAttribute('href');
  if (target?.startsWith('#')) {
    event.preventDefault();
    const section = document.querySelector(target);
    if (section) {
      section.scrollIntoView({ behavior: 'smooth', block: 'start' });
    }
  }
  isNavOpen.value = false;
};

const handleDocumentClick = (event) => {
  if (!isNavOpen.value) return;
  const navElement = navRef.value;
  if (navElement && !navElement.contains(event.target)) {
    isNavOpen.value = false;
  }
};

const handleScroll = () => {
  isScrolled.value = window.scrollY > 10;
};

onMounted(() => {
  sounds = {
    home: new Audio(home),
    about: new Audio(about),
    competencies: new Audio(competencies),
    contact: new Audio(contact),
    experience: new Audio(experience),
    production: new Audio(production)
  };
  Object.values(sounds).forEach(a => { a.preload = 'auto'; a.volume = 0.2; });
  document.addEventListener('click', handleDocumentClick);
  window.addEventListener('scroll', handleScroll, { passive: true });
  handleScroll();
});

onBeforeUnmount(() => {
  document.removeEventListener('click', handleDocumentClick);
  window.removeEventListener('scroll', handleScroll);
});
</script>

<style scoped>
.site-nav {
  position: fixed;
  top: 0;
  left: 0;
  right: 0;
  z-index: 1100;
}

.site-nav-inner {
  display: flex;
  align-items: center;
  justify-content: space-between;
  padding: 10px 16px;
  gap: 18px;
}

.site-brand {
  font-weight: 700;
  font-size: 1.05rem;
  line-height: 1;
  white-space: nowrap;
}

.site-toggle {
  border: 0;
  background: transparent;
  color: #fff;
  font-size: 1.5rem;
  line-height: 1;
  padding: 0;
  display: none;
}

.site-menu {
  margin-left: auto;
}

.site-links {
  display: flex;
  align-items: center;
  gap: 16px;
  list-style: none;
  margin: 0;
  padding: 0;
}

.site-link {
  font-weight: 700;
  text-transform: lowercase;
}

.navbar-custom {
  background-color: transparent;
  transition: background-color 0.25s ease, backdrop-filter 0.25s ease, box-shadow 0.25s ease;
}

.navbar-scrolled {
  background-color: rgba(24, 24, 24, 0.76);
  backdrop-filter: blur(6px);
  box-shadow: 0 2px 14px rgba(0, 0, 0, 0.2);
}

@media (max-width: 992px) {
  .site-toggle {
    display: inline-flex;
  }

  .site-menu {
    position: absolute;
    top: calc(100% + 6px);
    left: 16px;
    right: 16px;
    margin-left: 0;
    border: 1px solid rgba(255, 255, 255, 0.2);
    border-radius: 10px;
    background: rgba(16, 16, 16, 0.95);
    box-shadow: 0 10px 22px rgba(0, 0, 0, 0.28);
    padding: 10px;
    display: none;
  }

  .site-menu.show {
    display: block;
  }

  .site-links {
    flex-direction: column;
    align-items: flex-start;
    gap: 8px;
  }

  .site-link {
    display: block;
    width: 100%;
  }
}
</style>