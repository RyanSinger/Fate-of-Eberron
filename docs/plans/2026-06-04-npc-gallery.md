# NPC Gallery Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Create `npcs.md` with 36 ready-to-use NPCs organized by faction, with stat blocks matching the GM guide's adversary format.

**Architecture:** One new file (`npcs.md`) built across five tasks (grouped by faction clusters). Each task writes 2-3 factions with complete entries. Final task updates `index.md` and adds cross-references.

**Tech Stack:** Markdown, Jekyll.

**Writing style:** Same voice as the existing guides. Short sentences. Active voice. No em dashes. No AI writing tells. Every NPC should feel like a person, not a stat block. The 2-3 sentence description and hook are more important than the numbers.

**Stat block format** (matches GM guide `gm-guide.md` lines 885-1028):

Threats:
```
#### Name, Title (Pronouns)
**Role:** [role] | **Tier:** Threat

[2-3 sentences + hook]

*High Concept Aspect*
Skills: [Skill] Average (+1), [Skill] Average (+1)
```

Fillers:
```
#### Name (count)
**Role:** [role] | **Tier:** Filler

[2-3 sentences + hook]

*High Concept Aspect*
Skills: [Skill] Fair (+2), [Skill] Fair (+2), [Skill] Average (+1)
Stress: [ ] [ ] [ ] [ ]
```

Hitters:
```
#### Name, Title (Pronouns)
**Role:** [role] | **Tier:** Hitter

[2-3 sentences + hook]

*High Concept Aspect*
*Trouble or Other Aspect*
Skills: [Peak] Great (+4), [Supporting] Good (+3), [Supporting] Fair (+2), [Other] Average (+1)
Stunt: **Name**: [description]
Stress: [ ] [ ] [ ]
Consequence: Mild [ ] | Moderate [ ]
```

Bosses:
```
#### Name, Title (Pronouns)
**Role:** [role] | **Tier:** Boss

[2-3 sentences + hook]

**Aspects:**
- *High Concept*
- *Trouble*
- *Other*
- *Other*
- *Other*

**Skills:** [Peak] Fantastic (+6), [etc. full pyramid]
**Stunts:**
- **Name**: [description]
- **Name**: [description]
- **Name**: [description]

**Stress:** Physical [ ] [ ] [ ] [ ] | Mental [ ] [ ] [ ] [ ]
**Consequences:** Mild [ ] | Mild ([type]) [ ] | Moderate [ ] | Severe [ ]
```

---

## File Map

| File | What Changes |
|------|-------------|
| `npcs.md` (create) | Tasks 1, 2, 3, 4 (NPC entries by faction) |
| `index.md` | Task 5 (add to navigation) |
| `toolkit.md` | Task 5 (cross-reference in Designing Threats section) |

---

### Task 1: Create npcs.md with Boromar Clan and Daask

**Files:**
- Create: `npcs.md`

- [ ] **Step 1: Create the file with front matter, intro, and quick-reference index**

Create `npcs.md` at the repo root. Include:

Jekyll front matter:
```yaml
---
layout: guide
title: "Fate of Eberron: NPC Gallery"
description: Ready-to-use NPCs for Eberron campaigns, organized by faction.
---
```

Intro paragraph (2-3 sentences): This document contains ready-to-use NPCs for your Eberron campaign. Each entry includes a narrative description, a hook for introducing them, and a complete stat block. Browse by faction, or scan the index for the role or tier you need.

Quick-reference index table listing ALL 36 NPCs (from the spec) with columns: Name | Faction | Role | Tier. This gives GMs a scannable overview of the entire gallery.

- [ ] **Step 2: Write the Boromar Clan section**

Section header `## Boromar Clan` with 2-3 sentence faction overview (from spec).

Write 4 NPC entries using the stat block formats above:
- **Saidan Boromar** (he/him): Leader, Boss. Aging patriarch. Full boss stat block with 5 aspects, skill pyramid, 2-3 stunts, full stress/consequences.
- **Hallia Boromar** (she/her): Rival, Hitter. Ambitious niece. Hitter stat block.
- **Castar** (he/him): Enforcer, Hitter. Chief leg-breaker. Hitter stat block.
- **Miri Quickfingers** (she/her): Informant, Threat. Street urchin message runner. Threat stat block.

Each NPC gets the narrative description and hook from the spec, plus a complete mechanical stat block. Make the aspects evocative and double-edged. Make the hooks specific enough to use but open enough to fit any campaign.

