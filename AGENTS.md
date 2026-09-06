# Working in this repo

This repo is a GitHub Pages "App Lab" hub: a landing page (`index.html`) listing cards for each app, where each app has its own subfolder with a Support page, a Privacy Policy page, and a `metadata/` folder of source-of-truth details. Live at `https://nsdsrinivas.github.io/apps/`.

Read this whole file before scaffolding, filling in, or importing an app's pages — it applies whether you're Claude Code, Codex, or any other agent working in this repo or in an app's own repo on this machine.

## Layout

```
_template/               reference scaffold — copy this, never edit app content into it
  index.html              Support page, [App Name] placeholders
  privacy.html            Privacy Policy page, [App Name] placeholders
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
style.css                 shared styles (hub layout + per-app page styles)
```

## Workflow: adding or updating an app

The point of `metadata/` is that another agent — one working inside the app's *own* repo, with access to its real source code and behavior — can fill in accurate details without ever guessing. Never invent app name, data-collection practices, or privacy claims; only use what's actually provided or verifiable in the app's own repo.

1. **Scaffold.** From this repo: `scripts/scaffold-app.sh <app-slug>` creates `<app-slug>/` here as a copy of `_template/`. If a different agent (in the app's own repo) will do the filling-in, pass a destination path inside that repo instead: `scripts/scaffold-app.sh <app-slug> /path/to/app-repo/app-pages-metadata`.
2. **Fill in**, ideally from inside the app's own repo:
   - `metadata/app-info.md` — real app name, subtitle, tagline, category, support email, icon.
   - `metadata/description.md` — App Store description, keywords, promo text.
   - `metadata/privacy-details.md` — what data is actually collected and why, third parties, retention/deletion, children's privacy. This must match what will be declared in App Store Connect's "App Privacy" section.
   - `metadata/faq.md` — real support FAQ, or delete the file if there isn't one yet.
   - Replace `icon.png` with the real 1024×1024 icon.
   - Then apply all of that into `index.html` and `privacy.html`: replace every `[App Name]` and `support@example.com`, fill in the FAQ and privacy sections from the metadata, and **remove the yellow placeholder banner and the `<!-- TODO -->` comment block** at the top of each file once the content is real.
3. **Import.** Bring the finished folder back into this repo: `scripts/import-app.sh <finished-folder-path> <app-slug>`.
4. **Wire it into the hub.** Add or update an `<li class="app-card">` entry in the root `index.html`'s `<ul class="app-grid">`, matching the existing markup (icon, name, one-line tagline, Support + Privacy Policy links). Remove the "New" badge once an app isn't new anymore, or add it for a freshly added one.
5. **Publish.** `git add`, commit, push. GitHub Pages (`main` / root) redeploys automatically in about a minute.
6. **Report** the two live URLs — `.../<app-slug>/index.html` (or the folder URL) and `.../<app-slug>/privacy.html` — these go into App Store Connect's Support URL and Privacy Policy URL fields.

## What Apple actually requires (why the pages are built this way)

- **Support URL** (Guideline 1.5): a live, public, no-login page with an actual way to contact the developer — email, contact form, or ticket system. An FAQ alone doesn't count. Can't be a social media profile or redirect back to the App Store listing.
- **Privacy Policy URL**: must accurately describe what data is collected, why, who it's shared with, retention/deletion, and children's privacy — and must match the "App Privacy" nutrition-label answers given in App Store Connect. Apple checks this by hand, not just automated scanning.
- Both pages need to work on mobile Safari (reviewers test this).

## Ground rules

- Never fabricate app details, data-collection claims, or privacy policy content — leave placeholders in place and ask, or wait for `metadata/` to be filled in, rather than guessing.
- `_template/` is the reference scaffold — copy it per app, never hand-edit real app content into it.
- The repo must stay public (GitHub Pages requires it on the free tier).
