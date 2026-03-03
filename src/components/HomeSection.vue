<template>
  <section id="home">
    <picture id="home-bg-picture">
      <source :srcset="heroBg960Avif" type="image/avif" media="(max-width: 768px)" />
      <source :srcset="heroBg1600Avif" type="image/avif" media="(max-width: 1440px)" />
      <source :srcset="heroBgAvif" type="image/avif" />
      <source :srcset="heroBg960Webp" type="image/webp" media="(max-width: 768px)" />
      <source :srcset="heroBg1600Webp" type="image/webp" media="(max-width: 1440px)" />
      <img id="home-bg" :src="heroBgJpg" alt="" aria-hidden="true" fetchpriority="high" loading="eager"
        decoding="async" />
    </picture>
    <div id="hero">
      <h1 class="hero-h glitch-hero" data-text="Edgar Xavier">Edgar Xavier</h1>
      <h2 class="hero-s" :class="{ 'hero-s--enhanced': heroSubtitleEnhanced }">Full Stack Software Engineer</h2>
    </div>
    <div ref="canvasContainer" id="home-canvas"></div>
    <span class="transparent_gradient"></span>
  </section>
</template>

<script setup>
import { ref, onMounted, onBeforeUnmount } from 'vue';
import heroBgJpg from '../assets/imgs/bg-img2-compressed.jpg';
import heroBgAvif from '../assets/imgs/bg-img2-compressed.avif';
import heroBg960Avif from '../assets/imgs/bg-img2-960.avif';
import heroBg1600Avif from '../assets/imgs/bg-img2-1600.avif';
import heroBg960Webp from '../assets/imgs/bg-img2-960.webp';
import heroBg1600Webp from '../assets/imgs/bg-img2-1600.webp';

let threeDeps = null;

const canvasContainer = ref(null);
const figures = ref([]);
const heroSubtitleEnhanced = ref(false);
let scene, camera, renderer;
let initTimeoutId = null;
let initIdleId = null;
let subtitleEnhanceTimeoutId = null;
let mobileThreeStartHandler = null;
let shouldRunThree = true;
let sphereSegments = 16;
let pixelRatioCap = 1.25;

const prefersReducedMotion = () => window.matchMedia('(prefers-reduced-motion: reduce)').matches;

const connectionInfo = () => navigator.connection || navigator.mozConnection || navigator.webkitConnection;

const hasSaveData = () => {
  const connection = connectionInfo();
  return !!connection?.saveData;
};

const isDesktopLayout = () => window.matchMedia('(min-width: 963px)').matches;

const isLikelyMobileDevice = () => window.matchMedia('(pointer: coarse)').matches;

const isHighEndMobileDevice = () => {
  const cores = navigator.hardwareConcurrency || 0;
  const memory = navigator.deviceMemory || 0;

  if (memory > 0) {
    return cores >= 6 || memory >= 4;
  }

  return cores >= 6;
};

const isStrongNetwork = () => {
  const connection = connectionInfo();
  if (!connection) return false;

  const effectiveType = (connection.effectiveType || '').toLowerCase();
  const downlink = Number(connection.downlink || 0);

  return effectiveType === '4g' || downlink >= 10;
};

const loadThree = async () => {
  if (!threeDeps) {
    threeDeps = await import('../lib/three-home-deps');
  }
};

const getViewportSize = () => {
  const width = canvasContainer.value?.clientWidth || window.innerWidth;
  const height = window.innerHeight;
  return { width, height };
};

const initScene = () => {
  const { Scene, PerspectiveCamera, WebGLRenderer } = threeDeps;
  const { width, height } = getViewportSize();
  scene = new Scene();
  camera = new PerspectiveCamera(
    75,
    width / height,
    0.1,
    1000
  );

  createFigure(5, { rx: 0, ry: 0 }, { px: -3, py: -2 }, true, false);

  renderer = new WebGLRenderer({ antialias: false, powerPreference: 'high-performance' });
  renderer.setPixelRatio(Math.min(window.devicePixelRatio || 1, pixelRatioCap));
  renderer.setSize(width, height, false);
  renderer.domElement.style.display = 'block';
  renderer.domElement.style.width = '100%';
  renderer.domElement.style.maxWidth = '100%';
  canvasContainer.value.appendChild(renderer.domElement);
  camera.position.z = 15;
};