- [ ] **Step 3: Write the Daask section**

Section header `## Daask` with faction overview.

Write 4 NPC entries:
- **Cavallah** (she/her): Leader, Boss. Ogre mage. Full boss stat block.
- **Ash** (they/them): Enforcer, Hitter. Changeling assassin. Hitter stat block.
- **Grakk's Pack** (mixed): Muscle, Filler. Gnoll street gang. Filler stat block.
- **The Butcher of Fallen** (he/him): Wild Card, Hitter. Minotaur pit fighter. Hitter stat block.

- [ ] **Step 4: Verify and commit**

Run: `cd /Users/ryan/Fate-of-Eberron-2 && bundle exec jekyll build 2>&1 | tail -5`

```bash
git add npcs.md
git commit -m "feat: create NPC gallery with Boromar Clan and Daask"
```

---

### Task 2: House Cannith, House Tharashk, Houses Phiarlan/Thuranni

**Files:**
- Modify: `npcs.md` (append after Daask)

- [ ] **Step 1: Write the House Cannith section**

Section header `## House Cannith` with faction overview.

Write 4 NPC entries:
- **Merrix d'Cannith** (he/him): Patron/Rival, Boss. Leader of Cannith South. Full boss stat block.
- **Leya d'Cannith** (she/her): Contact, Hitter. Artificer with a conscience. Hitter stat block.
- **The Reforged** (it/its): Wild Card, Hitter. Secretly illegal warforged. Hitter stat block.
- **Cannith Retrieval Team** (mixed): Enforcer, Filler. Schema recovery squad. Filler stat block.

- [ ] **Step 2: Write the House Tharashk section**

Section header `## House Tharashk` with faction overview.

Write 3 NPC entries:
- **Kalaash'arrna** (she/her): Patron, Hitter. Tharashk inquisitive. Hitter stat block.
- **Dol** (he/him): Rival, Hitter. Orc bounty hunter. Hitter stat block.
- **Tharashk Prospectors** (mixed): Contact, Filler. Dragonshard survey team. Filler stat block.

- [ ] **Step 3: Write the Houses Phiarlan and Thuranni section**

Section header `## Houses Phiarlan and Thuranni` with faction overview.

Write 3 NPC entries:
- **Salia Phiarlan** (she/her): Contact/Patron, Hitter. Theater owner/spymaster. Hitter stat block.
- **Vael Thuranni** (he/him): Rival, Boss. Shadow operative. Full boss stat block.
- **The Whisper** (unknown): Informant, Threat. Anonymous double-house source. Threat stat block.

- [ ] **Step 4: Verify and commit**

Run: `cd /Users/ryan/Fate-of-Eberron-2 && bundle exec jekyll build 2>&1 | tail -5`

```bash
git add npcs.md
git commit -m "feat: add House Cannith, Tharashk, and Phiarlan/Thuranni NPCs"
```

---

### Task 3: Emerald Claw, King's Citadel, The Aurum

**Files:**
- Modify: `npcs.md` (append)

- [ ] **Step 1: Write the Emerald Claw / Blood of Vol section**

Section header `## The Emerald Claw` with faction overview.

Write 4 NPC entries:
- **Commander Malik Draven** (he/him): Leader, Boss. True believer commander. Full boss stat block.
- **Sera the Bone Mender** (she/her): Wild Card, Hitter. Necromantic healer. Hitter stat block.
- **Skeledrone Squad** (none): Muscle, Filler. Animated undead soldiers. Filler stat block.
- **The Seeker** (she/her): Informant, Threat. Sincere Vol acolyte. Threat stat block.

- [ ] **Step 2: Write the King's Citadel / Dark Lanterns section**

Section header `## The King's Citadel` with faction overview.

Write 3 NPC entries:
- **Captain Talleon Haliar Tonan** (he/him): Patron/Rival, Boss. Dark Lanterns handler. Full boss stat block.
- **Agent Nali** (she/her): Contact, Hitter. Undercover Citadel agent. Hitter stat block.
- **Citadel Redcloaks** (mixed): Enforcer, Filler. Uniformed division. Filler stat block.

- [ ] **Step 3: Write the Aurum section**

Section header `## The Aurum` with faction overview.

