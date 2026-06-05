# Phase 2: Toolkit Foundation Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Create the Eberron Toolkit document (6 sections) and add three Book of Hanz inline additions to the existing guides.

**Architecture:** One new file (`toolkit.md`) with Jekyll front matter, plus targeted insertions into `players-guide.md` and `gm-guide.md`. The toolkit covers the complete GM workflow from pitch to session end, with Story Elements, Region System, Downtime, Questions and Decisions, and Compels and Drama Escalation. The spec is at `docs/specs/2026-06-02-phase2-toolkit-foundation.md`.

**Tech Stack:** Markdown, Jekyll (site builds automatically on file changes via hook).

**Writing style:** Follow the existing voice in the guides. Short sentences. Active voice. No em dashes (use colons, commas, or periods instead). No AI writing tells ("testament," "vibrant," "tapestry," "comprehensive," "landscape," "delve," "leverage," "utilize"). Use contractions naturally. Show with examples, not abstract explanation.

---

## File Map

| File | What Changes |
|------|-------------|
| `toolkit.md` (create) | Tasks 1, 2, 3, 4, 5, 6 (GM Workflow, Story Elements, Region System, Downtime, Questions and Decisions, Compels and Drama Escalation) |
| `players-guide.md` | Task 7 (Intent and Task, Conflict as Bidding War) |
| `gm-guide.md` | Task 8 (Branches Not Gates / Interesting Failure, toolkit cross-references) |
| `index.md` | Task 9 (add toolkit to navigation) |

## Task Dependencies

Tasks 1-6 build the toolkit sequentially (each section of the document in order). They can't be parallelized because they're sections of one file.

Tasks 7 and 8 are independent of each other and can run after Task 6 (or in parallel with later toolkit tasks, since they modify different files).

Task 9 depends on Tasks 1-8 being complete.

```
Tasks 1 → 2 → 3 → 4 → 5 → 6 → 9
                                ↗
Task 7 (independent) → 9
Task 8 (independent) → 9
```

---

### Task 1: Create toolkit.md with GM Workflow (Section 1)

**Files:**
- Create: `toolkit.md`

- [ ] **Step 1: Create the file with Jekyll front matter and Section 1**

Create `toolkit.md` at the repo root (same level as `players-guide.md`). Include Jekyll front matter and the complete GM Workflow section.

The front matter should match the existing guide format:

```yaml
---
layout: guide
title: "Fate of Eberron: GM Toolkit"
description: Systems and tools for running Eberron campaigns, from session zero to session end.
---
```

Then write Section 1: The GM Workflow. The full content is specified in the spec under "## 1. The GM Workflow". Include:

