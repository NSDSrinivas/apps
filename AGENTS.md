# Working in this repo

This repo is a GitHub Pages "App Lab" hub. The root `index.html` lists every app as a card; each app has its own dedicated subfolder with its own info page and its own Privacy Policy page. Support is a single shared page (`support.html`) for all apps, since the contact channel is the same regardless of which app someone's writing about. Live at `https://nsdsrinivas.github.io/apps/`.

Read this whole file before scaffolding, filling in, or importing an app's pages — it applies whether you're Claude Code, Codex, or any other agent working in this repo or in an app's own repo on this machine.

## Layout

```
_template/               reference scaffold — copy this, never edit app content into it
  index.html              the app's own dedicated page (icon, tagline, about, FAQ), [App Name] placeholders
  privacy.html            the app's Privacy Policy page, [App Name] placeholders
  icon.png                placeholder icon
  metadata/               plain-language source-of-truth files, filled in per app
    app-info.md
    description.md
    privacy-details.md
    faq.md
    screenshots/
scripts/
  scaffold-app.sh <slug> [destination]   copy _template/ to a new app folder
  import-app.sh <src> <slug>             bring a finished folder back into this repo
<app-slug>/               one folder per real app, same shape as _template/
index.html                the hub page — one <li class="app-card"> per app
support.html              the single shared Support page for every app
style.css                 shared styles (hub layout + per-app page styles)
```

## Workflow: adding or updating an app

The point of `metadata/` is that another agent — one working inside the app's *own* repo, with access to its real source code and behavior — can fill in accurate details without ever guessing. Never invent app name, data-collection practices, or privacy claims; only use what's actually provided or verifiable in the app's own repo.

1. **Scaffold.** From this repo: `scripts/scaffold-app.sh <app-slug>` creates `<app-slug>/` here as a copy of `_template/`. If a different agent (in the app's own repo) will do the filling-in, pass a destination path inside that repo instead: `scripts/scaffold-app.sh <app-slug> /path/to/app-repo/app-pages-metadata`.
2. **Fill in**, ideally from inside the app's own repo:
   - `metadata/app-info.md` — real app name, subtitle, tagline, category, icon. (Support email is NOT per-app — it lives once in the root `support.html`.)
   - `metadata/description.md` — App Store description, keywords, promo text.
   - `metadata/privacy-details.md` — what data is actually collected and why, third parties, retention/deletion, children's privacy. This must match what will be declared in App Store Connect's "App Privacy" section.
   - `metadata/faq.md` — real FAQ for this app, or delete the file if there isn't one yet.
   - Replace `icon.png` with the real 1024×1024 icon.
   - Then apply all of that into `index.html` (about/FAQ) and `privacy.html`: replace every `[App Name]`, fill in the sections from the metadata, and **remove the yellow placeholder banner and the `<!-- TODO -->` comment block** at the top of each file once the content is real.
3. **Import.** Bring the finished folder back into this repo: `scripts/import-app.sh <finished-folder-path> <app-slug>`.
4. **Wire it into the hub.** Add or update an `<li class="app-card">` entry in the root `index.html`'s `<ul class="app-grid">`, matching the existing markup: an `<a class="card-link" href="<app-slug>/index.html" aria-label="Open <App Name>"></a>` as the card's first child (this is a "stretched link" — an absolutely-positioned, invisible `<a>` covering the whole card via CSS so the entire card is clickable and navigates to the app's page), then a `.app-icon-wrap` div holding the app icon (and optionally the App Store badge, see below), then `.app-info` with name, tagline, and an `.app-links` div with only the Privacy Policy link. Those stay independently clickable because `.app-icon-wrap`/`.app-links` are `position: relative; z-index: 2`, above the card-link's `z-index: 1`. Don't add a separate "View app" button; the card-link already covers that. Remove the "New" badge once an app isn't new anymore, or add it for a freshly added one.
   - **The card's hover effect must stay gated behind `@media (hover: hover) and (pointer: fine)`.** A `:hover` style on the card (an ancestor of the stretched card-link) is a known iOS Safari trap: without the media query gate, the first tap only triggers `:hover` and a second tap is needed to actually navigate. Don't remove that gate when touching `.app-card:hover`.
   - **Download icons/buttons are optional — never link a placeholder or a not-yet-live App Store listing.** Two places use them, both only once `metadata/app-info.md` has a real App Store URL:
     - **Hub card:** a small `.store-icon.store-icon--badge` overlapping the bottom-right corner of the icon inside `.app-icon-wrap` (see `index.html` for the exact markup) — icon-only, no label, since the card is small.
     - **App's own page:** a prominent `.download-cta` block (a black `.store-button` with the Apple SVG + "Download on the App Store" text, plus a `.download-help` one-line helper like "Free to play, works offline, no account required.") placed right after the tagline, before screenshots/About. `_template/index.html` ships this commented out — uncomment and fill in the href once there's a URL.
     - A Google Play version of each can be added the same way once there's an Android build — a second `.store-icon--badge` next to the first, and a second `.store-button` inside the same `.download-cta`.
   - **Screenshots are optional and must be real.** `_template/index.html` ships a commented-out `.screenshots` horizontal-scroll carousel (plain CSS, `overflow-x: auto` + scroll-snap, no JS) right after the download CTA. Only uncomment once real screenshots exist in the app's `metadata/screenshots/`; never use placeholder or fabricated images.
   - **Section headers (`section h2`, e.g. "About", "FAQ", and privacy/support section titles) are styled globally** with a colored accent bar — no per-app markup needed, just use `<section><h2>...</h2>...</section>` as usual.
5. **Publish.** `git add`, commit, push. GitHub Pages (`main` / root) redeploys automatically in about a minute.
6. **Report** the live URLs — `.../<app-slug>/index.html`, `.../<app-slug>/privacy.html`, and the shared `.../support.html` — the app-specific and Support URLs go into App Store Connect's Support URL and Privacy Policy URL fields (Apple wants a Support URL per app, so point it at the shared `support.html` for every app — that's fine, it's still live, public, and reachable per app).

## Updating the shared Support page

`support.html` at the repo root is edited directly, not through `metadata/` or the scaffold scripts — it isn't app-specific. Update its contact email there once, and every app's page already links to it.

## What Apple actually requires (why the pages are built this way)

- **Support URL** (Guideline 1.5): a live, public, no-login page with an actual way to contact the developer — email, contact form, or ticket system. An FAQ alone doesn't count. Can't be a social media profile or redirect back to the App Store listing. A single shared page is fine as long as it's live and reachable for each app's listing.
- **Privacy Policy URL**: must accurately describe what data is collected, why, who it's shared with, retention/deletion, and children's privacy — and must match the "App Privacy" nutrition-label answers given in App Store Connect. This one genuinely differs per app, which is why it stays per-app rather than shared.
- Both pages need to work on mobile Safari (reviewers test this).

## Ground rules

- Never fabricate app details, data-collection claims, or privacy policy content — leave placeholders in place and ask, or wait for `metadata/` to be filled in, rather than guessing.
- `_template/` is the reference scaffold — copy it per app, never hand-edit real app content into it.
- The repo must stay public (GitHub Pages requires it on the free tier).