const createFigure = (size, rotation, position, animate, emitLight) => {
  const {
    Mesh,
    MeshStandardMaterial,
    PointLight,
    SphereGeometry,
  } = threeDeps;
  const { rx, ry } = rotation;
  const { px, py } = position;
  const geometry = new SphereGeometry(size, sphereSegments, sphereSegments);
  let material

  if (emitLight) {
    material = new MeshStandardMaterial({
      color: 0xffff00,
      emissive: 0xffaa00,
      emissiveIntensity: 1
    });
    const sunLight = new PointLight(0xffffff, 5, 100); // Color, intensity, distance
    sunLight.position.set(0, 0, 0);
    sunLight.castShadow = true
    scene.add(sunLight);
  } else material = new MeshStandardMaterial({
    color: 0xCCCCCC
  });
  const figure = new Mesh(geometry, material);
  figure.rotation.x += rx;
  figure.rotation.y += ry;

  figure.position.x = px;
  figure.position.y = py;

  figure.animate = animate;
  scene.add(figure);
  figures.value.push(figure);
  return figure;
}

const animate = () => {
  if (!renderer || !scene || !camera) return;
  const time = Date.now() * 0.0002;
  figures.value.forEach((fig, i) => {
    if (!fig.animate) return;
    // fig.position.y = Math.cos(time + i * 0.5); up and down movement
    const a = 8; // Semi-major axis (width of ellipse)
    const b = 3; // Semi-minor axis (height of ellipse)
    fig.position.x = a * Math.cos(time + i * .05); // Elliptical x-motion
    fig.position.z = b * Math.sin(time + i * 1); // Elliptical z-motion
  })
  renderer.render(scene, camera);
};

const handleResize = () => {
  if (!renderer || !camera || !shouldRunThree) return;
  const { width, height } = getViewportSize();
  camera.aspect = width / height;
  camera.updateProjectionMatrix();
  renderer.setSize(width, height, false);
  renderer.setPixelRatio(Math.min(window.devicePixelRatio || 1, pixelRatioCap));
};

const cleanup = () => {
  window.removeEventListener('resize', handleResize);

  if (!renderer || !canvasContainer.value) return;

  renderer.setAnimationLoop(null);
  if (canvasContainer.value.contains(renderer.domElement)) {
    canvasContainer.value.removeChild(renderer.domElement);
  }
  figures.value.forEach(fig => {
    fig.geometry.dispose();
    fig.material.dispose();
  });
  renderer.dispose();
};

const initThreeScene = async () => {
  if (!shouldRunThree || !canvasContainer.value) return;
  await loadThree();
  const { DirectionalLight } = threeDeps;
  initScene();
  renderer.setClearColor(0xffffff, .1); // Black
  const directionalLight = new DirectionalLight(0xffffff, .3);
  directionalLight.position.x = -1;
  directionalLight.position.z = 1;
  scene.add(directionalLight);
  renderer.setAnimationLoop(animate);
  window.addEventListener('resize', handleResize);
};

onMounted(() => {
  subtitleEnhanceTimeoutId = window.setTimeout(() => {
    heroSubtitleEnhanced.value = true;
  }, 1400);

  const reducedMotion = prefersReducedMotion();
  const saveData = hasSaveData();
  const desktopLayout = isDesktopLayout();
  const likelyMobile = isLikelyMobileDevice();
  const highEndMobile = isHighEndMobileDevice();
  const strongNetwork = isStrongNetwork();
  const mobileThreeOptIn = !desktopLayout && likelyMobile && (highEndMobile || strongNetwork);

  shouldRunThree = !reducedMotion && !saveData && (desktopLayout || mobileThreeOptIn);

  if (!shouldRunThree) return;

  if (mobileThreeOptIn) {
    sphereSegments = 12;
    pixelRatioCap = 1;
  }

  const startInit = () => {
    const mobileInitDelay = 4200;
    const desktopInitDelay = 1800;
    const initDelay = mobileThreeOptIn ? mobileInitDelay : desktopInitDelay;

    if ('requestIdleCallback' in window) {
      initIdleId = window.requestIdleCallback(() => {
        initThreeScene();
      }, { timeout: initDelay + 1500 });
      return;
    }

    initTimeoutId = window.setTimeout(() => {
      initThreeScene();
    }, initDelay);
  };

  const startWhenReady = () => {
    if (document.readyState === 'complete') {
      startInit();
      return;
    }

    const onLoad = () => {
      window.removeEventListener('load', onLoad);
      startInit();
    };
    window.addEventListener('load', onLoad, { once: true });
  };

  if (mobileThreeOptIn) {
    mobileThreeStartHandler = () => {
      window.removeEventListener('pointerdown', mobileThreeStartHandler);
      window.removeEventListener('touchstart', mobileThreeStartHandler);
      window.removeEventListener('scroll', mobileThreeStartHandler);
      window.removeEventListener('keydown', mobileThreeStartHandler);
      startWhenReady();
    };

    window.addEventListener('pointerdown', mobileThreeStartHandler, { passive: true, once: true });
    window.addEventListener('touchstart', mobileThreeStartHandler, { passive: true, once: true });
    window.addEventListener('scroll', mobileThreeStartHandler, { passive: true, once: true });
    window.addEventListener('keydown', mobileThreeStartHandler, { once: true });
    return;
  }

  startWhenReady();
});