Write 3 NPC entries:
- **Antus ir'Soldorak** (he/him): Rival, Boss. Dwarf industrialist. Full boss stat block.
- **Mara Thornton** (she/her): Contact, Hitter. Questioning Aurum member. Hitter stat block.
- **The Accountant** (he/him): Enforcer, Hitter. Financial weapon. Hitter stat block. (This NPC's "attacks" use Resources and Investigate rather than Fight. Reflect this in the stat block.)

- [ ] **Step 4: Verify and commit**

Run: `cd /Users/ryan/Fate-of-Eberron-2 && bundle exec jekyll build 2>&1 | tail -5`

```bash
git add npcs.md
git commit -m "feat: add Emerald Claw, King's Citadel, and Aurum NPCs"
```

---

### Task 4: Lord of Blades and Independents

**Files:**
- Modify: `npcs.md` (append)

- [ ] **Step 1: Write the Lord of Blades section**

Section header `## Lord of Blades` with faction overview.

Write 3 NPC entries:
- **Hatchet** (she/her): Enforcer, Hitter. Recruiter lieutenant. Hitter stat block.
- **Crucible** (they/them): Wild Card, Hitter. Defector artificer. Hitter stat block.
- **Blade Scouts** (none): Enforcer, Filler. Warforged operatives. Filler stat block.

- [ ] **Step 2: Write the Independents section**

Section header `## Independents` with a brief intro (NPCs without strong faction ties: community figures, freelancers, wild cards).

Write 5 NPC entries:
- **Geth** (he/him): Contact, Hitter. Shifter bouncer. Hitter stat block.
- **Professor Maia Tessant** (she/her): Patron, Threat. Morgrave archaeologist. Threat stat block.
- **Rotgut** (it/its): Informant, Threat. Warforged information collector in the Cogs. Threat stat block.
- **Lira Shol** (she/her): Wild Card, Hitter. Changeling inquisitive. Hitter stat block.
- **Father Dorn** (he/him): Contact, Threat. Sovereign Host priest, soup kitchen operator. Threat stat block.

- [ ] **Step 3: Verify and commit**

Run: `cd /Users/ryan/Fate-of-Eberron-2 && bundle exec jekyll build 2>&1 | tail -5`

```bash
git add npcs.md
git commit -m "feat: add Lord of Blades and Independents NPCs"
```

---

### Task 5: Update index.md and Add Cross-References

**Files:**
- Modify: `index.md`
- Modify: `toolkit.md`

- [ ] **Step 1: Add NPC Gallery to site navigation**

In `index.md`, find the guide cards section. Add a new card after the GM Toolkit card and before the Play Example card:

```html
<div class="guide-card" markdown="1">

### [NPC Gallery]({{ '/npcs' | relative_url }})

36 ready-to-use NPCs organized by faction: Boromar Clan, Daask, House Cannith, House Tharashk, Phiarlan and Thuranni, the Emerald Claw, the King's Citadel, the Aurum, Lord of Blades, and independents.

</div>
```

- [ ] **Step 2: Add cross-reference in toolkit**

In `toolkit.md`, find the "Designing Threats Around Characters" subsection (within the Compels and Drama Escalation section). At the end of that subsection, add:

```markdown
For ready-made NPCs organized by faction and role, see the **[NPC Gallery]({{ '/npcs' | relative_url }})**.
```

- [ ] **Step 3: Verify and commit**

Run: `cd /Users/ryan/Fate-of-Eberron-2 && bundle exec jekyll build 2>&1 | tail -5`

```bash
git add index.md toolkit.md npcs.md
git commit -m "feat: add NPC Gallery to site navigation and toolkit cross-reference"
```

---

## Task Dependencies

Tasks 1 → 2 → 3 → 4 (sequential appends to npcs.md).
Task 5 depends on Tasks 1-4 being complete.

## Self-Review

**Spec coverage:**
- NPC format template → Task 1 (front matter, intro, index) ✓
- Boromar Clan (4 NPCs) → Task 1 ✓
- Daask (4 NPCs) → Task 1 ✓
- House Cannith (4 NPCs) → Task 2 ✓
- House Tharashk (3 NPCs) → Task 2 ✓
- Houses Phiarlan/Thuranni (3 NPCs) → Task 2 ✓
- Emerald Claw (4 NPCs) → Task 3 ✓
- King's Citadel (3 NPCs) → Task 3 ✓
- The Aurum (3 NPCs) → Task 3 ✓
- Lord of Blades (3 NPCs) → Task 4 ✓
- Independents (5 NPCs) → Task 4 ✓
- index.md navigation → Task 5 ✓
- toolkit.md cross-reference → Task 5 ✓

All 36 NPCs accounted for. No placeholders. Stat block format consistent with GM guide.
