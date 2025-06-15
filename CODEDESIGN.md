# CodeDesign.md

## Overview

`clostco-dashboard-frontend` is a declarative Vue dashboard system with an opinionated architecture. It supports three independently scoped, AI-powered verticals:

* **Clost** – AWS cost analysis, prediction, and insights
* **Cloudog** – Cloud-native security visibility, threat awareness, and alerting
* **Clodoctor** – Pod-level reliability diagnostics and root cause introspection

This codebase is designed to require minimal effort to extend. Developers shouldn’t need to touch more than one file to add a new dashboard. All grouping, layout, and metadata come from a single source of truth.

---

## Design Objectives

* The router is the only source of layout metadata
* Navigation UI is dynamically generated from router config
* Styling is consistent, scoped, and domain-agnostic
* Layout files are presentation-only and reusable
* Vertical modules (Clost, Cloudog, Clodoctor) are self-contained
* All dashboard logic flows from route metadata

---

## Folder Philosophy

### 1. **Vertically isolated pages**

Each core domain (Clost, Cloudog, Clodoctor) owns its own folder under `pages/`. All dashboard logic and views for that vertical stay within that folder. There are no shared business rules across them unless explicitly factored into `composables/`.

### 2. **No layout intelligence in pages**

Files in `main-layouts/` (e.g., `NavigationBar.vue`) don’t hold any business rules. They only render layouts and shell elements.

### 3. **All computed logic in composables**

Derived logic like grouping nav sections, computing layout state, and reactive toggles belongs in `composables/`. Pages and layouts should import them when needed, never embed logic directly.

### 4. **The router defines structure and content**

The only source of truth is `router/index.js`. All dashboards, titles, icons, and grouping logic are written in one place. If you want something to show up in the nav — declare it in the router.

### 5. **Scoped styling with global consistency**

All styles go into `styles/_*.css`. Pages import only what they use. There are no inline `<style>` blocks unless absolutely necessary.

---

## Navigation Structure

We don’t manually maintain navigation lists. Instead, `useNavSections()` extracts them from the route config at runtime using `router.getRoutes()`.

Each route that should show up in the UI includes:

```js
meta: {
  section: 'Clost',
  title: 'Overview',
  icon: 'DollarSign',
  description: 'AI-powered AWS cost insights.'
}
```

This drives:

* Sidebar rendering
* Page header titles and subtitles
* Grouping by domain
* Automatic dropdown hover behavior

---

## Page Conventions

Each page like `Overview.vue` follows strict conventions:

* `<script setup>` only
* No layout logic
* One concern per file
* External state pulled from composables
* Styles imported from `styles/_*.css`

No side effects. No boilerplate. Focused and predictable.

---

## Layout Model

* `App.vue` mounts the layout shell
* `DashboardLayout.vue` renders top-level components like `NavigationBar.vue`
* `NavigationBar.vue` uses `useNavSections()` to fetch nav links

Layouts know nothing about business logic. This makes them portable.

---

## Developer Workflow

To create a new dashboard view:

1. Create a new `.vue` file inside `pages/{Domain}/`
2. Add the route to `router/index.js`, including proper `meta`
3. If needed, create or import styles in `styles/_xyz.css`

Done. It will show up automatically. You do not need to touch nav logic, layout containers, or config.

---

## Future Enhancements

The system is intentionally simple but extensible. We plan to support:

* Schema-driven dashboard generation (YAML/JSON-defined pages)
* Chart and table generators from declarative config
* AI integration for question-based navigation (“Why did my S3 bill spike?”)
* CLI or GUI to scaffold new dashboards

This is why route-driven layout is so important — it allows us to decouple UI from implementation.

---

## Dev Note

If you’re contributing:

* Don't hardcode navigation anywhere
* Don't write layout logic in views
* Don't duplicate anything that already comes from `router/index.js`
* Follow the conventions

The patterns are minimal because minimal patterns are stable. They make everything composable, replaceable, and easy to reason about.

We're not here to build another dashboard. We're building a platform that happens to be a dashboard.
