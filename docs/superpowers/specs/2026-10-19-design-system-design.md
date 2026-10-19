# Fate of Eberron Design System: Design

Date: 2026-10-19
Status: approved in brainstorming, awaiting spec review

## Goal

One set of tokens and components that gives every Fate of Eberron surface the same identity: the Jekyll site, printed table materials, and Design artifacts made on claude.ai. Anything new (a character sheet, an NPC card, a handout) should look like it belongs without anyone restyling it from scratch.

## Decisions

| Question | Decision |
|---|---|
| Where is it used | Both the Jekyll site and claude.ai Design artifacts |
| Themes | Noir is the only screen theme. Parchment is the print theme, also available on screen by opt in |
| Component scope | Character pieces, adversary stat block, rules reference, dragonmark treatment, in-world handouts |
| Source of truth | The repo. The claude.ai Design System artifact is published from it |
| Noir contrast failures | Fixed (two values change on the live site) |

The current Art Deco Noir look is the identity. This work formalizes and extends it; it does not replace it.

## Architecture

```
design/
  tokens.json            source of truth: colors (noir + parchment), type, spacing, radius
  README.md              brand book: voice, foundations, iconography, usage rules
  components/<Name>/     README.md + preview.html per component (artifact side)
design-sample.md         hidden page rendering every component in both themes
_plugins/
  design_tokens.rb       Jekyll generator: design/tokens.json to /assets/css/tokens.css at build
assets/css/
  style.css              existing site chrome, refactored to read only from tokens
  components.css         game components; also published as the artifact's bundle.css
  handouts.css           in-world documents, layered on tokens
_includes/components/    pyramid.html, track.html, consequences.html, ladder.html, seal.html, word-count.html
.claude/skills/design-sync/SKILL.md
tests/design.sh          token shape, unique names, contrast in both themes, build check
```

### Data flow

1. `design/tokens.json` is written in the claude.ai Design System list format (`{"tokens":[{"name","value","usage"}]}` per family, `color.themes` listing `noir` first, then `parchment`). The same file is published to the artifact unchanged.
2. `_plugins/design_tokens.rb` reads it at build time and emits `tokens.css`:
   - noir values on `:root`
   - parchment values under `@media print` and under `[data-theme="parchment"]`
   - type styles, spacing and radius as custom properties
   No generated CSS is committed, so it cannot drift. The GitHub Actions workflow runs a full `bundle exec jekyll build`, so custom plugins work in deploy.
3. `default.html` links `tokens.css` before `style.css`, `components.css` and (on handout pages) `handouts.css`.
4. `design/` is added to `exclude` in `_config.yml`; the plugin reads `tokens.json` from disk, so exclusion does not affect it. `design-sample.md` sits at the repo root, builds with `sitemap: false`, and has no nav link.

## Tokens

### Color

| token | noir | parchment | usage |
|---|---|---|---|
| `surface-0` | `#1a1a1f` | `#f4ecd8` | Page background, paper |
| `surface-1` | `#252530` | `#ebe0c6` | Nav, cards, TOC |
| `surface-2` | `#2f2f3a` | `#e0d3b4` | Inset panels, table stripes |
| `ink` | `#e8e6e3` | `#1f1b16` | Body text on any surface |
| `ink-soft` | `#a8a5a0` | `#4a4238` | Secondary text on any surface |
| `ink-muted` | `#918e89` | `#5f5444` | Captions and metadata. Noir: surface-0 and surface-1 only |
| `gold` | `#c9a227` | `#735709` | Headings, accents, active states, dragonmark borders |
| `gold-bright` | `#dbb84d` | `#a8831a` | Hover. On parchment, decoration only (fails text contrast) |
| `blue` | `#4a90a4` | `#2a5c6c` | Links. Noir: surface-0 only for text |
| `blue-bright` | `#6bb3c9` | `#3d7a8e` | Link hover, second accent. Parchment: large text and borders only |
| `red` | `#a44a4a` | `#8a3030` | Fills and borders for consequences and danger |
| `red-text` | `#dc7f7f` | `{red}` | Text for consequences, failure, danger |
| `rule` | `#3a3a45` | `#b9a67c` | Borders, dividers, stress box outlines |
| `shadow` | `rgba(0, 0, 0, 0.4)` | `rgba(60, 40, 10, 0.15)` | Drop shadows |

