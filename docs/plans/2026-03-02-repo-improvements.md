# Repo Improvement Pass — Implementation Plan

> **For Claude:** REQUIRED SUB-SKILL: Use superpowers:executing-plans to implement this plan task-by-task.

**Goal:** Polish the Fate of Eberron site: fix guide navigation, add back-to-top, add favicon, fix mobile overflow, slim campaign walkthrough, add search, link cross-references, normalize stunts, clarify dragonmark phrasing, and add Session 0 prep to campaign page.

**Architecture:** Jekyll 4.3 static site. Plain CSS (no preprocessor), vanilla JS. All changes are to markdown content, one CSS file (`assets/css/style.css`), one JS file (`assets/js/main.js`), one layout (`_layouts/default.html`), and one layout (`_layouts/guide.html`). No build tools or dependencies to add except lunr.js for search.

**Tech Stack:** Jekyll 4.3, vanilla JS, lunr.js (CDN), plain CSS

---

### Task 1: Fix Player's Guide heading hierarchy

**Files:**
- Modify: `players-guide.md:57` (Step 1 heading)
- Modify: `players-guide.md:67` (Step 2 heading)
- Modify: `players-guide.md:110` (The Modes heading)

**Step 1: Promote Step 1 and Step 2 from h3 to h2**

At line 57, change:
```markdown
### Step 1: High Concept and Trouble
```
to:
```markdown
## Step 1: High Concept and Trouble
```

At line 67, change:
```markdown
### Step 2: Choose Three Modes
```
to:
```markdown
## Step 2: Choose Three Modes
```

**Step 2: Demote "The Modes" from h3 to a paragraph**

At line 110, change:
```markdown
### The Modes
```
to:
```markdown
**The Modes**
```

This line is a brief intro before the Origins/Backgrounds/Callings h2 sections. It doesn't need to be a heading since it's just a paragraph of context.

**Step 3: Verify the TOC now reads coherently**

Run `bundle exec jekyll build` and check `_site/players-guide.html`. The TOC should now show:
- What Is Fate?
- What You Need to Know
- Creating Your Character
- Step 1: High Concept and Trouble
- Step 2: Choose Three Modes
- Origins
- Backgrounds
- Callings
- Step 3: Remaining Aspects
- Step 4: Stunts
- Dragonmarks
- Magic and Artifice
- Playing the Game
- Quick Reference: Skill List
- Sample Character: Kaela ir'Taran
- Blank Character Sheet

**Step 4: Commit**

```bash
git add players-guide.md
git commit -m "Fix Player's Guide heading hierarchy for TOC consistency"
```

---

### Task 2: Add back-to-top button

**Files:**
- Modify: `_layouts/default.html:42` (before closing script tag)
- Modify: `assets/css/style.css` (append styles)
- Modify: `assets/js/main.js` (append behavior)

**Step 1: Add button markup to default layout**

In `_layouts/default.html`, after the footer closing tag (line 40) and before the noscript tag (line 42), add:

```html
  <button class="back-to-top" aria-label="Back to top" title="Back to top">&#9650;</button>
```

**Step 2: Add CSS for the button**

Append to `assets/css/style.css`:

```css
/* Back to top button */
.back-to-top {
  position: fixed;
  bottom: 2rem;
  right: 2rem;
  width: 44px;
  height: 44px;
  border: 1px solid var(--accent-gold);
  background: var(--bg-medium);
  color: var(--accent-gold);
  font-size: 1.2rem;
  cursor: pointer;
  opacity: 0;
  visibility: hidden;
  transition: opacity 0.3s, visibility 0.3s;
  z-index: 100;
}

.back-to-top.visible {
  opacity: 1;
  visibility: visible;
}

.back-to-top:hover {
  background: var(--accent-gold);
  color: var(--bg-dark);
}
```

**Step 3: Add JS behavior**

Append to `assets/js/main.js`:

