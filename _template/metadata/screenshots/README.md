Put real product screenshots here. Screenshots are optional; omit the gallery until captures are available.

For one gallery, use the existing `.screenshots` markup on the product details page.

For an optional device selector, wrap separate `.screenshots` galleries in a
`<div data-screenshot-gallery>`. Give each gallery a `data-device` label and an
`aria-label`, for example `data-device="Mac" aria-label="Mac screenshots"`.
Use iPhone, iPad, Mac, and Apple Watch as appropriate; include only devices with
real captures. Suggested subfolders: `iphone/`, `ipad/`, `mac/`, and `watch/`.
Describe the actual screen in each image's alt text.

The page must load `../site.js`. Two or more populated groups automatically get
a segmented tab selector; one group displays without a selector. The first group
is selected initially. Arrow keys, Home, and End switch tabs. With JavaScript
disabled, every gallery stays visible. Keep groups visible in the source HTML
(do not add `hidden`). The carousel itself uses CSS scrolling and scroll snap.

The template includes a commented example. Never publish its example image paths
until they have been replaced with paths to real files.
