# App pages

A hub site ("App Lab") listing support & privacy pages for my apps. No build step — plain HTML/CSS.

## Structure

- `index.html` — the hub page, lists all apps as cards
- `style.css` — shared styling (hub layout + per-app page styles)
- `icon.png` — placeholder site icon
- Each app has its own subfolder, e.g.:
  ```
  /number-circuit/index.html   (Support page)
  /number-circuit/privacy.html (Privacy Policy)
  /number-circuit/icon.png
  ```
  Add a link to it as an `<li class="app-card">` in the root `index.html`.

Currently listed: **Number Circuit** (placeholder content — real name/email/icon/privacy details still needed).

## Publishing with GitHub Pages

Already set up: pushed to `https://github.com/NSDSrinivas/apps`, served from `main` / root via Settings → Pages.

Site: `https://nsdsrinivas.github.io/apps/`

## Adding a new app

See [AGENTS.md](AGENTS.md) for the full workflow (also usable as a Claude Code skill: `.claude/skills/app-pages/`). Short version:

1. `scripts/scaffold-app.sh <app-slug> [destination]` copies `_template/` into a new placeholder folder — locally, or into the app's own repo so an agent there can fill it in from the real source.
2. Fill in `metadata/*.md` honestly, then apply that into `index.html`/`privacy.html` and swap in the real icon.
3. `scripts/import-app.sh <finished-folder> <app-slug>` brings it back into this repo.
4. Add an `<li class="app-card">` for it in the root `index.html`, commit, push.
5. Use `https://nsdsrinivas.github.io/apps/<app-slug>/` and `.../<app-slug>/privacy.html` as the Support URL and Privacy Policy URL in App Store Connect.
