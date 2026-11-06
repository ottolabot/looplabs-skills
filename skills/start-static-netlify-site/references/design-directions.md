# Portfolio design directions

Use these reusable briefs when the user requests visual alternatives. Adapt the colours, identity, and subject matter to their project. Do not generate extra versions for an ordinary single-design edit. If prototypes are requested without a number or direction, start with the first four; offer the last three when useful. Prefer genuinely different composition, typography, framing, and ornament over palette swaps.

## Ready-to-use briefs

| Version | Brief | Distinguishing choices |
| --- | --- | --- |
| Light Gallery | An elegant portfolio with barely any copy: focus on the art. Light blue and sunny tones, soft but energetic, radiating light and love. | Pale-blue paper, deep-blue type, a confident serif, open artwork framing, small warm-yellow accents. A restrained illustrated butterfly can be the homepage menu control when requested. |
| Sunroom | A warm, sunlit room for the work, inviting and quietly joyful. | Cream paper, honey-yellow accents, soft serif type, generous white artwork mats, a painted sun seal. |
| Blue Salon | The flattest, clearest gallery: calm blue, direct typography, very little ornament. | Mostly flat surfaces, strong sans-serif type, geometric branding, fine dividing rules, a simple hamburger menu. |
| Atelier | A personal artist's studio, tactile and a little informal. Add a little of what the artist would actually say about each section. | Warm off-white, blue-grey ink, asymmetrical composition, subtly tilted paper mats, a signature or brush-drawn logo, short first-person introductions. |
| Funky | Totally wild, with cool, unusual stylistic elements. Make it look distinct from the other versions. Include more of the artist's voice in the sections. | Oversized expressive lettering, cobalt and pink, acidic yellow accents, paper stickers, painted scribbles, rotated cards, unexpected but readable alignment. Keep ornament clear of the artwork and controls. |
| Elegant | Reuse the supplied black-and-white logo and make the overall site more black and white. | Ink-black and white surfaces, expressive serif typography, quiet gallery framing, little decoration. Use the light logo on dark surfaces and an inverted dark version in a white footer. |
| Red Velvet | A sexy version with red tones and more graphical elements. | Cherry, burgundy, warm blush, sweeping curves, abstract ribbons, rounded framing, and sensual serif type. Express the mood through colour and composition; keep the supplied work central. |

Use descriptive routes such as `/prototype-sunroom`, `/prototype-funky-play`, and `/prototype-red-velvet`. The main page is the recommended or user-selected version. Keep content, artwork order, translations, signup handling, and counters shared across versions.

## Typography and copy

- Start with body text at 17–18px, captions and navigation at 15–17px, and secondary years or credits around 14px. Preserve readable sizes when fitting mobile layouts. Give headings a clear size hierarchy rather than making all text small and delicate.
- Choose deliberate font pairings and load their actual regular, italic, and bold styles. A literary serif with a clean sans serif, such as Literata with Manrope, is a useful starting point. Check support for the requested alphabets, retain font licenses, and verify the fonts actually loaded before judging the design.
- Keep the art near the top. Remove repeated phrases such as “Sculptures & paintings,” “Explore the collection,” and numbered “In three dimensions” subtitles when navigation and section headings already communicate them. Do not replace removed copy with equivalent filler.
- For Atelier and Funky, add one or two short, specific first-person sentences to each relevant section. Draft from the supplied works and facts, using language the artist might say. Treat these as proposed website copy, not verified quotations. Do not invent motivations, training, dates, or biographical claims. Keep other versions sparse unless the user asks for more copy.

## Group each work with its caption

Make each image and its metadata read as one unit. A useful starting point is an 8px image-to-caption gap on mobile and 12px on desktop, with roughly 48px between complete works on mobile. Adapt to framing and scale while keeping the internal gap much smaller than the gap between works.

Place title and year together. Keep material and dimensions immediately below, with a small 2–3px row gap; let long translations wrap naturally. Put collaborator credits in that same caption group and alternate-view thumbnails beneath it. Avoid stranding the year on the opposite edge or dimensions beside a separate thumbnail row.

If equal CSS gaps still look unequal, inspect the original files: social platforms often bake white bands into square images. Measure spacing from the visible photograph edge, not just the image element's box. When the user wants those gaps corrected, record visually reviewed per-image blank-band insets and hide only those bands in the gallery with an overflow wrapper and proportional CSS offsets. Keep source bytes unchanged and show the full original in the image viewer. Preserve photographed backgrounds, frames, shadows, signatures, and watermarks; do not automatically crop to the subject or force every work into one aspect ratio. Verify narrow and wide layouts and compare source hashes after the change.

## Branding and interaction

- Give each requested version a considered logo or treatment of the supplied identity. Avoid a generic initials-plus-symbol placeholder. When a monogram is supplied, preserve its identity; useful alternatives include vibrant blue and sunny-gold treatments, plus the original black-and-white version. Invert only the logo where contrasting surfaces require it, never the artwork.
- Use image generation when requested for painted logos, an Instagram mark, or hand-painted flags. Make these real graphic assets with transparency where appropriate. Keep language names beside flags and accessible names on icon-only links. Save prompts and original generated files separately from optimized public copies.
- Avoid default emoji and font-rendered symbol icons in these portfolio directions. Remove unnecessary arrows from images, signup buttons, menu links, and external links. Use clear translated words for Close, Previous, and Next; use SVG or painted assets for graphics that serve the design.
- If animated corner menus are requested, make the icon briefly move or shake when entering the viewport and visibly flip when clicked. A butterfly reserved for the homepage should move with the homepage when another design becomes the main version. Give alternatives their own suitable motif; use a simple hamburger for the flattest design. Honor reduced-motion preferences and keep keyboard focus and dismissal working.
- Let the footer's Languages text use the same typography as its neighbouring links and open the same language menu. Put the commission or contact action above Language in that menu and scroll it to the appropriate form. Do not use a generic “Contact me” label when the user specifies a more precise action such as “Your own sculpture.”

Inspect the result at narrow mobile widths and desktop, including long translations, the footer logo against its actual background, caption grouping, every prototype link, and the menu's visible animation. Use the user's chosen direction as the starting point for later edits rather than returning to a generic template.
