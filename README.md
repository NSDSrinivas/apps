# App pages

A hub site listing support & privacy pages for my apps. No build step — plain HTML/CSS.

## Structure

- `index.html` — the hub page, lists all apps (currently empty)
- `style.css` — shared styling
- `icon.png` — placeholder site icon
- Each app gets its own subfolder once it's ready, e.g.:
  ```
  /canyon-jumper/index.html   (Support page)
  /canyon-jumper/privacy.html (Privacy Policy)
  ```
  Then add a link to it in the `.app-list` on the root `index.html`.

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
