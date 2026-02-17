# Internal Notes for Claude Sessions

Working notes on this project. No sugarcoating.

**Always push to remote after writing to disk.** Don't wait for the user to ask.

---

## Project Status

**What this repo is:** Fate of Eberron—a custom Fate adaptation for running campaigns in the Eberron setting.

**What's in the repo:**
- `setting-guide.md` — Lore-only setting primer (no mechanics)
- `players-guide.md` — Character creation, modes, stunts, dragonmarks, magic
- `gm-guide.md` — Running the game, adversaries, factions, campaigns
- `play-example.md` — Full scene with 5 iconic PCs demonstrating gameplay
- `README.md` — Project overview
- `CLAUDE.md` — This file

**What was removed:**
- All original Fate SRD markdown files
- All HTML source files
- All build tooling
- Everything except the three Eberron documents

---

## Design Decisions

These are the settled design choices. Don't revisit unless Ryan asks.

### Base System
- **Fate Condensed** as foundation
- **Default power level**: Superb (+5) peak skill, 3 refresh, 3 free stunts
- **Dual stress tracks**: Physical (3 boxes) and Mental (3 boxes)
- **Standard consequences** (Mild/Moderate/Severe, not conditions system)

### Character Creation: Mode-Based
- Characters pick **3 modes** from a unified list
- Modes rate at Good (+3), Fair (+2), Average (+1)
- Skills within modes: Trained (+0), Focused (+1), Specialized (+2) above mode rating
- Reinforced skills (in multiple modes) get +1 bonus
- Skill cap: Great (+5) at character creation
- Modes organized loosely as Origins, Backgrounds, Callings—but players can pick any 3
- **Custom modes**: Pick 5 thematically coherent skills, add suggested aspects

