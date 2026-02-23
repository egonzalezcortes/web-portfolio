<template>
  <div id="navbar">
    <h3 id="logo">EXGC</h3>
    <div>
      <svg v-if="screenWidth < 962" @click="toggleMenu" id="hamburger" class="toggle-svg" :class="{ active: open }"
        viewbox="0 0 60 40">
        <g stroke="#fff" stroke-width="4" stroke-linecap="round" stroke-linejoin="round">
          <path id="top-line" d="M10,10 L50,10 Z"></path>
          <path id="middle-line" d="M10,20 L50,20 Z"></path>
          <path id="bottom-line" d="M10,30 L50,30 Z"></path>
        </g>
      </svg>
      <ul v-if="screenWidth > 962 || open" id="nav-menu">
        <li>
          <a href="/">/home</a>
        </li>
        <li>
          <a href="expertise">/expertise</a>
        </li>
        <li>
          <a href="work">/work</a>
        </li>
        <li>
          <a href="experience">/experience</a>
        </li>
        <li>
          <a href="contact">/contact</a>
        </li>
      </ul>
    </div>
  </div>
</template>

<script setup>
import { ref, onMounted, onUnmounted } from 'vue';

const open = ref(false);
const toggleMenu = () => {
  open.value = !open.value;
};

// Reactive state for screen width
const screenWidth = ref(window.innerWidth);

// Function to update screen width
const updateScreenWidth = () => {
  screenWidth.value = window.innerWidth;
};

// Add event listener on mount and remove it on unmount
onMounted(() => {
  window.addEventListener('resize', updateScreenWidth);
});

onUnmounted(() => {
  window.removeEventListener('resize', updateScreenWidth);
});
</script>

<style scoped>
#navbar {
  width: 100%;
  position: fixed;
  display: flex;
  justify-content: space-between;
  flex-wrap: wrap;
  padding: 5px 20px;
  color: #fff;
  background-color: transparent;
}

#logo {
  font-size: 1.2em
}

#logo,
a {
  font-weight: 700;
}

li {
  list-style-type: none;
  padding-right: 2em;
  cursor: pointer;
  font-weight: 700;
}

ul {
  display: flex;
}

/* hamburger menu */
svg {
  width: 50px;
}

#top-line,
#bottom-line,
#middle-line {
  transform-box: fill-box;
  transform-origin: center;
}

svg:active {
  #top-line {
    animation: down-rotate 0.6s ease-out both;
  }

  #bottom-line {
    animation: up-rotate 0.6s ease-out both;
  }

  #middle-line {
    animation: hide 0.6s ease-out forwards;
  }
}

@keyframes up-rotate {
  0% {
    animation-timing-function: cubic-bezier(0.16, -0.88, 0.97, 0.53);
    transform: translateY(0px);
  }

  30% {
    transform-origin: center;
    animation-timing-function: cubic-bezier(0.34, 1.56, 0.64, 1);
    transform: translateY(-10px);
  }

  100% {
    transform-origin: center;
    transform: translateY(-10px) rotate(45deg) scale(0.9);
  }
}

@keyframes down-rotate {
  0% {
    animation-timing-function: cubic-bezier(0.16, -0.88, 0.97, 0.53);
    transform: translateY(0px);
  }

  30% {
    transform-origin: center;
    animation-timing-function: cubic-bezier(0.34, 1.56, 0.64, 1);
    transform: translateY(10px);
  }

  100% {
    transform-origin: center;
    transform: translateY(10px) rotate(-45deg) scale(0.9);
  }
}

@keyframes hide {
  29% {
    opacity: 1;
  }

  30% {
    opacity: 0;
  }

  100% {
    opacity: 0;
  }
}

@media (max-width: 962px) {
  li {
    padding-right: 1em;
  }
}
</style>