<template>
  <main>
    <NavBar />
    <HomeSection />
    <AboutSection />
    <SectionWaveDivider top-color="var(--vt-c-black)" bottom-color="var(--vt-c-black-soft)" />
    <CompetenciesSection />
    <SectionWaveDivider top-color="var(--vt-c-black-soft)" bottom-color="var(--vt-c-black)" />
    <ExperienceSection />
    <SectionWaveDivider top-color="var(--vt-c-black)" bottom-color="var(--vt-c-black-soft)" />
    <ProductionSection />
  </main>
</template>

<script setup>
import NavBar from './components/NavBar.vue';
import HomeSection from './components/HomeSection.vue';
import AboutSection from './components/AboutSection.vue';
import SectionWaveDivider from './components/SectionWaveDivider.vue';
import CompetenciesSection from './components/CompetenciesSection.vue';
import ExperienceSection from './components/ExperienceSection.vue';
import ProductionSection from './components/ProductionSection.vue';
</script>