Changes from today's site: `ink-muted` moves from `#6b6966` (3.17:1, failing) to `#918e89`; `red-text` is new. Every other noir value is unchanged.

Measured contrast for the changed and new text tokens:

| token | surface-0 | surface-1 | surface-2 |
|---|---|---|---|
| noir `ink-muted` `#918e89` | 5.31 | 4.64 | not allowed |
| noir `red-text` `#dc7f7f` | 6.10 | 5.33 | 4.65 |
| parchment `ink-muted` `#5f5444` | 6.28 | 5.64 | 4.98 |
| parchment `gold` `#735709` | 5.76 | 5.17 | 4.57 |

### Type

Families are unchanged and load from Google Fonts:

| family key | stack |
|---|---|
| `display` | `'Cinzel Decorative', 'Cinzel', Georgia, serif` |
| `heading` | `'Cinzel', Georgia, serif` |
| `body` | `'Open Sans', -apple-system, BlinkMacSystemFont, sans-serif` |
| `mono` | `'Fira Code', Consolas, monospace` |

The scale collapses today's 18 font sizes to 8 steps. Existing sizes snap to the nearest step (largest shift 0.1rem):

| style | family | size | use |
|---|---|---|---|
| `display` | display | 3.2rem | Hero title |
| `h1` | heading | 2.5rem | Guide titles |
| `h2` | heading | 2rem | Section heads |
| `h3` | heading | 1.4rem | Subsections, stat block names |
| `h4` | heading | 1.2rem | Component labels, card titles |
| `body` | body | 1rem | Prose, line height 1.7 |
| `small` | body | 0.9rem | Nav, tables, rules text in components |
| `caption` | body | 0.8rem | Footer, metadata, aspect labels |

### Spacing and radius

Spacing keeps the existing six steps: `space-xs` 0.25rem, `space-sm` 0.5rem, `space-md` 1rem, `space-lg` 1.5rem, `space-xl` 2rem, `space-xxl` 3rem.

Radius: `radius-0` 0 (the default; art deco is mostly square), `radius-sm` 4px (cards, as today), `radius-round` 50% (fate dice, refresh tokens).

## Components

All components live in `components.css`, read only from tokens, and work in both themes. Authoring rule: if the content is prose, wrap existing markdown in `<div class="..." markdown="1">`; if the markup is repetitive, use an include.

### Character pieces

- **Aspect** (`.aspect`): label (High Concept, Motivation, Background, Relationship, Free) in `caption` Cinzel small caps, then the aspect text. Optional free invoke pips via `data-invokes="2"`.
- **Skill pyramid** (`{% include components/pyramid.html %}`): rows Great (+4) to Average (+1) with 1, 2, 3, 4 slots. Optional `skills="Fight,Athletics,..."` fills slots in order; empty slots render as write lines.
- **Stunt** (`.stunt`): name, a source tag (archetype, background, charter, species), rules text. `data-cost="1"` shows a refresh cost tag.
- **Track** (`{% include components/track.html label="Physical" boxes=3 %}`): square boxes. Screen: real checkboxes, no saved state. Print: empty squares. Used for stress, refresh and countdowns; `style="clock"` renders a segmented circle for countdowns.
- **Consequences** (`{% include components/consequences.html slots="mild,moderate" %}`): each slot labelled with its shift value (2, 4, 6) and a write line, labels in `red-text`.

### Dragonmark treatment

- **Mark aspect** (`.aspect--dragonmark`): label reads mark and house (*Mark of Finding · House Tharashk*). Thin `gold` filigree border with a faint `gold-bright` inner glow suggesting Siberys shard light. No per house colors.
- **House stunt** (`.stunt--house`): tagged *House exclusive*, with the same filigree corner.
- **Sigil slot**: optional image slot. The repo has no sigil art, and canon marks are not to be approximated, so the slot stays empty until real art exists.

### Adversary stat block

`.statblock` replaces the bold labels and `[ ]` brackets in `npcs.md` and `gm-guide.md`.

- Header: name, pronouns, role, and a **tier badge** (Threat, Filler, Hitter, Boss, Obstacle) distinguished by label and shape, never by color alone.
- Body sections in order: aspects, skills, stunts, track(s), consequences, then the existing prose.
- Migration wraps each block and swaps `[ ] [ ] [ ]` for the track include. No prose changes.

