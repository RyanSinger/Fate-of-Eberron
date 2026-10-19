# Fate of Eberron Design System

Fate of Eberron is a fan adaptation of Fate Condensed for the Eberron setting: noir intrigue, magic as industry, and the long shadow of the Last War. This system covers the Jekyll site, printed table materials, and anything designed for the game on claude.ai.

## Voice

Plain, specific, a little hard boiled. Write "is", not "serves as". No em dashes or en dashes anywhere, including UI labels. No inflated words ("vibrant", "pivotal", "rich history"). Game terms keep their Fate capitalization: Overcome, Create an Advantage, Attack, Defend, Great (+4), Mild consequence. Examples use Eberron's own institutions (House Sivis, the Sharn Watch, the Korranberg Chronicle), never real ones.

## Themes

- **Noir** is the only screen theme: near black surfaces, warm off white ink, dragonshard gold accents, a cool blue second accent. It is the default and the first theme in `tokens.json`.
- **Parchment** is the print theme: cream paper, dark brown ink, gold darkened until it passes as text. It applies automatically when printing and on screen with `data-theme="parchment"` on `<html>` (the site sets this from `?theme=parchment`).
- **Handouts** ignore both and always render on their own paper tokens, because they stand in for physical objects.

## Color rules

- Surfaces stack `surface-0` (page), `surface-1` (cards, components), `surface-2` (insets, highlights).
- Text uses `ink`, `ink-soft` or `ink-muted`. In noir, `ink-muted` never sits on `surface-2`.
- `gold` is for headings, labels that matter, active states and dragonmark borders. `gold-bright` is for hover and `em`.
- `blue-bright` is for links, `h3`, code and focus rings. `blue` is a fill and border color.
- `red` fills and borders consequences and danger; `red-text` is the text version.
- `rule` is decorative only. Controls (stress boxes, write lines) use `ink-soft` borders so they pass 3:1.
- Meaning never rests on color alone: tiers carry a label and a glyph, outcomes carry a label.

## Type

Cinzel Decorative for the site title and hero only. Cinzel for headings and component labels (small caps feel: uppercase, 0.08em tracking, `--text-caption`). Open Sans for prose and rules text. Fira Code for numbers on the ladder. Sizes come from the nine `--text-*` steps; never set a raw rem size.

## Shape

Square corners by default (`radius-0`). Art deco detail comes from thin gold rules, corner brackets and diamonds, not rounded cards. `radius-round` is for dice, consequence circles, seals and countdown dials.

## Iconography

The four action icons and the fate die in the Icons group are multi-tone illustrations drawn dark on transparent. On noir they are inverted (`filter: invert(1) opacity(0.8)`); on parchment they are shown as drawn. Do not recolor them or trace simplified versions. There is no sigil art for the dragonmarks yet; leave `.aspect__sigil` empty rather than drawing a mark.

## Using the components

Every component is a CSS class (in `components.css`, or `handouts.css` for handouts). On the Jekyll site, prose components are written as markdown inside a wrapper, for example:

```html
<div class="aspect" data-label="High Concept" markdown="1">
*Cyran Artificer Who Lost Everything*
</div>
```

Repetitive markup comes from includes in `_includes/components/`: `track.html`, `consequences.html`, `pyramid.html`, `tier.html`, `ladder.html`, `seal.html`, `word-count.html`. Each component's guidelines say which applies. Outside Jekyll, copy the HTML from the component's preview.

## Source of truth

This system is published from the Fate of Eberron repository (`design/`, `assets/css/components.css`, `assets/css/handouts.css`). Edits made directly on claude.ai are overwritten by the next sync, so change the repository instead.
