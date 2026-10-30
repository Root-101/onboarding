# Changelog

## 2.1.1 - 2026-10-30

- nginx serves every file with no-cache (revalidated with its ETag): a reload brings the new deploy, no need to clear the browser cache

## 2.1.0 - 2026-10-28

Phones and small windows get their own layout, from the design canvas.

- Mobile layout below 1024 px (it replaces the "made for desktop" notice): a header menu with the sections, the language and GitHub; every section in one column; the projects as a carousel and an accordion, with the previews scaled to the screen
- Maple preview: the dark backdrop of the canvas behind the phones
- Dumpling preview: the editor fills the whole window and its header no longer overflows
- Feather IO tab: both links show again (the second one was clipped)

## 2.0.0 - 2026-10-28

New site, built from scratch from the design canvas.

- Single-page landing: hero, marquee, about, projects, team, contact and footer, with a pinned header that jumps to each section
- Projects section with a live preview of each one: Winter, Feather IO, Dumpling (its pipeline editor) and Maple
- Project links: Winter (pub.dev, GitHub), Feather IO (Railway template, GitHub), Dumpling (GitHub), Maple (web)
- Team section with the members of Root101, with their photo, role and GitHub
- Contact section with GitHub and the contact email
- English and Spanish (slang); the chosen language survives a reload; if the browser blocks storage, its own language is used
- Brand icons, tab title and splash screen
- Docker image: Flutter web build served by nginx, CanvasKit bundled (no CDN, no debug symbols), security headers, nginx version hidden
- Flutter 3.47.1 (fvm)

## 1.0.2 - 2024-11-15

- Flutter SDK 3.24.1 (fvm)

## 1.0.1 - 2023-09-17

- Dockerfile updated to the latest deploy

## 1.0.0 - 2023-09-15

- First onboarding page and its Docker build
