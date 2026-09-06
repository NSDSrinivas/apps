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

1. Create a subfolder for the app, e.g. `mkdir my-app`.
2. Add `index.html` (Support page) and `privacy.html` (Privacy Policy) inside it — see git history or ask Claude to generate a template.
3. Fill in the app name, real support email, real icon, and an accurate privacy policy matching the App Store Connect "App Privacy" answers.
4. Add a link to the new app in the root `index.html`'s app list.
5. Commit and push — Pages redeploys automatically.
6. Use `https://nsdsrinivas.github.io/apps/my-app/` and `.../my-app/privacy.html` as the Support URL and Privacy Policy URL in App Store Connect.
