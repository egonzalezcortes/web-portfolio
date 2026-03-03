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
    <SectionWaveDivider top-color="var(--vt-c-black-soft)" bottom-color="var(--vt-c-black)" />
    <ContactSection />
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
import ContactSection from './components/ContactSection.vue';
</script>