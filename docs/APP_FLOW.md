# APP_FLOW.md

# Last updated: 2026-03-25

# Purpose: tells Copilot where everything lives. Read this first.

## Business context

This is a Nuxt 3 static portfolio site for Edgar Gonzalez-Cortes, a senior full-stack software engineer. It serves recruiters, hiring managers, and engineering leaders who need fast evidence of production-level experience. The primary goal is to convert technical credibility into interview opportunities and direct contact for senior roles.
Full strategy context: docs/STRATEGY.md (read only when explicitly needed)

## Pages — where copy data lives

| Page     | File            | Where copy data is                                                                                                                                                                                                                                                                                     | Notes                                                                                                      |
| -------- | --------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ | ---------------------------------------------------------------------------------------------------------- |
| Home (/) | pages/index.vue | Page-level composition is in pages/index.vue; h1 and subhead are in components/HomeSection.vue; main copy blocks live inline in components/AboutSection.vue, components/CompetenciesSection.vue, components/ExperienceSection.vue, components/ProductionSection.vue, and components/ContactSection.vue | Single-page layout with section anchors (#home, #about, #competencies, #experience, #production, #contact) |

## Components — reusable pieces

| Component           | File                                                    | Used on                                                               | Purpose                                                               |
| ------------------- | ------------------------------------------------------- | --------------------------------------------------------------------- | --------------------------------------------------------------------- |
| AboutSection        | components/AboutSection.vue                             | /                                                                     | About narrative and engineering/leadership copy blocks                |
| CompetenciesSection | components/CompetenciesSection.vue                      | /                                                                     | Skills and capability groupings with tech badges                      |
| ContactSection      | components/ContactSection.vue                           | /                                                                     | Contact CTA, email link, and LinkedIn link                            |
| ExperienceSection   | components/ExperienceSection.vue                        | /                                                                     | Work history cards and impact statements                              |
| HomeSection         | components/HomeSection.vue                              | /                                                                     | Hero heading/subhead, responsive hero image, optional Three.js visual |
| NavBar              | components/NavBar.vue, app.vue, layouts/default.vue     | Global                                                                | Fixed navigation, mobile menu, smooth-scroll, nav sound effects       |
| ProductionSection   | components/ProductionSection.vue                        | /                                                                     | Infrastructure/deployment credibility section                         |
| SectionWaveDivider  | components/SectionWaveDivider.vue                       | Not currently used on /                                               | Decorative wave divider component for section transitions             |
| SiteFooter          | components/SiteFooter.vue, app.vue, layouts/default.vue | Global                                                                | Footer with tech stack badges and back-to-top control                 |
| SurfaceCard         | components/SurfaceCard.vue                              | AboutSection, ExperienceSection, ProductionSection, ContactSection    | Generic card wrapper with style props                                 |
| TechBadge           | components/TechBadge.vue                                | CompetenciesSection, ExperienceSection, ProductionSection, SiteFooter | Icon + label badge for technologies                                   |
| IconCommunity       | components/icons/IconCommunity.vue                      | Not currently used on /                                               | Inline SVG icon component                                             |
| IconDocumentation   | components/icons/IconDocumentation.vue                  | Not currently used on /                                               | Inline SVG icon component                                             |
| IconEcosystem       | components/icons/IconEcosystem.vue                      | Not currently used on /                                               | Inline SVG icon component                                             |
| IconSupport         | components/icons/IconSupport.vue                        | Not currently used on /                                               | Inline SVG icon component                                             |
| IconTooling         | components/icons/IconTooling.vue                        | Not currently used on /                                               | Inline SVG icon component                                             |

## Shared data files

All copy is inline in Vue files

## Config files — touch with caution

| File                        | Purpose                                   | When to edit                       |
| --------------------------- | ----------------------------------------- | ---------------------------------- |
| nuxt.config.ts              | framework config, route rules, SSG preset | route/redirect/module changes only |
| public/sitemap.xml          | sitemap                                   | when adding or removing pages      |
| plugins/analytics.client.ts | Simple Analytics integration              | analytics changes only             |

## Deploy workflow

1. Make changes locally
2. npm run generate
3. ./scripts/deploy.sh
4. Verify live at https://egonzalezcortes.com

## Known gotchas

- ERROR_LOG.md is not present, so there is no historical gotcha list to import.
- Most files in docs/lighthouse/ are placeholder markers like "(moved)" rather than valid JSON reports; use index-2026-03-24-mobile.json and index-2026-03-24-desktop.json for current valid baselines.
