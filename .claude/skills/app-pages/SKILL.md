---
name: app-pages
description: Scaffold, fill in, and publish an app's Support/Privacy pages on this repo's GitHub Pages "App Lab" hub (github.com/NSDSrinivas/apps). Use whenever the user wants to add a new app's support/privacy pages here, update an existing app's pages, or asks for App Store Connect Support URL / Privacy Policy URL pages for one of their apps.
---

# App Lab pages workflow

Full instructions live in [AGENTS.md](../../../AGENTS.md) at the repo root — read it before doing anything, and follow it exactly. It's written to be tool-agnostic (Claude Code, Codex, or any other agent, whether running here or inside the app's own repo) since scaffolding often happens in this repo while filling-in happens in the app's own repo.

In short: `scripts/scaffold-app.sh <slug> [destination]` copies `_template/` into a new app folder; an agent with access to the app's real source fills in `metadata/*.md` and the two HTML pages honestly (never invented); `scripts/import-app.sh <finished-folder> <slug>` brings it back here; then wire it into the hub's `index.html` app-grid, commit, push, and report the live URLs.

Never invent app names, data-collection claims, or privacy content — that's the one rule AGENTS.md repeats for a reason.
