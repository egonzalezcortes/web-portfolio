<template>
  <section id="home">
    <img id="home-bg" :src="heroBg" alt="" aria-hidden="true" fetchpriority="high" decoding="async" />
    <div id="hero">
      <h1 class="hero-h">Edgar Xavier</h1>
      <h2 class="hero-s">Full Stack Software Engineer</h2>
    </div>
    <div ref="canvasContainer" id="home-canvas"></div>
    <span class="transparent_gradient"></span>
  </section>
</template>

<script setup>
import { ref, onMounted, onBeforeUnmount } from 'vue';
import heroBg from '../assets/imgs/bg-img2-compressed.jpg';

let threeDeps = null;

const canvasContainer = ref(null);
let error = ref(false);
const figures = ref([]);
let scene, camera, renderer;
let initTimeoutId = null;
let initIdleId = null;

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

  // createFigure('SPHERE', 2, { rx: 0, ry: 0 }, { px: 0, py: 0 }, false, true);
  createFigure('SPHERE', 5, { rx: 0, ry: 0 }, { px: -3, py: -2 }, true, false);
  // createFigure('SPHERE', 3, { rx: 0, ry: 0 }, { px: 10, py: -6 }, true, false);
  // createFigure('CYLINDER', 500, 500, -1, -1);

  renderer = new WebGLRenderer();
  renderer.setSize(width, height, false);
  renderer.domElement.style.display = 'block';
  renderer.domElement.style.width = '100%';
  renderer.domElement.style.maxWidth = '100%';
  canvasContainer.value.appendChild(renderer.domElement);
  camera.position.z = 15;
};

const createFigure = (type, size, rotation, position, animate, emitLight) => {
  const {
    BoxGeometry,
    CylinderGeometry,
    Mesh,
    MeshStandardMaterial,
    PointLight,
    SphereGeometry,
  } = threeDeps;
  const { rx, ry } = rotation;
  const { px, py } = position;
  let geometry;
  let material
  if (type === 'CUBE') geometry = new BoxGeometry(size, size, 1);
  else if (type === 'CYLINDER') geometry = new CylinderGeometry(1, 1, 5, 32);
  else if (type === 'SPHERE') geometry = new SphereGeometry(size, 32, 32);
  else {
    error.value = true;
    return null;
  };

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
  const { width, height } = getViewportSize();
  camera.aspect = width / height;
  camera.updateProjectionMatrix();
  renderer.setSize(width, height, false);
};

const cleanup = () => {
  if (!renderer || !canvasContainer.value) return;

  renderer.setAnimationLoop(null);
  window.removeEventListener('resize', handleResize);
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
  if ('requestIdleCallback' in window) {
    initIdleId = window.requestIdleCallback(() => {
      initThreeScene();
    }, { timeout: 1200 });
    return;
  }

  initTimeoutId = window.setTimeout(() => {
    initThreeScene();
  }, 250);
});

onBeforeUnmount(() => {
  if (initIdleId !== null && 'cancelIdleCallback' in window) {
    window.cancelIdleCallback(initIdleId);
  }
  if (initTimeoutId !== null) {
    window.clearTimeout(initTimeoutId);
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
  left: 20%;
  top: 35%;
  display: flex;
  flex-direction: column;
  align-items: flex-start;
  width: max-content;
  z-index: 2;
}

.hero-h,
.hero-s {
  margin: 0;
  display: block;
  width: max-content;
  text-align: left;
  line-height: 1em;
  text-shadow: 1px 3px 11px rgba(0, 0, 0, .5);
  font-weight: 600;
  text-transform: uppercase;
  letter-spacing: 2.2px;
  color: #fefefa;
}

.hero-h {
  font-size: 145px;
  margin-left: -0.02em;
}

.hero-s {
  font-size: 22px;
  margin-top: 8px;
}

@media (max-width: 962px) {
  #hero {
    top: 40%;
  }

  .hero-h {
    font-size: 3em;
    margin-left: 0;
  }

  .hero-s {
    font-size: 1.5em;
  }
}
</style>