### Magic System: Actions with Flavor
- **Narrative permission**: Modes/aspects grant permission to describe actions as magic
- **Magic as the four actions**: Overcome, Create Advantage, Attack, Defend with magical flavor
- **Magical costs**: Minor costs on ties, major costs on failures (backfire, collateral damage, unwanted attention)
- **Signature Spells**: Stunts that follow normal stunt patterns (+2 narrow, permission, once per session)
- **Ritual Magic**: Use challenges or invention rules for major workings
- **Wide magic setting**: Academics merged into Lore (distinction doesn't matter)

### Dragonmarks
- **Aspect + stunts model**
- Mark aspect grants narrative permission for basic mark effects
- Each House has 2 exclusive stunts

### Stunt Balance Philosophy
- **Skill substitution stunts** (use X instead of Y) don't need usage limits—they're already situational
- **+2 bonus stunts** need narrow triggers to be balanced
- **"Once per scene/session" limits** only for effects that would be problematic if spammed:
  - Healing/clearing consequences (Healing Touch)
  - Story declarations (Safe Haven)
- **Bodyguard-style stunts** (redirect stress) are self-balancing—you pay with your own stress track

### Zone Attacks
- Spend an invoke (free invoke or fate point) instead of taking +2
- Roll once, all targets in zone defend individually
- Damage dealt based on margin against each defender
- Ties area effects to the fiction (need something to invoke)

### What's NOT in the system
- No custom extras (everything in aspects, skills, stunts)
- No action points or special hero mechanics
- No conditions system (using standard consequences)
- No scaled invocation rules
- No separate Academics skill (merged into Lore)

### Design Philosophy (Book of Hanz)
- **Fiction first**: Dice constrain narration, don't dictate it
- **Put a scene on it**: Never resolve actions abstractly; establish when/where/who before rolling
- **TV Test**: If it wouldn't make the cut as a TV scene, skip or redesign it
- **Ask "What does success look like?"**: Get player intent before dice roll
- **Aspects are story hooks**: Grant permission, create complications, build setting—NOT mechanical bonuses duplicating skills

### Non-Violent Attacks (Atomic Robo)
- Attacks = any action weakening opponent's ability/desire to fight
- Rapport attacks are valid (flattery, persuasion, buying off mercenaries)
- Don't separate physical and social conflicts—mix them
- Deceive as Rapport: target defends with Will or Empathy; if Empathy succeeds, attacker exposed
- Taking out with words: treat as concession, not mind control

---

## The Three Documents

**Setting Guide**: Lore reference. No mechanics. Covers:
- Core themes (moral ambiguity, aftermath of war, wide magic, cinematic action)
- The Five Nations
- Dragonmarked Houses
- Unique peoples (Warforged, Changelings, Shifters, Kalashtar)
- Religion and planes
- GM and player guidance for tone

**Player's Guide**: Character creation and rules. Covers:
- Mode-based character creation
- Full mode list (9 Origins, 8 Backgrounds, 9 Callings)
- Dragonmark aspects and stunts for all 12 marks (13 houses, but Phiarlan/Thuranni share Mark of Shadow)
- Narrative magic and brainstorm rules
- Invention rules for artificers
- Sample character
- Blank character sheet

**GM's Guide**: Running the game. Covers:
- Core principles for Eberron tone
- Session Zero guidance (campaign pitch, party connections, questions to ask)
- Safety tools (X-Card, Script Change, Lines and Veils)
- Scale system (GM tool for mythic entities—dragons, overlords, daelkyr)
- Adversary building using Fate Adversary Toolkit categories (Threats, Fillers, Hitters, Bosses, Obstacles, Countdowns)
- All major factions as characters with aspects and agendas
- Compel examples for Eberron themes
- Five campaign frameworks (Inquisitive Agency, Xen'drik Expedition, Shadow War, Mournland Salvage, Dragonmarked Intrigue)
- Scene types (investigation, chase, social, combat)
- Scene framing guidance ("Put a Scene On It", TV Test, asking for player intent)
- Bronze Rule applications (airships, locations, organizations)
- The Mourning guidance
- Quick antagonist templates
- Sharn quick reference
- Quick Reference appendix (one-page cheat sheet)

---

## Mode Reference

**Origins** (where you're from/what you are):
- Aundairian, Brelish, Cyran, Karrnathi, Thrane
- Warforged, Changeling, Shifter, Kalashtar

**Backgrounds** (what you did):
- Soldier, Criminal, Scholar, Noble, Entertainer, Outlander, Street Urchin, Dragonmarked Heir

**Callings** (what you do now):
- Inquisitive, Artificer, Mage, Priest, Warrior, Face, Spy, Explorer, Pilot

---

## Writing Style: Anti-Patterns to Avoid

Based on Wikipedia's "Signs of AI Writing." These are the patterns that make text sound machine-generated. Never use them.

### Banned Words/Phrases
Don't use these in prose (occasional use in code comments or technical context is fine):
- **Inflated significance**: "testament," "pivotal," "crucial," "vital role," "significant role," "underscores," "highlights" (as verb), "showcasing," "enduring legacy," "lasting legacy," "setting the stage," "evolving landscape," "deeply rooted," "focal point," "indelible mark"
- **Promotional filler**: "vibrant," "rich" (figurative, e.g. "rich history"), "tapestry" (figurative), "nestled," "in the heart of," "groundbreaking" (figurative), "renowned," "profound," "boasts"
- **Superficial analysis**: "fostering," "cultivating" (figurative), "garner," "delve," "intricate/intricacies," "interplay," "exemplifies," "valuable insights," "aligns with," "resonates with"
- **Filler transitions**: Don't start sentences with "Additionally," "Moreover," or "Furthermore." Use "Also" sparingly. "However" is fine occasionally.
- **Editorializing**: "it's important to note," "worth noting," "it bears mentioning"
- **Section summaries**: "In summary," "In conclusion," "Overall"

### Structural Patterns to Avoid
- **Em dash overuse**: Use colons, periods, semicolons, commas, or parentheses where they're more natural. Em dashes are fine for parenthetical asides and definition lists, but shouldn't be the default connector for everything.
- **"Serves as" / "stands as"**: Just use "is."
- **Negative parallelisms**: "Not only X, but Y" and "It's not just X, it's Y" patterns.
- **Rule of three**: Don't reflexively list things in threes ("adjective, adjective, and adjective").
- **Elegant variation**: Don't use synonyms just to avoid repeating a word. Repeating is fine.
- **"Despite its... faces challenges"**: The formulaic challenges-and-future-outlook structure.
- **False ranges**: "From X to Y" where X and Y aren't on any meaningful scale.
- **Superficial -ing clauses**: Don't tack "highlighting the..." or "reflecting the..." onto the end of sentences.
- **Bold-colon lists**: Fine for reference material (stat blocks, skill lists), but write prose as prose.

### What Good Writing Looks Like
- Use "is" and "are" instead of fancy substitutes
- Vary punctuation (colons, semicolons, periods, commas, parentheses) instead of defaulting to em dashes
- Make specific, concrete statements instead of inflated generalities
- If a sentence would work without a clause, cut the clause
- Let facts speak for themselves without editorializing their significance

---

## Potential Future Work

If Ryan wants to expand:

1. **Additional modes**: Could add more national origins (Darguun, Droaam, Lhazaar), more specialized callings

2. **Aberrant dragonmarks**: Currently not detailed. Could add aspects/stunts for aberrant marks with appropriate drawbacks.

3. **Specific campaign starters**: Detailed first sessions for each campaign framework

4. **Faction relationship mechanics**: More structured rules for tracking standing with organizations (currently just suggested aspects)

5. **Airship/vehicle rules**: More detailed chase/travel mechanics

---

## Session History

### Session 1
- Explored repo structure
- Deleted HTML and build tooling
- Created Eberron Setting Guide
- Switched remote to Keybase
- Created original CLAUDE_NOTES.md

### Session 2
- Designed full mode-based character creation system
- Created Player's Guide with all modes, dragonmarks, magic rules
- Created GM's Guide with adversaries, factions, campaigns
- Removed all Fate SRD files (repo now Eberron-only)
- Updated README
- Rewrote CLAUDE_NOTES.md

### Session 3
- Added Play Example document with 5 iconic PCs and full scene
- Fixed various inconsistencies (Kaela example math, airship skills, timeline)
- Added Pilot calling and Drive skill
- Documented stunt balance philosophy
- Clarified that skill substitution stunts don't need usage limits
- Added zone attack rules (invoke for area targeting instead of +2)
- Added custom mode creation rules
- Added suggested stunts to all modes
- Changed skill cap from Great (+4) to Superb (+5)

### Session 4
- Rewrote GM's Guide adversary section using Fate Adversary Toolkit categories
- Added Threats (one-hit opposition), Fillers (grouped with shared stress), Hitters (dangerous individuals), Bosses (major antagonists with boss features)
- Added Obstacles (blocks, hazards, distractions) and Constraints sections
- Added Countdowns with examples (ritual completion, collapsing ruin, airship going down)
- Reorganized Quick Antagonist Templates by adversary type
- Added boss stat blocks (Lord of Blades, Emerald Claw Commander, Daelkyr Cultist Champion, Chamber Dragon)
- Added Quick Build Reference table

### Session 5
- Added Spellcasting section to Player's Guide (magic as actions, signature spell stunts)
- Fixed dual stress track inconsistencies (character sheet, sample character, play example all showed single track)
- Changed "Cybernetic Arm" example to "Warforged Veteran"
- Merged Academics skill into Lore (wide magic setting)
- Added "What Is Fate?" intro for newcomers
- Added Session Zero guidance to GM's Guide
- Added Quick Reference appendix (one-page cheat sheet)
- Added Scale system for mythic entities
- Added Full Defense optional rule
- Added scene framing guidance from Book of Hanz ("Put a Scene On It", TV Test, asking player intent)
- Added aspect-writing guidance (five functions: permission, awesome, complications, setting)
- Added non-violent attacks section from Atomic Robo

**Key Sources Added This Session:**
- Book of Hanz (fiction-first philosophy, scene framing, aspect guidance)
- Atomic Robo RPG (non-violent attacks, modes inspiration)
- Venture City (stunt-based powers for spell design)

---

*Last updated: Session 5*
