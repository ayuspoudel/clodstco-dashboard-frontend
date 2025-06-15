# Clostco Dashboard

[![CI](https://img.shields.io/github/actions/workflow/status/ayuspoudel/clostco_dashboard_frontend/ci.yml?label=CI)](https://github.com/ayuspoudel/clostco_dashboard_frontend/actions)
[![License](https://img.shields.io/github/license/ayuspoudel/clostco_dashboard_frontend)](./LICENSE)
[![Vite](https://img.shields.io/badge/Built%20with-Vite-646CFF?logo=vite&logoColor=white)](https://vitejs.dev/)
[![Vue](https://img.shields.io/badge/Powered%20by-Vue%203-42B883?logo=vue.js&logoColor=white)](https://vuejs.org/)
[![Status](https://img.shields.io/badge/Status-WIP-orange)](#)

---

> **Dev Note:**  
> This dashboard is a work in progress. Everything is modular and future-proofed.  
> We're focusing on developer ergonomics first:  
> - Add a page → get automatic routing + nav  
> - Inject insights → get an AI-powered dashboard  
> - No hardcoded configs, no YAML hell, no layout rewrites  
> The stack is dead-simple so we can ship features fast.

---

## What is this?

This is the **frontend** for the unified `clostco` platform — a Grafana-style AI-powered dashboard suite for DevOps intelligence.

It currently includes three core modules:
- **Clost** → AI-powered AWS cost prediction + recommendation (Bedrock + SageMaker)
- **Cloudog** → Cloud security analytics (like Wiz; threat severity, insights)
- **Clodoctor** → Reliability diagnostics (e.g., “why did that pod fail at 2AM?”)

---

## Tech Stack

- **Vue 3** with `<script setup>`
- **Vue Router** — dynamic route + sidebar nav (fully generated from meta)
- **Vite** — fast build + HMR
- **Scoped CSS** — all styles live in `/styles/_*.css`
- **Composable layouts** — all dashboard shell UIs in `main-layouts/`

---

## Folder Structure

```bash
src/
├── pages/              # Each major module: Clost, Cloudog, Clodoctor
├── main-layouts/       # Nav bar, left bar, footer
├── routers/            # Vue Router setup, dynamic navSections
├── styles/             # All .css (split into _base, _vars, etc.)
├── composables/        # Shared logic like nav section extractor
├── App.vue             # Injects layout, renders views
```

---

## Getting Started

```bash
npm install
npm dev
```

> Dev server: `http://localhost:5173`
> Routing and nav are auto-generated from `router/index.js` based on `meta.title`, `meta.section`, etc.

---

## Todo (High Priority)

* [ ] Chart system (bar/line/pie per dashboard)
* [ ] Add “Add Dashboard” CLI → scaffold `.vue` + auto inject route
* [ ] AI integration (Bedrock queries for Clost + Clodoctor)
* [ ] Shared query layer between dashboards (via backend)
* [ ] Add auth system + tenant switcher (multi-tenant SaaS-ready)

---

## Related Repos

| Repo                         | Purpose                        |
| ---------------------------- | ------------------------------ |
| `clostco-dashboard-frontend` | This UI repo                   |
| `clostco-dashboard-backend`  | FastAPI API for all dashboards |
| `clostco-dashboard-infra`    | Terraform + CI/CD              |
| `clostco-dashboard-chatbox`  | Embedded AI chatbot UI + API   |

---

##  Philosophy

Build a **clean**, **extensible**, and **frictionless** platform that:

* scales with your infra
* auto-registers dashboards
* supports AI overlays on raw metrics
* never fights you when adding something

---

##  License

[MIT](./LICENSE)
