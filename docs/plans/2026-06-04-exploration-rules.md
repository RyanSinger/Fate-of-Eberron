# Exploration Rules Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Add exploration rules (travel, vehicles, delves, terrain profiles) to the GM Toolkit.

**Architecture:** One large section appended to `toolkit.md`, built across four tasks: travel rules, vehicle profiles, delve system with sample delve, and terrain profiles. The spec is at `docs/specs/2026-06-04-exploration-rules.md`.

**Tech Stack:** Markdown, Jekyll.

**Writing style:** Same as existing toolkit. Short sentences. Active voice. No em dashes. No AI writing tells. Eberron specific throughout.

---

## File Map

| File | What Changes |
|------|-------------|
| `toolkit.md` | Tasks 1, 2, 3, 4 (append exploration section) |

---

### Task 1: Section Header + Travel Rules

**Files:**
- Modify: `toolkit.md` (append after the Case Generator's "Building Cases from the Region Map" section)

- [ ] **Step 1: Append exploration section header and travel rules**

Add a `---` divider after the last line of the Case Generator, then write:

`## Exploration` with a brief intro (2 sentences: the region system tracks the political map; exploration rules cover what happens when you travel between sites or delve into dangerous locations).

Then `### Travel` with the complete travel system from the spec:
- Core mechanic paragraph explaining journeys as challenges/contests/conflicts
- Journey type table (Routine/Eventful/Pursued/Hostile with pacing and when to use)
- Journey Aspects subsection (1-2 situation aspects per journey, examples)
- Discoveries subsection (success with style adds sites to region map)

- [ ] **Step 2: Verify and commit**

Run: `cd /Users/ryan/Fate-of-Eberron-2 && bundle exec jekyll build 2>&1 | tail -5`

```bash
git add toolkit.md
git commit -m "feat: add exploration section with travel rules"
```

---

### Task 2: Vehicles and Conveyances

**Files:**
- Modify: `toolkit.md` (append after Travel)

- [ ] **Step 1: Append vehicles section**

Add `### Vehicles and Conveyances` with:
- Intro paragraph (Eberron's transportation is iconic; vehicles are adventure settings, not just transit)
- Vehicle template table (High Concept, Aspects, Skills, Stress, Consequences)
- Five vehicle profiles, each with a `####` subheading:

**Lightning Rail**: aspects (*Fastest Thing on Land*, *Hundreds of Passengers, Dozens of Secrets*), skills (Drive Good +3, Physique Fair +2), stress (4 boxes), consequences (Mild, Moderate), 4 adventure hooks.

**Airship**: aspects (*Nothing Between You and the Sky*, *Elemental Bound and Restless*), skills (Drive Good +3, Physique Good +3), stress (4 boxes), consequences (Mild, Moderate, Severe), 4 adventure hooks.

**Sea Vessel**: aspects (*At the Mercy of Wind and Wave*, *Tight Quarters, No Escape*), skills (Drive Fair +2, Physique Good +3), stress (4 boxes), consequences (Mild, Moderate), 4 adventure hooks.

**Caravan**: aspects (*Slow and Vulnerable, Rich and Tempting*, *The Road Is Long and Full of Strangers*), skills (Notice Fair +2, Physique Fair +2), stress (3 boxes), consequences (Mild, Moderate), 4 adventure hooks.

**Skycoach (Sharn)**: aspects (*Fast, Expensive, and Exposed*, *Sharn's Vertical Geography*), skills (Drive Good +3), stress (2 boxes), consequences (Mild), 4 adventure hooks.

All stat blocks should match the Bronze Rule format from the GM guide (see gm-guide.md lines 832-858 for the existing airship example).

- [ ] **Step 2: Verify and commit**

Run: `cd /Users/ryan/Fate-of-Eberron-2 && bundle exec jekyll build 2>&1 | tail -5`

```bash
git add toolkit.md
git commit -m "feat: add vehicle profiles (lightning rail, airship, ship, caravan, skycoach)"
```

---

### Task 3: Delves (Zone Exploration + Sample Delve)

**Files:**
- Modify: `toolkit.md` (append after Vehicles)

- [ ] **Step 1: Append delve system**

Add `### Delves` with:
- Intro paragraph (a delve is zone-by-zone exploration of a dangerous location)
- Zone template table (Zone Name, Aspects, Threat or Obstacle, Discovery)
- Delve pacing subsection (set dressing, decision points, encounter zones, safe zones; the rhythm of alternating)
- Traps and obstacles subsection:
  - Active traps (attack with a skill, defend with Athletics/Notice/Will, three tiers: simple Fair +2, dangerous Good +3 or Great +4 with stunt, deadly Superb +5 with stunt and Weapon:2)
  - Passive obstacles (set difficulty, overcome, failure consequences: damage, separation, alarm, time loss)
  - Puzzles (treat as challenges, brainstorm mechanic for magical puzzles)
- Disarming and bypassing subsection (disarm with Crafts/Lore, detect with Notice/Investigate, tank the hit, bypass via alternate route)

- [ ] **Step 2: Append the sample delve**

Add `#### Sample Delve: The Sealed Vault` with 5 zones from the spec:

Zone 1: The Approach (set dressing, Lore Fair +2 to read glyphs, discovery: a name connecting to campaign)
Zone 2: The Guardian (encounter, construct hitter Great +4, can fight/stealth past/reason with)
Zone 3: The False Treasury (trap, Shoot Great +4 attack on the zone, Notice Good +3 to detect, discovery: vault map)
Zone 4: The Locked Door (passive obstacle, three keys or Crafts/Lore Fantastic +6 bypass, discovery: historical records)
Zone 5: The Heart (climax, boss guardian OR empty vault, discovery: the MacGuffin or clue to who took it)

Each zone uses the zone template format with Zone Name, Aspects, Threat, Discovery.

- [ ] **Step 3: Verify and commit**

Run: `cd /Users/ryan/Fate-of-Eberron-2 && bundle exec jekyll build 2>&1 | tail -5`

```bash
git add toolkit.md
git commit -m "feat: add delve system with traps, obstacles, and sample vault delve"
```

---

### Task 4: Terrain Profiles

**Files:**
- Modify: `toolkit.md` (append after Delves)

- [ ] **Step 1: Append all four terrain profiles**

Add `### Terrain Profiles` with brief intro (four profiles for Eberron's key exploration locations, each providing situation aspects, hazards, discoveries, and a sample encounter).

Then four `####` subheadings:

**Xen'drik**: Themes (ancient power, lost civilizations, Traveler's Curse). 4 situation aspects. 4 hazard types. 4 discovery types. Sample encounter (giant observatory with lenses showing ancient sky, Investigate challenge while construct attacks).

**The Mournland**: Themes (wrongness, preserved destruction, things that shouldn't exist). 4 situation aspects. 4 hazard types (living spells, warped terrain, dead-gray mist mental stress, preserved war scenes). 4 discovery types. Sample encounter (time-looping Cyran village, Investigate/Lore challenge, moral dilemma of breaking the loop).

**Khyber**: Themes (madness, alien biology, things older than civilization). 4 situation aspects. 4 hazard types (aberrations, symbiont creatures, madness zones with mental stress, living architecture). 4 discovery types. Sample encounter (dolgaunt claiming to repair a Gatekeeper seal, Empathy vs Deceive to read intent, disrupting the ritual worsens the seal).

**Wilderness**: Themes (nature as power, civilization's edge, old conflicts). 4 situation aspects. 4 hazard types. 4 discovery types. Sample encounter (druidic circle protecting manifest zone vs Tharashk prospectors with legal claim, druids won't negotiate, animals getting dangerous).

All content is in the spec. Write it out fully with the specific aspects, hazards, discoveries, and encounters from the spec.

- [ ] **Step 2: Verify and commit**

Run: `cd /Users/ryan/Fate-of-Eberron-2 && bundle exec jekyll build 2>&1 | tail -5`

```bash
git add toolkit.md
git commit -m "feat: add terrain profiles (Xen'drik, Mournland, Khyber, Wilderness)"
```

---

## Task Dependencies

Tasks 1 → 2 → 3 → 4 (sequential appends to toolkit.md).

## Self-Review

**Spec coverage:**
- Travel (journey types, aspects, discoveries) → Task 1 ✓
- Vehicles (template, 5 profiles with stats and hooks) → Task 2 ✓
- Delves (zone template, pacing, traps, obstacles, puzzles, disarming) → Task 3 ✓
- Sample Delve (5 zones) → Task 3 ✓
- Xen'drik profile → Task 4 ✓
- Mournland profile → Task 4 ✓
- Khyber profile → Task 4 ✓
- Wilderness profile → Task 4 ✓

All spec sections covered. No placeholders. Format consistent with existing toolkit.
