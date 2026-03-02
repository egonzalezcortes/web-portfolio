<template>
  <nav ref="navRef" class="navbar navbar-expand-lg navbar-dark fixed-top navbar-custom"
    :class="{ 'navbar-scrolled': isScrolled || isNavOpen }">
    <div class="container-fluid px-3 px-lg-4">
      <a class="navbar-brand fw-bold" href="#home">Edgar X. Gonzalez-Cortes</a>

      <button class="navbar-toggler border-0" type="button" @click="toggleNav" aria-controls="mainNavbar"
        :aria-expanded="String(isNavOpen)" aria-label="Toggle navigation" :class="{ collapsed: !isNavOpen }">
        <span class="navbar-toggler-icon"></span>
      </button>

      <div class="collapse navbar-collapse" id="mainNavbar" :class="{ show: isNavOpen }">
        <ul class="navbar-nav ms-auto mb-2 mb-lg-0">
          <li class="nav-item">
            <a class="nav-link fw-bold" href="#home" @click="handleNavClick">/home</a>
          </li>
          <li class="nav-item">
            <a class="nav-link fw-bold" href="#about" @click="handleNavClick">/about</a>
          </li>
          <li class="nav-item">
            <a class="nav-link fw-bold" href="#competencies" @click="handleNavClick">/competencies</a>
          </li>
          <li class="nav-item">
            <a class="nav-link fw-bold" href="#experience" @click="handleNavClick">/experience</a>
          </li>
        </ul>
      </div>
    </div>
  </nav>
</template>

<script setup>
import { onBeforeUnmount, onMounted, ref } from 'vue';

const isNavOpen = ref(false);
const isScrolled = ref(false);
const navRef = ref(null);

const toggleNav = () => {
  isNavOpen.value = !isNavOpen.value;
};

const handleNavClick = (event) => {
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
.navbar-custom {
  background-color: transparent;
  transition: background-color 0.25s ease, backdrop-filter 0.25s ease, box-shadow 0.25s ease;
}

.navbar-scrolled {
  background-color: rgba(24, 24, 24, 0.76);
  backdrop-filter: blur(6px);
  box-shadow: 0 2px 14px rgba(0, 0, 0, 0.2);
}

.nav-link {
  text-transform: lowercase;
}
</style>