onBeforeUnmount(() => {
  if (subtitleEnhanceTimeoutId !== null) {
    window.clearTimeout(subtitleEnhanceTimeoutId);
  }
  if ('requestIdleCallback' in window) {
    if (initIdleId !== null) {
      window.cancelIdleCallback(initIdleId);
    }
  }
  if (initTimeoutId !== null) {
    window.clearTimeout(initTimeoutId);
  }
  if (mobileThreeStartHandler) {
    window.removeEventListener('pointerdown', mobileThreeStartHandler);
    window.removeEventListener('touchstart', mobileThreeStartHandler);
    window.removeEventListener('scroll', mobileThreeStartHandler);
    window.removeEventListener('keydown', mobileThreeStartHandler);
  }
  cleanup();
});
</script>

<style scoped>
#home {
  min-height: 100vh;
  position: relative;
  overflow: hidden;
}

#home-bg-picture {
  position: absolute;
  inset: 0;
  z-index: 0;
}

#home-bg {
  position: absolute;
  inset: 0;
  width: 100%;
  height: 100%;
  object-fit: cover;
  object-position: center;
  z-index: 0;
}

#home-canvas {
  width: 100%;
  height: 100vh;
  position: relative;
  z-index: 1;
}

#hero {
  position: absolute;
  left: clamp(24px, 10vw, 20%);
  top: 35%;
  display: flex;
  flex-direction: column;
  align-items: flex-start;
  width: min(90vw, max-content);
  z-index: 2;
}

.hero-h,
.hero-s {
  margin: 0;
  display: block;
  width: 100%;
  text-align: left;
  line-height: 1em;
  text-shadow: 1px 4px 14px rgba(0, 0, 0, .62);
  font-weight: 600;
  text-transform: uppercase;
  letter-spacing: 2.2px;
  color: #fefefa;
}

.hero-h {
  font-size: clamp(4rem, 7.5vw, 6.25rem);
  line-height: 0.95;
  margin-left: 0;
  font-weight: 700;
  -webkit-text-stroke: 0.4px rgba(0, 0, 0, .55);
  text-shadow:
    1px 5px 16px rgba(0, 0, 0, .7),
    0 1px 0 rgba(0, 0, 0, .45);
}

.hero-s {
  font-size: 22px;
  margin-top: 8px;
  text-shadow: 0 1px 3px rgba(0, 0, 0, .35);
}

.hero-s--enhanced {
  -webkit-text-stroke: 0.4px rgba(0, 0, 0, .55);
  text-shadow:
    1px 5px 16px rgba(0, 0, 0, .7),
    0 1px 0 rgba(0, 0, 0, .45);
}

@media (max-width: 962px) {
  #hero {
    top: 40%;
  }

  .hero-h {
    font-size: 3em;
    margin-left: 0;
    text-shadow:
      1px 5px 16px rgba(0, 0, 0, .7),
      0 1px 0 rgba(0, 0, 0, .45);
  }

  .hero-s {
    font-size: 1.5em;
    text-shadow: 1px 4px 14px rgba(0, 0, 0, .7);
  }
}
</style>
