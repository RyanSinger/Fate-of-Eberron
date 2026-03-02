# Fate of Eberron: Repo Improvement Pass

## Goal

Make the site more navigable, fix structural issues in the guides, clean up minor mechanics inconsistencies, and fill in campaign prep gaps. No new features or content redesigns; this is a polish and usability pass.

## Improvements

### 1. Fix Player's Guide heading hierarchy

**Problem**: Character creation Steps 1-2 are h3 headings (hidden from TOC), Steps 3-4 are h2 (visible in TOC). The 400-line mode catalog sits between Steps 2 and 3, interrupting the flow.

**Fix**: Make all character creation steps h2 headings. Keep the mode catalog where it is (it's reference material players need before Step 3) but give it clear h2 section headers (Origins, Backgrounds, Callings are already h2) so the TOC reads as a coherent sequence: Creating Your Character → Origins → Backgrounds → Callings → Remaining Aspects → Stunts.

### 2. Add in-page navigation to guide pages

**Problem**: Guide pages are 1,000+ lines with a TOC only at the top. Once you scroll past it, you're lost.

**Fix**: Add a back-to-top button (floating, bottom-right, appears after scrolling past the TOC). Keep it minimal: just a chevron-up icon in the gold accent color. No sticky sidebar TOC (too complex for this pass, and the guides are linear documents, not reference wikis).

### 3. Add favicon

**Problem**: 404 on every page load.

**Fix**: Generate a simple favicon from the site's art deco aesthetic: gold diamond or "FE" monogram on dark background. Add `<link rel="icon">` to default layout.

### 4. Fix mobile hero title overflow

**Problem**: "Fate of Eberron: Player's Guide" and its description clip off the right edge on 375px viewports.

**Fix**: Reduce guide-header font-size at the mobile breakpoint. Add word-wrap/overflow-wrap as safety net.

### 5. Slim down campaign character walkthrough

**Problem**: Mira Talan's build in campaign.md repeats the full step-by-step character creation process (100+ lines) already covered in the Player's Guide.

**Fix**: Keep Mira's final character sheet and the narrative explanation of why her choices fit the noir campaign. Cut the mechanical walkthrough steps and link to the Player's Guide instead.

### 6. Add client-side search

**Problem**: No way to find specific rules without scrolling through TOCs.

**Fix**: Add lunr.js (or similar zero-dependency client-side search). Index all guide pages. Search UI: input field in the nav bar (desktop) or behind a search icon (mobile). Results as a dropdown with section titles and snippets.

### 7. Make cross-references into links

**Problem**: Guides reference each other by name but don't link.

**Fix**: Find all "see the Player's Guide" / "see the GM's Guide" / "see the Setting Guide" mentions and make them `<a>` links. Also link specific section references (e.g., "see the Dragonmarks section") to their anchors.

### 8. Add GM's Guide reference to Setting Guide

**Problem**: Setting Guide only cross-references the Player's Guide at its end. GM's Guide is missing.

**Fix**: Add "For running the game, see the GM's Guide" to the Setting Guide's closing note.

### 9. Normalize mode stunt counts

**Problem**: Outlander and Mage list 3 suggested stunts; every other mode lists 2.

**Fix**: Pick the 2 most representative stunts for each and move the third to a "More stunt ideas" sidebar or cut it.

### 10. Normalize dragonmark stunt phrasing

**Problem**: Safe Haven (Ghallanda) says "once per session" while similar utility stunts say "once per scene."

**Fix**: Review whether Safe Haven's session limit is intentional (it is per CLAUDE.md: story declarations get session limits). Add a brief parenthetical explaining why ("story declarations are limited to once per session") so the inconsistency reads as intentional design, not an oversight.

### 11. Fill in campaign prep content

**Problem**: Campaign Brief, Characters, and Sessions sections are placeholders.

**Fix**: Add a "How to Use This Page" note explaining these sections get filled during/after Session 0. Add a Session 0 checklist (what to bring, what to decide) drawn from the GM's Guide's Session Zero section. The actual content stays empty until the campaign starts.

## Out of Scope

- Splitting guides into multi-page documents (too much restructuring)
- Sticky sidebar TOC (complex, guides are linear)
- Print stylesheet improvements (low priority, defer)
- New game mechanics or content
- Advancement of campaign content beyond Session 0 prep
