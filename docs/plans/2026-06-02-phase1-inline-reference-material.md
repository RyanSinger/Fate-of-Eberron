# Phase 1: Inline Reference Material Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Rewrite Fate of Eberron's character creation, magic system, and reference material using battle tested patterns from Umdaar, Venture City, and the Book of Hanz.

**Architecture:** Two files are modified: `players-guide.md` (character creation, stunts, magic, skill reference) and `gm-guide.md` (difficulty setting, charter cross reference). No new files are created in Phase 1. The spec is at `docs/specs/2026-06-02-phase1-inline-reference-material.md`. All content is prose/markdown, no code.

**Tech Stack:** Markdown, Jekyll (site builds automatically on file changes via hook).

**Writing style:** Follow the existing voice in both guides. Short sentences. Active voice. No em dashes (use colons, commas, or periods instead). No AI writing tells ("testament," "vibrant," "tapestry," "comprehensive," "landscape," "delve," "leverage," "utilize"). Use contractions naturally. Show, don't tell: use examples over abstract explanation.

---

## File Map

| File | What Changes |
|------|-------------|
| `players-guide.md` | Tasks 1, 2, 3, 4, 5, 6, 7, 8 (character creation, aspects, skills, stunts, magic, charter, attack/defend tables, consequence guide) |
| `gm-guide.md` | Task 9 (difficulty setting), Task 10 (charter cross reference, advancement via charter) |

---

### Task 1: Replace Mode-Based Character Creation with Archetype + Background

**Files:**
- Modify: `players-guide.md:47-113` (the "Creating Your Character" intro, Steps 1-2, and mode rating explanation)