```javascript
// Back to top button
(function() {
  var btn = document.querySelector('.back-to-top');
  if (!btn) return;

  window.addEventListener('scroll', function() {
    if (window.scrollY > 400) {
      btn.classList.add('visible');
    } else {
      btn.classList.remove('visible');
    }
  });

  btn.addEventListener('click', function() {
    window.scrollTo({ top: 0, behavior: 'smooth' });
  });
})();
```

**Step 4: Test locally**

Run `bundle exec jekyll serve`, navigate to the Player's Guide, scroll down. Confirm:
- Button appears after scrolling ~400px
- Button disappears when back at top
- Clicking it scrolls smoothly to top
- Button is visible but unobtrusive (gold border on dark background)

**Step 5: Commit**

```bash
git add _layouts/default.html assets/css/style.css assets/js/main.js
git commit -m "Add back-to-top button on all pages"
```

---

### Task 3: Add favicon

**Files:**
- Create: `favicon.svg` (in project root for Jekyll to copy)
- Modify: `_layouts/default.html:7` (add link tag)

**Step 1: Create an SVG favicon**

Create `favicon.svg` in the project root — a gold diamond on a dark background, matching the art deco HR diamond motif already in the CSS:

```svg
<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 32 32">
  <rect width="32" height="32" rx="4" fill="#1a1a1f"/>
  <rect x="10" y="10" width="12" height="12" rx="1" transform="rotate(45 16 16)" fill="#c9a227"/>
</svg>
```

**Step 2: Add link tag to default layout**

In `_layouts/default.html`, after the viewport meta tag (line 5), add:

```html
  <link rel="icon" href="{{ '/favicon.svg' | relative_url }}" type="image/svg+xml">
```

**Step 3: Test locally**

Run `bundle exec jekyll serve`. Confirm no more 404 in console for favicon, and the gold diamond appears in the browser tab.

**Step 4: Commit**

```bash
git add favicon.svg _layouts/default.html
git commit -m "Add gold diamond favicon"
```

---

### Task 4: Fix mobile guide header overflow

**Files:**
- Modify: `assets/css/style.css:892-894` (mobile guide header)

**Step 1: Fix the mobile breakpoint styles**

Find the existing mobile guide header rule (around line 892):

```css
.guide-header h1 {
  font-size: 2rem;
}
```

Replace with:

```css
.guide-header h1 {
  font-size: 1.6rem;
  overflow-wrap: break-word;
  word-break: break-word;
}

.guide-header .guide-description {
  font-size: 0.95rem;
}
```

**Step 2: Test on mobile viewport**

Run `bundle exec jekyll serve` and test at 375px width. Confirm "Fate of Eberron: Player's Guide" no longer clips off-screen.

**Step 3: Commit**

```bash
git add assets/css/style.css
git commit -m "Fix guide header overflow on mobile viewports"
```

---

### Task 5: Slim campaign character walkthrough

**Files:**
- Modify: `campaign.md:45-152` (Mira Talan section)

**Step 1: Replace step-by-step walkthrough with summary + link**

Replace the current "Sample Character: Mira Talan" section (lines 45-152) with a version that keeps:
- The narrative concept paragraph (why Mira fits this campaign)
- The final character sheet
- A link to the Player's Guide for the creation process

