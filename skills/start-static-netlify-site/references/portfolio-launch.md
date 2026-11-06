# Portfolio launch checks

## Import the supplied artwork

- Inspect the supplied public posts and captions before choosing assets. Download the actual image, not a screenshot of the social page. If the browser download fails, a public image URL observed in the page can be downloaded directly; do not extract cookies or use private endpoints. Copy files locally because social CDN links expire.
- When the user requests originals verbatim, preserve downloaded bytes, borders, watermarks, and aspect ratios. Do not upscale, recolour, recompress, or crop them. Keep a source-post URL and a SHA-256 digest for each asset outside the publish directory.
- Separate the artwork's creation date from the post date. Use the caption's artwork year when known, group alternate views of one work, and retain relevant collaborator credits. Verify portrait alt text against the actual image. Do not invent a biography, dimensions, or dates.

## Share content across design variants

Generate the variants from one small artwork catalog and shared assets. Keep the same form name and field schema across variants so every signup reaches the same list. Use the briefs and presentation defaults in [Design directions](design-directions.md). Put the recommended design at `/`, give alternatives descriptive `/prototype-...` routes, and mark prototypes `noindex` with a canonical link to the main page. Link every available version in every footer. When the user selects another main design, preserve the previous main design as a named alternative, keep previously shared URLs working, and update navigation, current-page indicators, and page metadata together.

Keep the artwork near the top. Remove repeated discipline labels, numbered section subtitles, and unnecessary exploration prompts when the navigation and section headings already explain the page. Start with body text around 17–18px and readable navigation and captions; inspect the actual mobile rendering. Choose fonts with every required writing system, self-host them when practical, and retain their licenses. Keep generated branding and decorative icons separate from imported original artwork, save their prompts and source files outside the publish directory, and optimize only their web copies.

Keep images, calls to action, and menu links free of decorative arrow badges. Preserve accessible names and keyboard focus indicators. Unicode arrows and checkmarks can render as coloured emoji on mobile; use translated text for essential controls and actual SVG or image assets for deliberate graphics. Apply this across every variant, translation, and supporting page. When the user explicitly rules out default emoji, record that preference in the site's project instructions so later edits retain it.

For multilingual designs, share one translation catalog across variants. Translate the complete visitor flow, including form success and failure messages, count plurals, image descriptions, and supporting pages. Set the document language and preserve the selection in internal links as well as optional local storage. Use language names alongside decorative flags. Check the longest translations at a real narrow viewport, keyboard dismissal and focus return, and reduced-motion behavior for animated controls. Keep source artwork metadata and signup field names stable when translating the presentation.

## Finish the launch

When two sites on the same Free team show different Netlify branding, compare project creation dates and their individual badge settings. Netlify documents the badge as off for projects created before August 19, 2026 and on by default for newer Free projects, subject to rollout. An older unbranded site does not establish what a new site will show. [Badge rollout](https://docs.netlify.com/manage/projects/powered-by-netlify-badge/#when-is-the-badge-on)

Check the actual viewport width during mobile testing, every direct prototype route, original image framing, the bottom-of-page portrait, keyboard access to enlarged artwork, and all form states. A local static server cannot process Netlify Forms or platform Functions; verify those after deployment. Confirm a real stored submission and a real count change before calling the waitlist live. Remove only the disposable test entries and their count records after verification.

Hand back the live routes, signup destination, deployment method, and any remaining limitation. Ask which design the user prefers and whether any artwork or biography needs correction. Fold reproducible workflow problems into the reusable skill without including the site's private identifiers or account details.