This task replaces the mode system introduction and the "Choose Three Modes" section with the new archetype + background + species system. It does NOT touch the individual mode listings yet (that's Task 2).

- [ ] **Step 1: Read the current content**

Read `players-guide.md` lines 47-113 to confirm the exact boundaries. The section starts at `## Creating Your Character` (line 47) and the mode explanation ends just before `## Origins` (line 116).

- [ ] **Step 2: Replace the character creation introduction (lines 47-55)**

Replace:
```markdown
## Creating Your Character

Your character is defined by:

- **Aspects**: Phrases describing who you are (5 total)
- **Modes**: Bundles of skills reflecting your background (3 modes)
- **Stunts**: Special tricks or abilities (3 free, buy more with refresh)
- **Stress and Consequences**: How you absorb harm
- **Refresh**: Your baseline fate points (starts at 3)
```

With:
```markdown
## Creating Your Character

Your character is defined by:

- **Archetype**: What you do now. Defines your important skills, a signature stunt, and how you change the world at milestones.
- **Background**: Where you come from and what you did before. Gives you a stunt and character-building questions.
- **Species** (optional): If you're not human, an aspect and optional stunt.
- **Charter**: Your party's shared stunt, reflecting your group's identity.
- **Aspects**: Phrases describing who you are (5 total).
- **Skills**: Arranged in a pyramid from Great (+4) down to Average (+1).
- **Stunts**: Special tricks or abilities (3 at creation: one archetype, one background, one charter).
- **Stress and Consequences**: How you absorb harm.
- **Refresh**: Your baseline fate points (starts at 3).
```

- [ ] **Step 3: Replace Step 1 (High Concept and Trouble) with updated aspects intro (lines 57-65)**

Replace:
```markdown
## Step 1: High Concept and Trouble

Start with your **high concept**, a phrase that captures who your character fundamentally is.

> Examples: *Cynical Brelish War Veteran*, *Warforged Seeking Purpose*, *Morgrave Scholar with Xen'drik Fever*, *House Medani Inquisitive*

Then define your **trouble**, something that makes your life complicated.

> Examples: *The War Isn't Over for Me*, *I Trust Too Easily*, *Debts to House Cannith*, *Hunted by the Aurum*
```

With:
```markdown
## Step 1: Pick an Archetype

Your archetype defines what your character does now. Each archetype provides:

- **Important Skills**: Three skills central to the archetype. These should guide your skill pyramid choices but don't restrict them.
- **Stunts**: Three associated stunts. Pick one at character creation.
- **Impact**: A unique way your character changes the campaign map at each major milestone.

Pick an archetype from the list below, or create your own. A custom archetype needs: a name, three important skills, three associated stunts, and an impact.
```

- [ ] **Step 4: Replace Step 2 (Choose Three Modes) with the archetype table (lines 67-113)**

Replace the entire Step 2 section (lines 67-113, ending just before `## Origins` on line 116) with the archetype table:

```markdown
| Archetype | Important Skills | Sample Stunts | Impact (at Major Milestones) |
|-----------|-----------------|---------------|--------|
| **Inquisitive** | Investigate, Notice, Contacts | Inquisitive's Eye, Scene Reconstruction, I Know a Guy | Add a contact or informant to the campaign map |
| **Artificer** | Crafts, Lore, Investigate | Jury Rig, Maker's Eye, Improvised Device | Add a location tied to your work (workshop, dig site, client) |
| **Mage** | Lore, Will, Shoot | Arcane Shield, Elemental Blast, Ward Specialist | Add a magical phenomenon or mystery to the campaign map |
| **Priest** | Will, Empathy, Rapport | Divine Conviction, Healing Hands, Turn Undead | Add a community or congregation to the campaign map |
| **Warrior** | Fight, Athletics, Physique | Combat Veteran, Shield Wall, Deadly Charge | Add a rival, enemy, or military contact to the campaign map |
| **Face** | Rapport, Deceive, Contacts | Read the Room, Silver Tongue, Extensive Network | Add a faction relationship (ally, rival, or debt) to the campaign map |
| **Spy** | Stealth, Deceive, Investigate | Dead Drop, Cover Identity, Shadow Network | Add a secret or hidden connection to the campaign map |
| **Explorer** | Athletics, Notice, Will | Danger Sense, Trailblazer, Ruin Runner | Add a location (ruin, passage, landmark) to the campaign map |
| **Pilot** | Drive, Crafts, Notice | Evasive Maneuvers, My Ship My Rules, Barnstormer | Add a route, port, or vehicle upgrade to the campaign map |

---
```

- [ ] **Step 5: Verify the file renders correctly**

Run: `cd /Users/ryan/Fate-of-Eberron-2 && bundle exec jekyll build 2>&1 | tail -5`
Expected: Build succeeds with no errors.

- [ ] **Step 6: Commit**

```bash
cd /Users/ryan/Fate-of-Eberron-2
git add players-guide.md
git commit -m "feat: replace mode system with archetype-based character creation"
```

---

### Task 2: Replace Origins, Backgrounds, and Callings with New Backgrounds Section

**Files:**
- Modify: `players-guide.md:116-461` (Origins, Backgrounds, Callings sections, and Creating Custom Modes)

This task replaces all 26 individual mode listings and the "Creating Custom Modes" section with the new Backgrounds table and Species section.

- [ ] **Step 1: Read current section boundaries**

Read `players-guide.md` lines 116-515 to confirm exact boundaries. `## Origins` starts at line 116, `## Callings` at 344, `### Creating Custom Modes` at 462, and the section ends before `## Step 3: Remaining Aspects` at line 516.

- [ ] **Step 2: Replace the entire Origins/Backgrounds/Callings block (lines 116-515)**

Replace everything from `## Origins` (line 116) through the end of `### Creating Custom Modes` (line 515, just before `## Step 3`) with:

```markdown
## Step 2: Pick a Background

Your background defines where your character comes from and what they did before their current life. Each background provides:

- **Important Skills**: Three skills central to the background.
- **Stunts**: Three associated stunts. Pick one at character creation.
- **Questions**: Prompts to help you flesh out your character's history and aspects.

Pick a background from the list below, or create your own. A custom background needs: a name, three important skills, three associated stunts, and a set of character-building questions.

| Background | Important Skills | Sample Stunts | Questions to Consider |
|-----------|-----------------|---------------|----------------------|
| **Soldier** | Fight, Athletics, Provoke | War Stories, Battlefield Awareness, Brothers in Arms | Which nation did you serve? What did you see that changed you? Do you miss it? |
| **Criminal** | Burglary, Stealth, Contacts | Underworld Connections, Case the Joint, Honor Among Thieves | Who do you still owe? What line won't you cross? Are you still in the life? |
| **Scholar** | Lore, Investigate, Will | Obsessive Researcher, Ancient Languages, Theoretical Breakthrough | What's your field? What question drives you? What did you discover that scared you? |
| **Noble** | Rapport, Resources, Contacts | Noble Bearing, Old Money, Political Favor | Is your family's influence a gift or a cage? What's expected of you? Who resents your privilege? |
| **Entertainer** | Rapport, Deceive, Empathy | Play to the Crowd, Stage Presence, Read the Audience | What's your art? Where have you performed? What audience do you never want to face again? |
| **Outlander** | Athletics, Notice, Physique | Survivor, Read the Wild, Hard to Kill | Where did you come from? Why did you leave? What about civilization confuses or disgusts you? |
| **Street Urchin** | Stealth, Burglary, Notice | Rat Runner, Invisible in a Crowd, Scrappy Fighter | Who raised you, if anyone? What ward or district is yours? Who do you protect now? |
| **Dragonmarked Heir** | Contacts, Resources, Rapport | House Connections, Mark Focus, Family Name | Which house? Are you loyal or rebellious? What does the house want from you that you're not willing to give? |
| **Veteran Spy** | Deceive, Stealth, Investigate | Old Covers Still Work, Trust Issues, Burned but Not Forgotten | Which agency? Citadel? Trust? Royal Eyes? What secret do you carry? Are you still active? |
| **Refugee** | Empathy, Will, Notice | Nothing Left to Lose, Community of Survivors, Keen Eye for Danger | What did you lose? Where are you from? What do you hold onto from the old life? |

---

## Step 2b: Species (Optional)

Most characters on Eberron are human. If you want to play a non-human species, take an aspect describing it (this counts as one of your five aspects) and optionally purchase a species stunt (costs 1 refresh).

The aspect alone grants narrative permission for anything that species can naturally do. A Warforged aspect means you don't eat, sleep, or breathe. A Changeling aspect means you can shift your features. No stunt needed for these basic abilities.

The species stunt represents a mechanical advantage beyond narrative permission.

| Species | Aspect Grants (Narrative Permission) | Optional Stunt (Costs 1 Refresh) |
|---------|-------------------------------------|----------------|
| **Warforged** | Don't eat, sleep, or breathe. Resistant to poison and disease. Can be repaired instead of healed. | *Built for War*: Armor:1 against physical attacks. |
| **Changeling** | Can shift features at will to match any humanoid. | *Perfect Mimic*: +2 to Deceive when impersonating a specific person you've studied. |
| **Shifter** | Can briefly manifest bestial features (claws, enhanced senses, thick hide). | *Shifting*: Pick two skills when you take this stunt. Once per scene, you may swap their ratings for the rest of the scene. |
| **Kalashtar** | Telepathic communication with willing targets. Resistance to dream invasion. | *Psychic Shield*: +2 to Will when defending against mental attacks from extraplanar entities. |

Other species exist on Eberron (gnomes, elves, halflings, orcs, goblinoids). For these, take a descriptive aspect and work with your GM on a species stunt if one makes sense. Not every species needs a mechanical distinction. An elf's long life and keen senses are narrative color, not a stunt.

---
```

- [ ] **Step 3: Verify the file renders correctly**

Run: `cd /Users/ryan/Fate-of-Eberron-2 && bundle exec jekyll build 2>&1 | tail -5`
Expected: Build succeeds with no errors.

- [ ] **Step 4: Commit**

```bash
cd /Users/ryan/Fate-of-Eberron-2
git add players-guide.md
git commit -m "feat: replace 26 mode listings with backgrounds table and species section"
```

---

### Task 3: Rewrite Aspects and Skills Sections

**Files:**
- Modify: `players-guide.md` at the former `## Step 3: Remaining Aspects` section (now renumbered) and add skill pyramid section

After Task 2, `## Step 3: Remaining Aspects` (originally line 516) needs to be renumbered and rewritten to reflect the new five-aspect structure (high concept, motivation, background, relationship, free) replacing the old two-aspect start (high concept + trouble).

- [ ] **Step 1: Read current aspects section**

Read the section starting at `## Step 3: Remaining Aspects` through the end of `### Eberron-Specific Ideas` to confirm exact content.

- [ ] **Step 2: Replace the aspects section**

Replace the `## Step 3: Remaining Aspects`, `### What Makes a Good Aspect?`, and `### Eberron-Specific Ideas` sections with:

```markdown
## Step 3: Write Your Aspects

Your character has five aspects. Build them during creation, refine them in play.

### High Concept

A broad description combining your archetype, background, species, and anything else that captures who you are at a glance. This is how you'd pitch the character to a friend.

> Examples: *Cyran Refugee Turned Sharn Inquisitive*, *Warforged Artificer Seeking a Soul*, *Karrnathi Noble Playing Both Sides*, *Phiarlan Spy Who Fell in Love*

### Motivation

Why your character acts. This should push you into action, even when it's risky. Think of it as your trouble's proactive twin: not just what makes your life complicated, but what you can't stop yourself from doing about it.

> Examples: *I Won't Let What Happened to Cyre Happen Again*, *Someone Has to Stop House Cannith*, *The Truth Is Worth Any Price*, *I Will Earn My Place Among the Living*

### Background

Where you grew up, the community that shaped you, and the values you carry (or reject). Use your background's character-building questions to inspire this.

> Examples: *Proud Karrnathi, Ashamed of What We Did*, *From the Gerto Wildernexus, Where People Are Down to Earth*, *Lower Dura Born, Lower Dura Loyal*

### Relationship

Your dynamic with another PC. If you have an even number of players, link in pairs. An odd number means one character links to two others.

Bond types to consider: best friends, siblings in arms, mentor and protege, love interest, rivals, former enemies, debtor and creditor.

> Examples: *She Saved My Life in the Mournland and I Still Don't Know Why*, *We Served in the Same Unit but on Different Sides*, *I Owe Them Everything and They Won't Let Me Forget It*

Each player in the pair can interpret the relationship differently. One might write *Like a Daughter to Me* while the other writes *Reminds Me of the Father I Lost*. Different perspectives on the same bond create drama.

### Free Aspect

Anything else important about your character. A signature weapon, a personality trait, a secret, a catchphrase, an obligation.

> Examples: *My Father's Byeshk Blade*, *Trust Is a Luxury I Can't Afford*, *Runaway Runekeeper*, *I'm Gorgeous (and I Know It)*

**Tip**: If all your aspects are positive, adding a negative or mixed free aspect gives you more compel opportunities, which means more fate points.

### What Makes a Good Aspect?

Good aspects are **double-edged**. They help you AND create complications. *Loyal to House Cannith* gets you resources and connections, but it also means the House can call in favors, drag you into politics, or put you in conflict with your friends.

Good aspects are **specific**. *Strong* is boring. *Strongest Dockworker in Cliffside* tells a story.

Good aspects are **true**. Once you write it down, it's a fact about the world. *I Know Everyone in Lower Dura* means you actually do. The GM will hold you to it, and reward you for it.

---

## Step 4: Assign Your Skills

Arrange your skills in a pyramid with the highest rated skill at Great (+4):

- 1 Great (+4) skill
- 2 Good (+3) skills
- 3 Fair (+2) skills
- 4 Average (+1) skills
- All other skills at Mediocre (+0)

Your archetype and background important skills should guide your choices but don't restrict them. A Warrior with Fight, Athletics, and Physique as important skills might still put Contacts at Great (+4) because this particular warrior is a well-connected veteran, not a brute.

**The 18 skills:** Athletics, Burglary, Contacts, Crafts, Deceive, Drive, Empathy, Fight, Investigate, Lore, Notice, Physique, Provoke, Rapport, Resources, Shoot, Stealth, Will. See the Quick Reference at the end of this guide for descriptions of each.

---
```

- [ ] **Step 3: Verify the file renders correctly**

Run: `cd /Users/ryan/Fate-of-Eberron-2 && bundle exec jekyll build 2>&1 | tail -5`
Expected: Build succeeds.

- [ ] **Step 4: Commit**

```bash
cd /Users/ryan/Fate-of-Eberron-2
git add players-guide.md
git commit -m "feat: rewrite aspects as five-aspect structure, add skill pyramid"
```

---

### Task 4: Rewrite Stunts Section with Seven Patterns

**Files:**
- Modify: `players-guide.md` at the `## Step 4: Stunts` section (originally lines 548-581)

- [ ] **Step 1: Read current stunts section**

Read the section from `## Step 4: Stunts` through `### Sample Stunts` to confirm boundaries.

- [ ] **Step 2: Replace the entire stunts section**

Replace from `## Step 4: Stunts` through the end of `### Sample Stunts` (ending before `## Dragonmarks`) with the full seven-pattern stunt templates from the spec. The content is in spec Section 4. Include all seven patterns (Skill Bonus, Skill Substitution, Once Per Session, Fate Point Powered, Conditional Permission, Teamwork/Altruistic, Personal Hardware) with their templates, Eberron examples, and design guidance.

The section header should be renumbered to `## Step 5: Pick Your Stunts` to follow the new step numbering (Step 1: Archetype, Step 2: Background, Step 2b: Species, Step 3: Aspects, Step 4: Skills, Step 5: Stunts).

Add after the design guidance a creation checklist and refresh note:

```markdown
### Three Starting Stunts

At creation, pick three stunts, one from each source:

- One **archetype stunt** (from your archetype's list or create your own)
- One **background stunt** (from your background's list or create your own)
- One **charter stunt** (from your group's charter; see the Charter section)

You can buy additional stunts by spending refresh (1 refresh per extra stunt, minimum refresh of 1). If you took a species stunt, that also costs 1 refresh.

### Refresh

Your refresh starts at 3. This is the minimum number of fate points you begin each session with. Reduce it by 1 for each stunt beyond your starting three, and by 1 if you took a species stunt.

---
```

- [ ] **Step 3: Also update the Equipment section (originally lines 1060-1076)**

The Equipment section already has a Personal Hardware stunt. Since Personal Hardware is now part of the stunt patterns section, replace the Equipment section with a brief cross-reference:

```markdown
### Equipment

Most equipment is handled narratively. If you have a sword, you can fight with it. If you're an artificer, you have tools. Equipment grants narrative permission, not mechanical bonuses.

For gear that matters mechanically, use the **Personal Hardware** stunt pattern (see Step 5: Pick Your Stunts). For magical items, use the **Invention** rules.
```

- [ ] **Step 4: Verify the file renders correctly**

Run: `cd /Users/ryan/Fate-of-Eberron-2 && bundle exec jekyll build 2>&1 | tail -5`
Expected: Build succeeds.

- [ ] **Step 5: Commit**

```bash
cd /Users/ryan/Fate-of-Eberron-2
git add players-guide.md
git commit -m "feat: expand stunts section with seven patterns including personal hardware"
```

---

### Task 5: Add Charter System

**Files:**
- Modify: `players-guide.md`, new section added after the Dragonmarks section and before "Magic and Artifice"

The Charter section goes between Dragonmarks and Magic because it's part of character/party creation, not gameplay mechanics.

- [ ] **Step 1: Identify insertion point**

The Charter section goes after the last Dragonmark entry (`### Mark of Warding (House Kundarak)`, ending around line 691) and before `## Magic and Artifice` (line 693).

- [ ] **Step 2: Insert the Charter section**

Insert after the Dragonmarks section divider (`---`) and before `## Magic and Artifice`:

The full Charter content is in spec Section 5. Insert: "## Your Charter" header, the explanation, the components table, all five framework examples (Agency, Expedition, Cell, Salvage Crew, House Operatives), the Charter Stunts section with three stunts per framework (15 total), the "Building the Charter" Session Zero sequence, and the Charter Advancement section.

- [ ] **Step 3: Verify the file renders correctly**

Run: `cd /Users/ryan/Fate-of-Eberron-2 && bundle exec jekyll build 2>&1 | tail -5`
Expected: Build succeeds.

- [ ] **Step 4: Commit**

```bash
cd /Users/ryan/Fate-of-Eberron-2
git add players-guide.md
git commit -m "feat: add charter system (party framework) adapted from Umdaar banners"
```

---

### Task 6: Rewrite Magic and Artifice Section

**Files:**
- Modify: `players-guide.md` at `## Magic and Artifice` (originally line 693) through `#### Ritual Magic` (ending around line 1150)

This task replaces Narrative Magic with Consequential Magic, rewrites Signature Spells with the Venture City enhancement framework, and preserves Brainstorms, Invention, and Ritual Magic as-is (with minor cross-references).

- [ ] **Step 1: Read the current Magic and Artifice section**

Read `players-guide.md` from `## Magic and Artifice` through `#### Ritual Magic` to confirm exact boundaries and identify what to keep.

- [ ] **Step 2: Replace the section introduction and Narrative Magic (lines 693-705)**

Replace:
```markdown
## Magic and Artifice

Magic in Eberron is everywhere but powerful magic is rare. There are two ways to use magic in play:

### Narrative Magic

If you have an aspect that establishes magical ability...
[rest of Narrative Magic section through line 705]
```

With the full Consequential Magic content from spec Section 7: the "Two Gears of Magic" table, the four channels of magical attack, consequences as spell effects, consented/beneficial magic, treatment/dispelling, and wards/persistent effects via Bronze Rule.

Keep the section header as `## Magic and Artifice` and add a brief intro:

```markdown
## Magic and Artifice

Magic in Eberron is everywhere, but powerful magic is rare. Your character needs a magical aspect (high concept, free aspect, or species aspect) to use magic at all. Without one, you're a mundane person in a magical world.

Magic uses the same four actions as everything else. The difference is in how lasting and powerful the effect is.
```

Then the "Two Gears of Magic" table, then the rest of the consequential magic content.

- [ ] **Step 3: Keep Brainstorms section as-is (lines 707-733)**

The Brainstorms section does not change. Verify it still reads correctly in context after the new magic intro.

- [ ] **Step 4: Keep Invention section as-is (lines 735-792)**

The Invention section does not change. Add one line at the end, before the section divider:

```markdown
**Venture City Drawbacks**: When "Flaw" is chosen as a catch, you can use drawback aspects from the Venture City model: aspects that exist specifically to be compelled. *Drains Quickly*, *Attracts Unwanted Attention*, *Only Works in Moonlight*.
```

- [ ] **Step 5: Replace the Spellcasting section (lines 1078-1150)**

Replace the entire `### Spellcasting` section (Narrative Permission, Magic as Actions, Magical Costs, Signature Spells, Ritual Magic) with:

```markdown
### Spellcasting

See **Magic and Artifice** above for the full magic system. This section summarizes how magic works in play.

#### Narrative Permission

Your aspects determine what magic you can attempt. A *Morgrave War Mage* can hurl force bolts. A *Gatekeeper Druid* communes with nature spirits. A *Priest of the Silver Flame* channels divine power. Characters without a magical aspect can't cast spells.

#### Magic as Actions

| What You Want | How It Works | Duration |
|---------------|-------------|----------|
| Temporary tactical effect | Create Advantage (situation aspect) | Scene, or until overcome |
| Lasting effect on a target | Attack (consequence) | Consequence recovery timeline |
| Repeatable signature ability | Stunt (see Signature Spells) | Permanent (per stunt limits) |
| Collaborative ritual/research | Brainstorm | Until the problem is solved |
| Crafted magical item | Invention (catches) | Permanent until broken/lost |

#### Magical Costs

When magic fails or ties, the GM can introduce costs:

**Minor costs** (ties): unwanted attention, takes longer than expected, minor side effect, 1-2 stress from strain.

**Major costs** (failures offered as success at cost): affects more than intended, something notices from across the planes, leaves a lingering aspect the GM can invoke, magical consequence (*Drained*, *Arcane Burnout*).

#### Signature Spells

For magic your character uses reliably, build it as a stunt. A signature spell follows the normal stunt patterns (see Step 5) with one important rule:

**The Replication Rule**: A signature spell that replicates what another skill already does needs a limit. Either once per scene, costs a fate point, or is restricted to a specific situation. The limit is what makes it a spell instead of just having the skill.

Signature spells that do things no skill covers (healing consequences, summoning creatures, creating wards) can be more permissive because they're not stepping on another skill's territory.

**Enhancement**: You can invest additional stunts into an existing signature spell to upgrade it. Each enhancement extends the spell's reach, power, or flexibility.

| Enhancement | Effect |
|-------------|--------|
| **Master** | +2 to rolls with this spell |
| **Widen** | Affect a full zone instead of one target |
| **Extend** | Increase range by one zone |
| **Fortify** | Use the spell's skill to defend as well as attack |
| **Deepen** | Inflict a consequence instead of stress, or reduce consequence severity for healing |
| **Quicken** | Use the spell as a free action once per scene |

Not every enhancement fits every spell. Pick what makes fictional sense.

**Example: Force Bolt** (Morgrave War Mage)
- **Base (1 stunt):** Once per scene, I can use Lore to make a physical attack against a target up to 2 zones away. Targets defend with Athletics.
- **Enhancement: Master Force Bolt (1 stunt):** When I attack with Force Bolt, I get +2 to Lore.
- **Enhancement: Force Shield (1 stunt):** When I am targeted by a ranged physical attack I can see, I can use Lore to defend.
- **Enhancement: Concussive Wave (1 stunt):** I can spend a fate point to attack every target in a zone with Force Bolt.

**Example: Healing Prayer** (Priest of the Silver Flame)
- **Base (1 stunt):** Once per scene, I can roll Will against Fair (+2) to clear all physical stress on a person I touch.
- **Enhancement: Miraculous Recovery (1 stunt):** When I treat a physical consequence with Will, I reduce the consequence severity by one step. Mild consequences clear immediately.
- **Enhancement: Radiant Shield (1 stunt):** I can spend a fate point to grant an ally in my zone Armor:2 against undead attacks for the rest of the scene.

**Example: Whispering Shadows** (Phiarlan Shadow Spy)
- **Base (1 stunt):** Once per scene, I can use Deceive to create the aspect *Cloaked in Shadow* on myself with two free invokes instead of the usual one.
- **Enhancement: Shadow Step (1 stunt):** When I am in a zone with a shadow-related aspect, I can spend a fate point to move to any other zone in the scene that also has a shadow-related aspect, bypassing all obstacles.
- **Enhancement: Phantom Decoy (1 stunt):** I can use Deceive to create a shadow illusion of myself in an adjacent zone. The illusion has one stress box and can be attacked or investigated (Investigate vs. my Deceive) to dispel.

**Example: Lightning Call** (Lyrandar Storm Caller)
- **Base (1 stunt):** Once per scene, I can use Shoot to make a magical attack using lightning against a target up to 3 zones away. Targets defend with Athletics.
- **Enhancement: Chain Lightning (1 stunt):** When I invoke an aspect on a Lightning Call attack, I may split the invoke bonus (+1/+1) across two targets in the same zone instead of +2 on one.
- **Enhancement: Storm Shield (1 stunt):** When I am targeted by a ranged physical attack, I can use Shoot to defend by deflecting the projectile with a gust of wind.

**Example: Animate Dead** (Order of the Emerald Claw Necromancer)
- **Base (1 stunt):** Once per scene, I can summon one undead servant. It has one aspect (*Mindless Undead Servant*), one Good (+3) skill (Fight), and 2 physical stress boxes. It acts on my turn and lasts until the end of the scene or until destroyed.
- **Enhancement: Stronger Dead (1 stunt):** My summoned undead gains an additional Good (+3) skill (chosen when summoned) and a mild consequence slot.
- **Enhancement: Rise Again (1 stunt):** When my summoned undead is taken out, I can spend a fate point to immediately resummon it in my zone with full stress but carrying any consequences it had.

#### Ritual Magic

For complex magical workings (opening a portal to Thelanis, binding a demon, raising the dead), use a **challenge** or the **invention** rules. Big magic shouldn't be a single roll. It should be a scene (or several scenes) with multiple obstacles and potential complications.

> **Example**: The party needs to close a manifest zone that's bleeding aberrations into Sharn. The GM frames it as a challenge:
> - Contain the immediate threat (Fight vs. Good)
> - Identify the zone's resonance frequency (Lore vs. Great)
> - Channel enough power to seal it (Will vs. Great)
> - Complete the ritual before more creatures emerge (time pressure)
>
> Failures don't stop the ritual. They introduce complications. Maybe the seal is imperfect, or closing it draws attention from something in Xoriat.
```

- [ ] **Step 6: Verify the file renders correctly**

Run: `cd /Users/ryan/Fate-of-Eberron-2 && bundle exec jekyll build 2>&1 | tail -5`
Expected: Build succeeds.

- [ ] **Step 7: Commit**

```bash
cd /Users/ryan/Fate-of-Eberron-2
git add players-guide.md
git commit -m "feat: add consequential magic system and signature spell framework"
```

---

### Task 7: Replace Attack/Defend Tables and Add Consequence Guide

**Files:**
- Modify: `players-guide.md` at `#### Which Skills Attack and Defend?` and `#### Non-Violent Attacks` sections, and at `### Stress and Consequences`

- [ ] **Step 1: Replace the attack/defend section (originally lines 896-919)**

Replace from `#### Which Skills Attack and Defend?` through the end of `#### Non-Violent Attacks` (ending before `### Aspects and Fate Points`) with the full attack and defend tables from spec Section 1, plus the closing note about GM/table permission and stunts.

Keep the existing guidance about non-violent attacks and taking out with words, but integrate it as prose paragraphs after the defend table rather than as a separate subsection.

- [ ] **Step 2: Add consequence naming guide to Stress and Consequences section**

After the existing consequence recovery mechanics (after the "Self-treatment adds +2..." paragraph, originally around line 1042), insert the consequence naming guide from spec Section 3: physical consequences table, mental consequences table, magical consequences table, naming principle, and recovery renaming examples.

- [ ] **Step 3: Verify the file renders correctly**

Run: `cd /Users/ryan/Fate-of-Eberron-2 && bundle exec jekyll build 2>&1 | tail -5`
Expected: Build succeeds.

- [ ] **Step 4: Commit**

```bash
cd /Users/ryan/Fate-of-Eberron-2
git add players-guide.md
git commit -m "feat: expand attack/defend tables and add consequence naming guide"
```

---

### Task 8: Update Sample Character, Quick Reference, and Character Sheet

**Files:**
- Modify: `players-guide.md` at `## Sample Character: Kaela ir'Taran` and `## Blank Character Sheet`

- [ ] **Step 1: Read current sample character**

Read the Kaela ir'Taran section to understand how she's currently built with modes.

- [ ] **Step 2: Rebuild Kaela using archetype + background**

Rewrite the sample character using the new system. Kaela was a Soldier (Good), Criminal (Fair), Cyran (Average). Translate to:

- **Archetype**: Inquisitive (she investigates now)
- **Background**: Soldier (she fought in the Last War)
- **Species**: Human (no aspect needed)
- **Aspects**: Rewrite to the five-aspect structure (high concept, motivation, background, relationship, free) keeping her existing aspects where they fit
- **Skills**: Convert her mode-based skills to a pyramid at Great (+4)
- **Stunts**: One archetype (Inquisitive's Eye or similar), one background (War Stories or similar), one charter (pick from Agency framework)

Preserve the character's identity and personality. Change the system, not the character.

- [ ] **Step 3: Update the blank character sheet**

Update the blank character sheet section to reflect the new structure: archetype, background, species (optional), five named aspect slots, skill pyramid layout, three stunt slots labeled (archetype, background, charter), refresh, stress tracks, consequences.

- [ ] **Step 4: Update the Advancement section (originally lines 1152-1178)**

Rename "Milestones (End of Session)" and "Breakthroughs (End of Arc)" to match Umdaar's terminology. Add Impact to the Breakthroughs section:

After "Increase one skill by +1", add:
```markdown
- Perform your archetype's **Impact**: Add something to the campaign map as described in your archetype
```

Also add charter advancement to Breakthroughs:
```markdown
The group may also:
- Improve a community aspect in the charter
- Upgrade the charter's headquarters
- Change the charter's reputation aspect
```

- [ ] **Step 5: Verify the file renders correctly**

Run: `cd /Users/ryan/Fate-of-Eberron-2 && bundle exec jekyll build 2>&1 | tail -5`
Expected: Build succeeds.

- [ ] **Step 6: Commit**

```bash
cd /Users/ryan/Fate-of-Eberron-2
git add players-guide.md
git commit -m "feat: update sample character, sheet, and advancement for new system"
```

---

### Task 9: Rewrite Difficulty Setting in GM Guide

**Files:**
- Modify: `gm-guide.md:90-109` (the "Setting Difficulty and Opposition" section)

- [ ] **Step 1: Read the current difficulty section**

Read `gm-guide.md` lines 90-109 to confirm exact content.

- [ ] **Step 2: Replace the section**

Replace from `## Setting Difficulty and Opposition` through the end of the section (ending before `## Session Zero` at line 111) with the full content from spec Section 2: "Should You Roll At All?" framing (Put a Scene On It), the six-tier difficulty table with Eberron examples, and the rules of thumb.

Keep the section header as `## Setting Difficulty and Opposition`.

- [ ] **Step 3: Also update the Quick Reference appendix (lines 1184-1191)**

Replace the `### Quick Opposition Guidelines` section in the appendix with the same difficulty table (abbreviated, no examples column) for quick reference at the table.

- [ ] **Step 4: Verify the file renders correctly**

Run: `cd /Users/ryan/Fate-of-Eberron-2 && bundle exec jekyll build 2>&1 | tail -5`
Expected: Build succeeds.

- [ ] **Step 5: Commit**

```bash
cd /Users/ryan/Fate-of-Eberron-2
git add gm-guide.md
git commit -m "feat: rewrite difficulty setting with Put a Scene On It framing"
```

---

### Task 10: Add Charter Cross-References to GM Guide

**Files:**
- Modify: `gm-guide.md` at `## Session Zero` and `## Campaign Frameworks`

- [ ] **Step 1: Update Session Zero section**

In the `## Session Zero` section (line 111), add a reference to the Charter system after the existing "What to Cover" content. Insert before `### Questions to Ask Players`:

```markdown
#### Build the Charter

After establishing safety tools and expectations, build the party's **Charter** together. See the Player's Guide for the full Charter system. The Charter gives the group a shared framework, territory, headquarters, community, contact, antagonist, and reputation before anyone makes individual characters.

Building the charter first means every character is created with shared context. Players know who they're protecting, where they're based, and who they've already fought.
```

- [ ] **Step 2: Add charter framework references to Campaign Frameworks**

In each of the five campaign framework sections (Inquisitive Agency, Xen'drik Expedition, etc.), add a one-line note at the top connecting to the Charter:

```markdown
*Charter Framework: Agency. See the Player's Guide for charter components, stunts, and Session Zero build sequence.*
```

Adjust the framework name for each (Agency, Expedition, Cell, Salvage Crew, House Operatives).

- [ ] **Step 3: Update the "Running Magic and Artifice" section (lines 1031-1065)**

Update `### When Players Use Narrative Magic` to reference the new Consequential Magic system:

Replace:
```markdown
### When Players Use Narrative Magic

When a player describes their action as magical, let them. As long as they're rolling an appropriate skill and have a magical aspect, the fiction is up to them. A Lore roll to create an advantage is a divination spell or an arcane analysis, whichever the player prefers.
```

With:
```markdown
### When Players Use Magic

Magic works in two gears. **Create Advantage** is the default for temporary tactical effects: a shield, a distraction, a divination. These create situation aspects that last until the scene ends or someone overcomes them.

**Consequential magic** is for lasting effects. When a magical attack deals enough stress to force a consequence, that consequence IS the spell effect. *Magical Sleep*, *Phiarlan Glamour: Wrong Face*, *Mournland Corruption Spreading*. The consequence's recovery timeline is the spell's duration. See the Player's Guide for the full system.

Let players describe their actions as magical whenever they have a magical aspect and are rolling an appropriate skill. The fiction is theirs. Your job is to set appropriate difficulty and introduce costs on failures and ties.
```

- [ ] **Step 4: Verify the file renders correctly**

Run: `cd /Users/ryan/Fate-of-Eberron-2 && bundle exec jekyll build 2>&1 | tail -5`
Expected: Build succeeds.

- [ ] **Step 5: Commit**

```bash
cd /Users/ryan/Fate-of-Eberron-2
git add gm-guide.md
git commit -m "feat: add charter cross-references and update magic guidance in GM guide"
```

---

### Task 11: Final Review and Consistency Pass

**Files:**
- Read: `players-guide.md` (full), `gm-guide.md` (modified sections)

- [ ] **Step 1: Read the complete players-guide.md**

Read the entire file to check for:
- Broken internal references (sections that point to old section names)
- Step numbering consistency (Steps 1-5 should flow: Archetype, Background/Species, Aspects, Skills, Stunts)
- Any remaining mentions of "modes" that should be updated
- Consistent terminology (archetype not calling, background not origin, charter not banner)

- [ ] **Step 2: Fix any issues found**

Make targeted edits to fix broken references, inconsistent terminology, or numbering errors. Do not rewrite sections that are already correct.

- [ ] **Step 3: Search for stale references**

Search both files for: "mode", "calling", "origin mode", "Good (+3) mode", "Fair (+2) mode", "Average (+1) mode", "improvement points", "Trained", "Focused", "Specialized" (in the mode-allocation sense). Replace or remove any that remain.

- [ ] **Step 4: Verify both files render correctly**

Run: `cd /Users/ryan/Fate-of-Eberron-2 && bundle exec jekyll build 2>&1 | tail -5`
Expected: Build succeeds.

- [ ] **Step 5: Commit**

```bash
cd /Users/ryan/Fate-of-Eberron-2
git add players-guide.md gm-guide.md
git commit -m "fix: consistency pass, remove stale mode references"
```

---

## Task Dependency Summary

Tasks 1-4 must be done in order (they modify overlapping regions of players-guide.md sequentially).

Task 5 (Charter) can be done after Task 4 (it inserts at a different location).

Task 6 (Magic) can be done after Task 4 (it modifies the magic section, independent of earlier structural changes).

Task 7 (Attack/Defend + Consequences) can be done after Task 6 (it modifies the Playing the Game section).

Task 8 (Sample Character + Advancement) should be done after Tasks 1-7 since it needs to reflect all changes.

Task 9 (GM Difficulty) is independent and can be done any time.

Task 10 (GM Cross-References) should be done after Tasks 5 and 6 since it references Charter and Consequential Magic.

Task 11 (Final Review) must be last.

```
Tasks 1 → 2 → 3 → 4 → 5 → 7 → 8 → 11
                   ↘ 6 → 7 ↗
Task 9 (independent) → 11
Task 10 (after 5, 6) → 11
```