Cut:
- Steps 1-5 walkthrough (duplicates Player's Guide content)
- The step-by-step math explanations

The section should go: concept paragraph → "For a full walkthrough of character creation, see the [Player's Guide](/Fate-of-Eberron/players-guide#creating-your-character)." → final character sheet.

**Step 2: Verify the character sheet is still complete**

Make sure the remaining sheet has: aspects, modes, skills, stunts, refresh, stress, consequences.

**Step 3: Commit**

```bash
git add campaign.md
git commit -m "Slim campaign character walkthrough, link to Player's Guide"
```

---

### Task 6: Add client-side search

**Files:**
- Modify: `_layouts/default.html` (add lunr.js CDN script, search UI)
- Create: `search.json` (Jekyll template that generates search index)
- Modify: `assets/js/main.js` (add search logic)
- Modify: `assets/css/style.css` (add search UI styles)

**Step 1: Create the search index template**

Create `search.json` in the project root:

```
---
layout: null
---
[
  {% assign pages = site.pages | where_exp: "p", "p.title and p.url != '/'" %}
  {% for page in pages %}
  {
    "title": {{ page.title | jsonify }},
    "url": {{ page.url | relative_url | jsonify }},
    "content": {{ page.content | strip_html | strip_newlines | jsonify }}
  }{% unless forloop.last %},{% endunless %}
  {% endfor %}
]
```

**Step 2: Add lunr.js CDN to default layout**

In `_layouts/default.html`, before the main.js script tag (line 43), add:

```html
  <script src="https://unpkg.com/lunr@2.3.9/lunr.min.js"></script>
```

**Step 3: Add search UI to nav**

In `_layouts/default.html`, inside the nav-container (after the nav-links `</ul>`, around line 27), add:

```html
      <div class="search-container">
        <button class="search-toggle" aria-label="Search">&#9906;</button>
        <div class="search-overlay">
          <input type="text" class="search-input" placeholder="Search..." aria-label="Search guides">
          <div class="search-results"></div>
        </div>
      </div>
```

**Step 4: Add search CSS**

Append to `assets/css/style.css`:

```css
/* Search */
.search-container {
  position: relative;
}

.search-toggle {
  background: none;
  border: none;
  color: var(--text-secondary);
  font-size: 1.2rem;
  cursor: pointer;
  padding: 0.5rem;
}

.search-toggle:hover {
  color: var(--accent-gold);
}

.search-overlay {
  display: none;
  position: absolute;
  top: 100%;
  right: 0;
  width: 320px;
  background: var(--bg-medium);
  border: 1px solid var(--border-color);
  padding: 0.75rem;
  z-index: 200;
}

.search-overlay.active {
  display: block;
}

.search-input {
  width: 100%;
  padding: 0.5rem;
  background: var(--bg-dark);
  border: 1px solid var(--border-color);
  color: var(--text-primary);
  font-family: var(--font-body);
  font-size: 0.9rem;
  box-sizing: border-box;
}

.search-input:focus {
  outline: none;
  border-color: var(--accent-gold);
}

.search-results {
  max-height: 300px;
  overflow-y: auto;
  margin-top: 0.5rem;
}

.search-results a {
  display: block;
  padding: 0.5rem;
  color: var(--text-primary);
  text-decoration: none;
  border-bottom: 1px solid var(--border-color);
  font-size: 0.85rem;
}

.search-results a:hover {
  background: var(--bg-light);
  color: var(--accent-gold);
}

.search-results .search-title {
  font-weight: 600;
  color: var(--accent-gold);
}

.search-results .search-snippet {
  color: var(--text-secondary);
  font-size: 0.8rem;
  margin-top: 0.25rem;
}
```

Add mobile rule inside the `@media (max-width: 768px)` block:

```css
.search-overlay {
  width: calc(100vw - 2rem);
  right: -1rem;
}
```

**Step 5: Add search JS**

Append to `assets/js/main.js`:

```javascript
// Search
(function() {
  var toggle = document.querySelector('.search-toggle');
  var overlay = document.querySelector('.search-overlay');
  var input = document.querySelector('.search-input');
  var resultsEl = document.querySelector('.search-results');
  if (!toggle || !overlay || !input) return;

  var idx = null;
  var docs = null;

  toggle.addEventListener('click', function() {
    overlay.classList.toggle('active');
    if (overlay.classList.contains('active')) {
      input.focus();
      if (!idx) loadIndex();
    }
  });

  document.addEventListener('click', function(e) {
    if (!e.target.closest('.search-container')) {
      overlay.classList.remove('active');
    }
  });

  function loadIndex() {
    var base = document.querySelector('link[rel="icon"]')
      ? document.querySelector('link[rel="icon"]').href.replace(/favicon\.svg$/, '')
      : '/Fate-of-Eberron/';
    fetch(base + 'search.json')
      .then(function(r) { return r.json(); })
      .then(function(data) {
        docs = data;
        idx = lunr(function() {
          this.ref('url');
          this.field('title', { boost: 10 });
          this.field('content');
          data.forEach(function(doc) { this.add(doc); }, this);
        });
      });
  }

  var debounce;
  input.addEventListener('input', function() {
    clearTimeout(debounce);
    debounce = setTimeout(function() {
      if (!idx) return;
      var query = input.value.trim();
      if (query.length < 2) { resultsEl.innerHTML = ''; return; }
      var results = idx.search(query + '~1');
      resultsEl.innerHTML = results.slice(0, 8).map(function(r) {
        var doc = docs.find(function(d) { return d.url === r.ref; });
        if (!doc) return '';
        var snippet = getSnippet(doc.content, query);
        return '<a href="' + doc.url + '"><div class="search-title">' +
          doc.title + '</div><div class="search-snippet">' + snippet + '</div></a>';
      }).join('');
      if (results.length === 0) {
        resultsEl.innerHTML = '<div style="padding:0.5rem;color:var(--text-secondary)">No results</div>';
      }
    }, 200);
  });

  function getSnippet(content, query) {
    var lower = content.toLowerCase();
    var pos = lower.indexOf(query.toLowerCase());
    if (pos === -1) return content.substring(0, 120) + '...';
    var start = Math.max(0, pos - 40);
    var end = Math.min(content.length, pos + 80);
    return (start > 0 ? '...' : '') + content.substring(start, end) + (end < content.length ? '...' : '');
  }
})();
```

**Step 6: Test locally**

Run `bundle exec jekyll serve`. Confirm:
- Search icon appears in nav bar
- Clicking it opens dropdown with input
- Typing "zone attack" returns Player's Guide with relevant snippet
- Typing "dragonmark" returns multiple guides
- Clicking a result navigates to the page
- Clicking outside closes the dropdown

**Step 7: Commit**

```bash
git add search.json _layouts/default.html assets/js/main.js assets/css/style.css
git commit -m "Add client-side search with lunr.js"
```

---

### Task 7: Link cross-references

**Files:**
- Modify: `setting-guide.md:257`
- Modify: `gm-guide.md:1202`
- Modify: `play-example.md:475`
- Modify: `players-guide.md:335`
- Modify: `players-guide.md:1310`

**Step 1: Convert all cross-references to links**

Each "see the X Guide" becomes a markdown link. Use relative_url filter where possible, but since these are markdown files processed by Jekyll, use plain relative paths:

`setting-guide.md:257`:
```markdown
*This guide provides setting information for Eberron. For character creation and game mechanics, see the [Player's Guide](players-guide). For running the game, see the [GM's Guide](gm-guide).*
```

`gm-guide.md:1202`:
```markdown
*For setting information, see the [Eberron Setting Guide](setting-guide). For character creation, see the [Player's Guide](players-guide).*
```

`play-example.md:475`:
```markdown
*For character creation, see the [Player's Guide](players-guide). For running the game, see the [GM's Guide](gm-guide). For setting information, see the [Eberron Setting Guide](setting-guide).*
```

`players-guide.md:335`:
```markdown
*Special*: You should also take a dragonmark aspect and may take dragonmark stunts (see the [Dragonmarks](#dragonmarks) section).
```

`players-guide.md:1310`:
```markdown
*For setting information, see the [Eberron Setting Guide](setting-guide). For running the game, see the [GM's Guide](gm-guide).*
```

**Step 2: Test locally**

Build and verify all links work. Check that the Dragonmarks anchor link scrolls to the right section.

**Step 3: Commit**

```bash
git add setting-guide.md gm-guide.md play-example.md players-guide.md
git commit -m "Link cross-references between guides"
```

---

### Task 8: (Removed — Setting Guide already references GM's Guide)

The audit incorrectly flagged this. `setting-guide.md:257` already says "For running the game, see the GM's Guide." No change needed.

---

### Task 9: Normalize mode stunt counts

**Files:**
- Modify: `players-guide.md:313-315` (Outlander stunts)
- Modify: `players-guide.md:386-388` (Mage stunts)

**Step 1: Trim Outlander to 2 stunts**

Remove Berserker Rage (the odd one out — it's the only stunt with a stress-cost mechanic, and it overlaps with Warrior's combat focus). Keep Wilderness Survival and One with Nature.

Lines 312-315 become:
```markdown
*Suggested Stunts*:
- **Wilderness Survival**: Because I grew up in the wild, I get +2 to Crafts when foraging, building shelter, or surviving in nature.
- **One with Nature**: Because I understand the natural world, I can use Notice instead of Empathy when reading the behavior of animals.
```

**Step 2: Trim Mage to 2 stunts**

Remove Dark Bargain (it's complex, verbose, and GM-dependent — more of a custom design exercise than a pick-up-and-play suggestion). Keep Arcane Shield and Identify Magic.

Lines 385-388 become:
```markdown
*Suggested Stunts*:
- **Arcane Shield**: Because I can conjure protective wards, I can use Will instead of Athletics to defend against magical attacks.
- **Identify Magic**: Because I'm trained in the arcane arts, I get +2 to Lore when analyzing spells, enchantments, or magical phenomena.
```

**Step 3: Commit**

```bash
git add players-guide.md
git commit -m "Normalize suggested stunts to 2 per mode"
```

---

### Task 10: Clarify dragonmark stunt phrasing

**Files:**
- Modify: `players-guide.md:633` (Safe Haven)

**Step 1: Add parenthetical explanation**

Change line 633 from:
```markdown
**Safe Haven**: Because of my Mark of Hospitality, once per session I can declare that we find a safe place to rest, even in dangerous territory.
```
to:
```markdown
**Safe Haven**: Because of my Mark of Hospitality, once per session I can declare that we find a safe place to rest, even in dangerous territory. (Story declarations are limited to once per session rather than once per scene.)
```

**Step 2: Commit**

```bash
git add players-guide.md
git commit -m "Clarify Safe Haven's once-per-session limit"
```

---

### Task 11: Add Session 0 prep to campaign page

**Files:**
- Modify: `campaign.md` (replace placeholder sections at bottom)

**Step 1: Replace placeholders with Session 0 checklist**

Replace the current:
```markdown
## Campaign Brief

*To be written after Session 0.*

## Characters

*To be added after Session 0.*

## Sessions

*Session reports will be added here.*
```

With:

```markdown
## Session 0 Checklist

These sections get filled in during and after Session 0. Bring this to the table:

**Before the Session:**
- [ ] Everyone reads the campaign pitch above
- [ ] Everyone skims the [Player's Guide](players-guide) character creation section
- [ ] Think about 2-3 character concepts (the character ideas above are a starting point)

**During the Session:**
- [ ] Discuss tone and safety tools (X-Card, Lines and Veils — see [GM's Guide](gm-guide))
- [ ] Build characters together — modes, aspects, stunts
- [ ] Create relationship aspects connecting the PCs
- [ ] Name the agency and decide where the office is
- [ ] Establish each character's relationship to Sharn (who do they know, where do they go)
- [ ] The GM presents the first case hook

**After the Session:**
- [ ] Finalize character sheets
- [ ] GM writes up the campaign brief below

---

## Campaign Brief

*To be written after Session 0.*

## Characters

*To be added after Session 0.*

## Sessions

*Session reports will be added here.*
```

**Step 2: Commit**

```bash
git add campaign.md
git commit -m "Add Session 0 checklist to campaign page"
```

---

### Task 12: Final verification

**Step 1: Full build and visual check**

```bash
bundle exec jekyll serve
```

Check each page at desktop (1280px) and mobile (375px):
- [ ] Homepage: hero doesn't clip on mobile
- [ ] Player's Guide: TOC shows all character creation steps
- [ ] All guides: back-to-top button appears on scroll, works
- [ ] Favicon visible in browser tab
- [ ] Search: opens, finds content, navigates correctly
- [ ] Cross-reference links work between all guides
- [ ] Campaign page: Session 0 checklist renders, Mira's sheet is complete

**Step 2: Push to remote**

```bash
git push
```