### Rules reference

- **Ladder** (`{% include components/ladder.html highlight="4" %}`): Legendary (+8) to Terrible (-2), optional highlighted step.
- **Actions**: existing four action grid and icons moved onto tokens. The SVGs in `images/icons/` are cleaned of Illustrator boilerplate and switched to `currentColor` so they render on parchment.
- **Outcomes** (`.outcomes`): fail, tie, succeed, succeed with style as a four column strip.
- **Fate die glyphs** (`.die--plus`, `.die--minus`, `.die--blank`): inline faces for rules text and examples.

## In-world handouts

`handouts.css` adds handout-only tokens (paper tones, extra families) as additions, not overrides. Handouts always render on paper tones, including on noir pages, and print one per US Letter page. Only Eberron's fictional institutions appear; never real people or organizations.

| handout | class | look | fonts |
|---|---|---|---|
| Korranberg Chronicle | `.handout--chronicle` | Multi-column newsprint, dense masthead, column rules, dateline, short headlines, off-white stock | UnifrakturMaguntia masthead, Old Standard TT body |
| House letterhead | `.handout--letter` | Cream laid paper, house name in engraved small caps, seal slot, signature line | Cinzel, Cormorant Garamond |
| Sending message slip | `.handout--sending` | Narrow slip, typed text, 25-word tick counter, Sivis stamp block | Courier Prime |
| Wanted poster | `.handout--wanted` | Heavy border, large condensed name, portrait slot, reward line, Watch authority footer | Playfair Display SC, Old Standard TT |

Includes: `{% include components/seal.html house="Sivis" %}` (empty seal slot with house label) and `{% include components/word-count.html words=18 %}` (tick row out of 25). Handout fonts load only on pages with `handouts: true` in front matter.

## Sync to claude.ai

`.claude/skills/design-sync/SKILL.md` publishes the repo to the claude.ai Design System artifact:

1. Read the artifact's current `project/design-system.json`.
2. Stage `design/tokens.json`, `design/README.md`, `design/components/*`, `assets/css/components.css` (as `components/bundle.css`, with `handouts.css` appended) and the cleaned icon SVGs (uploaded as assets in an Icons group) under the artifact's `project/` layout.
3. Publish once, with the index last and its `lastChange` set.
4. State that edits made on the claude.ai page are overwritten by a sync.

The skill description tells sessions to run it whenever `design/`, `components.css` or `handouts.css` changes. The artifact URL is recorded in `CLAUDE.md` with an instruction to read the system's README before designing any sheet, card or handout.

The artifact `README.md` is the brand book: voice (from CLAUDE.md's writing rules), visual foundations, iconography, token usage rules, class names and includes, and the handout rules.

## Migration order

Each step is its own commit, built and pushed.

1. **Tokens and plugin.** Add `tokens.json` and `design_tokens.rb`; replace the `:root` block in `style.css` with token names; apply the two contrast fixes and the type scale snap. Verify the site matches today apart from brighter captions and TOC sublinks.
2. **Components.** Add `components.css`, the includes and `design-sample.md` (`?theme=parchment` sets `data-theme` on screen via `main.js`).
3. **Stat blocks.** Convert `npcs.md` and `gm-guide.md`. Verify with a diff that only wrappers and include swaps changed.
4. **Handouts.** Add `handouts.css` and one example of each on the sample page.
5. **Sync.** Write `design-sync`, create the Design System artifact titled "Fate of Eberron", publish, record the URL in CLAUDE.md.

## Testing

`tests/design.sh`, called from `tests/run.sh`:

- `tokens.json` parses; every family is list shaped; every color value is a form the Design System reads (hex, `rgb()`, `rgba()`, or an alias to an existing token); no name repeats.
- Every text and surface pair permitted by a usage note passes 4.5:1 in both themes; borders and large text pass 3:1.
- `bundle exec jekyll build` succeeds and `_site/assets/css/tokens.css` exists with both themes.
- No raw hex colors in `style.css`, `components.css` or `handouts.css` outside handout token definitions.

By eye before each commit: the sample page in noir and parchment, and a print to PDF.

## Out of scope

- Full character sheet page and GM screen page (later compositions built from these parts)
- Dragonmark sigil art
- A light mode for the site
- Saved state for track checkboxes