- Opening paragraph explaining this document is the "how to actually run this" companion to the GM's Guide
- "The Loop" table mapping each campaign phase to what happens and which toolkit system is used
- "Arc Generation" subsection with the five questions (why relevant to characters, who's involved, what are they trying to achieve, who opposes them, what happens if nobody intervenes)
- "Session Prep" subsection with the five prep steps (what changed, what are NPCs doing, look at character sheets, prep hand grenades, don't predict)
- "Running the Session" subsection with the six in-session steps
- "The Most Important Rule" closing (don't plan what will happen, plan the situation)

All content is in the spec. Write it as prose following the writing style guidelines.

- [ ] **Step 2: Verify the file renders**

Run: `cd /Users/ryan/Fate-of-Eberron-2 && bundle exec jekyll build 2>&1 | tail -5`
Expected: Build succeeds.

- [ ] **Step 3: Commit**

```bash
git add toolkit.md
git commit -m "feat: create toolkit with GM Workflow section"
```

---

### Task 2: Add Story Elements (Section 2)

**Files:**
- Modify: `toolkit.md` (append after Section 1)

- [ ] **Step 1: Append Section 2 to toolkit.md**

Add a `---` divider after Section 1, then write Section 2: Eberron Story Elements. The full content is in the spec under "## 2. Eberron Story Elements". Include:

- "How It Works" intro
- "Step 1: Inspirations" with the example blockquote
- "Step 2: Story Ingredients" with the full 9-row ingredient categories table (Tone, Scope, The Last War, Factions, The Draconic Prophecy, The Planes, Horror, Identity and Prejudice, Magic and Technology) and the explanation of Keepers/Deal Breakers/Conditional
- "Step 3: Campaign Aspects" with examples
- "Between Sessions" subsection on revisiting the worksheet

- [ ] **Step 2: Verify the file renders**

Run: `cd /Users/ryan/Fate-of-Eberron-2 && bundle exec jekyll build 2>&1 | tail -5`
Expected: Build succeeds.

- [ ] **Step 3: Commit**

```bash
git add toolkit.md
git commit -m "feat: add Eberron Story Elements to toolkit"
```

---

### Task 3: Add Region System (Section 3)

**Files:**
- Modify: `toolkit.md` (append after Section 2)

This is the largest section. It includes the core system plus five fully worked framework examples.

- [ ] **Step 1: Append Section 3 to toolkit.md**

Add a `---` divider after Section 2, then write Section 3: The Region System. The full content is in the spec under "## 3. The Region System". Include:

- "What Is a Region?" intro
- Terminology table (Site, Community, Network, Periphery, Home Base, Status, Power)
- "Building a Region" (4 steps)
- "Site Stats" table (Name/High Concept, Values, Trouble, Status, Additional Aspects, Skills, Power)
- "Power Scale" table with all five framework columns
- "Site Skills" explanation (binary, signature skill = Power + 1)
- "Site vs. Site Interactions" with resolution rules and the "make drama, not war" note
- "Network Mechanics" (three benefits)
- "Forging Alliances" (always an adventure, always compromise, Friendly Face NPC)
- "Neutral Sites" (four reasons for neutrality)

- [ ] **Step 2: Write the five framework examples**

After the Neutral Sites section, add "### Framework Examples" and write one complete example per framework. Each example has 5-6 sites with full stat blocks.

**Agency Example (Sharn: Lower Dura)**

Home base: The Office (the party's agency in Callestan). Then 4-5 surrounding sites: Callestan itself (the neighborhood), Fallen (haunted ruins district), the Stores (merchant district), Malleon's Gate (goblinoid quarter), Precarious (unstable towers, cheap housing). Each site gets: Name, High Concept, Values, Trouble, Status, 1-2 additional aspects, Skills (as a list), Power rating.

**Expedition Example (Xen'drik Coast)**

Home base: The Anchor (chartered ship at Stormreach docks). Surrounding sites: Stormreach Harbor District, a drow trading post (Sulatar encampment), a giant ruin (Tethyrian spires), unexplored jungle interior, a rival Morgrave camp.

**Cell Example (Karrnath)**

Home base: The Cellar (hidden room beneath a sympathizer's farm). Surrounding sites: Rekkenmark (provincial capital, military HQ), a border town with a Brelish crossing, an abandoned Karrnathi fort, a monastery of the Blood of Vol (divided loyalties), a smuggler's river crossing.

**Salvage Crew Example (Mournland Border)**

Home base: Camp Terminus (fortified camp outside the dead-gray mist). Surrounding sites: Vathirond (border town), a dead-gray mist entry point (the Threshold), an intact Cyran village frozen in time (Stillwater), a Lord of Blades outpost (the Foundry), a living spell hunting ground (the Shimmer).

**House Operatives Example (House Cannith Network)**

Home base: Cannith South Enclave (Sharn). Surrounding sites: Cannith West branch (Aundair), a Tharashk rival operation (Stormreach dragonshard trade), a rogue Cannith heir's workshop (Cyre ruins), a Kundarak vault holding contested patents, a Cannith creation forge (supposedly decommissioned).

Each site stat block should follow this format:

```markdown
#### [Site Name]
**High Concept:** [phrase]
**Values:** [phrase]
**Trouble:** [phrase]
**Status:** [current situation, positive or negative]
**Aspects:** [1-2 additional aspects]
**Skills:** [comma-separated list]
**Power:** [rating and adjective]
```

- [ ] **Step 3: Verify the file renders**

Run: `cd /Users/ryan/Fate-of-Eberron-2 && bundle exec jekyll build 2>&1 | tail -5`
Expected: Build succeeds.

- [ ] **Step 4: Commit**

```bash
git add toolkit.md
git commit -m "feat: add Region System with five framework examples to toolkit"
```

---

### Task 4: Add Downtime (Section 4)

**Files:**
- Modify: `toolkit.md` (append after Section 3)

- [ ] **Step 1: Append Section 4 to toolkit.md**

Add a `---` divider after Section 3, then write Section 4: Downtime. The full content is in the spec under "## 4. Downtime". Include:

- "The Rhythm of Play" intro
- "Start of Session: What Are You Up To?" subsection
- "End of Session: Downtime Actions" with the four-action table (Overcome, Create Advantage, Attack, Compel) and Eberron examples
- "Downtime Rules" with all six bullet points (site interaction, GM invokes, time scale, shopping, personal development, relax)
- "GM Actions Between Sessions" table (Foreshadow, Counter-Action, Apply Pressure, Track Countdowns)
- "Solving Bad Statuses" subsection (mitigate vs. resolve, major milestones, ignoring consequences)

- [ ] **Step 2: Verify the file renders**

Run: `cd /Users/ryan/Fate-of-Eberron-2 && bundle exec jekyll build 2>&1 | tail -5`
Expected: Build succeeds.

- [ ] **Step 3: Commit**

```bash
git add toolkit.md
git commit -m "feat: add Downtime system to toolkit"
```

---

### Task 5: Add Questions and Decisions (Section 5)

**Files:**
- Modify: `toolkit.md` (append after Section 4)

- [ ] **Step 1: Append Section 5 to toolkit.md**

Add a `---` divider after Section 4, then write Section 5: Questions and Decisions. The full content is in the spec under "## 5. Questions and Decisions". Include:

- "Every Campaign Has a Big Question" with three Eberron example questions
- "Every Arc Has a Question" with three Eberron example questions
- "Every Scene Has a Question" with three Eberron example questions
- "Player Decisions Answer the Questions" explanation
- "If the Players Aren't Making Decisions, Something Is Wrong" checklist (gates instead of branches, no stakes, predetermined outcomes, missing questions)

- [ ] **Step 2: Verify the file renders**

Run: `cd /Users/ryan/Fate-of-Eberron-2 && bundle exec jekyll build 2>&1 | tail -5`
Expected: Build succeeds.

- [ ] **Step 3: Commit**

```bash
git add toolkit.md
git commit -m "feat: add Questions and Decisions to toolkit"
```

---

### Task 6: Add Compels and Drama Escalation (Section 6)

**Files:**
- Modify: `toolkit.md` (append after Section 5)

- [ ] **Step 1: Append Section 6 to toolkit.md**

Add a `---` divider after Section 5, then write Section 6: Compels and Drama Escalation. The full content is in the spec under "## 6. Compels and Drama Escalation". Include:

- "Fate's Big Question: How Much Do You Want This?" opening (a Fate character can do anything but can't do everything; every scene should force a choice; the GM's job is pricing what characters want)
- "The Compel Rhythm" table (opening/investigation/rising action/climax phases with compel styles)
- "Compel Sources" with all four categories:
  - Character Compels (early/mid/late campaign escalation with the Cyran Refugee example)
  - Faction Compels (act between sessions, rotate pressure)
  - Site Compels (negative statuses as standing compel opportunities)
  - Relationship Compels (most powerful, put PCs at odds)
- "Drama Escalation Across a Campaign" table (early/mid/late sessions with intensity and what changes)
- "Consequences as Drama Fuel" (consequences are compellable aspects, magical consequences are especially rich)
- "The Fate Point Economy as Drama Pacing" (stockpiling vs. depleting, let the economy create tension naturally)
- "Designing Threats Around Characters, Not the Other Way Around" (MotW principle: start with PC aspects, design threat that pressures them, the Buffy examples, the four-step process)
- "Calibration: Same Mechanics, Different Feel" with the three-row tone table (Pulp/Noir/Horror for 3 stress hit, mild consequence, severe consequence) and the note about using Story Elements to determine narration

- [ ] **Step 2: Verify the file renders**

Run: `cd /Users/ryan/Fate-of-Eberron-2 && bundle exec jekyll build 2>&1 | tail -5`
Expected: Build succeeds.

- [ ] **Step 3: Commit**

```bash
git add toolkit.md
git commit -m "feat: add Compels and Drama Escalation to toolkit"
```

---

### Task 7: Add Intent and Task + Conflict as Bidding War to Players Guide

**Files:**
- Modify: `players-guide.md`

Two insertions in the "Playing the Game" section.

- [ ] **Step 1: Add Intent and Task**

Find the `### The Four Actions` section (around line 700). Insert the Intent and Task content BEFORE `### The Four Actions` and after the `### Four Outcomes` section (which ends around line 699).

The content is specified in the spec under "## Inline Addition A: Intent and Task". Insert it as a new `### Intent and Task` subsection. Include:

- The core principle: before you can pick an action, you need both intent (what does success look like?) and task (what does your character do?)
- The Hulk example showing same task, different intent, different action
- The three Eberron examples (lock picking, casting a spell, talking to a guard)

- [ ] **Step 2: Add Conflict as Bidding War**

Find the `### Conflicts` section (around line 829). Insert the bidding war content AFTER the existing `#### Full Defense` subsection (which ends around line 874) and BEFORE `### Stress and Consequences` (line 876).

The content is specified in the spec under "## Inline Addition B: Conflict as Bidding War". Insert it as a new `#### The Escalation` subsection. Include:

- The four-step escalation (skills only → invoke aspects → take consequences → concede or get taken out)
- The framing: "How much do I want this?" drives the drama
- The concession economics note

- [ ] **Step 3: Verify the file renders**

Run: `cd /Users/ryan/Fate-of-Eberron-2 && bundle exec jekyll build 2>&1 | tail -5`
Expected: Build succeeds.

- [ ] **Step 4: Commit**

```bash
git add players-guide.md
git commit -m "feat: add Intent and Task + Conflict as Bidding War (Book of Hanz)"
```

---

### Task 8: Add Branches Not Gates + Toolkit Cross-References to GM Guide

**Files:**
- Modify: `gm-guide.md`

- [ ] **Step 1: Add Branches Not Gates / Interesting Failure**

Find the `### Rules of Thumb` subsection within `## Setting Difficulty and Opposition` (around line 118-123). Insert the Branches Not Gates content AFTER the Rules of Thumb section and BEFORE the `---` divider that precedes `## Session Zero` (line 125).

The content is specified in the spec under "## Inline Addition C: Branches Not Gates / Interesting Failure". Insert as two new subsections: `### Branches, Not Gates` and `### Interesting Failure`. Include:

- The fork vs. gate metaphor
- The locked door test
- Four types of interesting failure (success at major cost, new complication, unwanted attention, shifted circumstances)
- "That doesn't work" is never the answer
- The Cannith vault Eberron example

- [ ] **Step 2: Add toolkit cross-reference to Campaign Frameworks**

Find `## Campaign Frameworks` (around line 596). Add a brief note at the start of the section, after the intro paragraph:

```markdown
For the full campaign management toolkit (region maps, downtime, drama escalation), see the **[GM Toolkit]({{ '/toolkit' | relative_url }})**.
```

- [ ] **Step 3: Add toolkit cross-reference to Compels section**

Find `## Compels in Eberron` (around line 564). Add a brief note at the end of the section, after the Setting Compels subsection:

```markdown
For systematic guidance on compel rhythm, drama escalation, and using compels to drive entire campaigns, see the **[GM Toolkit]({{ '/toolkit' | relative_url }})**.
```

- [ ] **Step 4: Verify the file renders**

Run: `cd /Users/ryan/Fate-of-Eberron-2 && bundle exec jekyll build 2>&1 | tail -5`
Expected: Build succeeds.

- [ ] **Step 5: Commit**

```bash
git add gm-guide.md
git commit -m "feat: add Branches Not Gates + toolkit cross-references to GM guide"
```

---

### Task 9: Update index.md and Final Cleanup

**Files:**
- Modify: `index.md`
- Read: `toolkit.md`, `players-guide.md`, `gm-guide.md`

- [ ] **Step 1: Add toolkit to site navigation**

In `index.md`, find the `## The Guides` section. Add a new guide card for the toolkit after the GM's Guide card and before the Play Example card:

```markdown
<div class="guide-card" markdown="1">

### [GM Toolkit]({{ '/toolkit' | relative_url }})

Systems for running campaigns: the GM workflow, story elements, region maps, downtime, and drama escalation. Start here after reading the GM's Guide.

</div>
```

- [ ] **Step 2: Update the index intro text**

The intro paragraph (line 17) still says "mode-based character creation inspired by *Atomic Robo RPG*". Replace with:

```markdown
This adaptation uses archetype-based character creation and a charter system for party identity, letting you quickly build characters and campaigns that feel authentically Eberron while embracing Fate's fiction-first approach.
```

Also update the Quick Start section (lines 63-65):

```markdown
1. **Read the Setting Guide** to understand Eberron's tone and themes
2. **Create your charter and characters** using the Player's Guide
3. **Set up your campaign** with the GM's Guide and GM Toolkit
```

- [ ] **Step 3: Verify all files render**

Run: `cd /Users/ryan/Fate-of-Eberron-2 && bundle exec jekyll build 2>&1 | tail -5`
Expected: Build succeeds.

- [ ] **Step 4: Search for stale references**

Search `toolkit.md` for: em dashes (—, –), placeholder text (TBD, TODO), references to "mode" or "modes" in the context of character creation.

Search `players-guide.md` and `gm-guide.md` for any new issues introduced by Tasks 7-8.

Fix any issues found.

- [ ] **Step 5: Commit**

```bash
git add index.md toolkit.md players-guide.md gm-guide.md
git commit -m "feat: add toolkit to site navigation, update index for new system"
```
