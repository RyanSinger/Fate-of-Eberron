# Internal Notes for Claude Sessions

Working notes on this project. No sugarcoating.

---

## Project Status

**What this repo is:** Fate of Eberron—a custom Fate adaptation for running campaigns in the Eberron setting.

**What's in the repo:**
- `docs/markdown/eberron-setting-guide.md` — Lore-only setting primer (no mechanics)
- `docs/markdown/eberron-players-guide.md` — Character creation, modes, stunts, dragonmarks, magic
- `docs/markdown/eberron-gm-guide.md` — Running the game, adversaries, factions, campaigns
- `docs/markdown/eberron-play-example.md` — Full scene with 5 iconic PCs demonstrating gameplay
- `README.md` — Project overview
- `CLAUDE_NOTES.md` — This file

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
- **Default power level**: Great (+5) peak skill, 3 refresh, 3 free stunts
- **Standard stress/consequences** (not conditions system)

### Character Creation: Mode-Based
- Characters pick **3 modes** from a unified list
- Modes rate at Good (+3), Fair (+2), Average (+1)
- Skills within modes: Trained (+0), Focused (+1), Specialized (+2) above mode rating
- Reinforced skills (in multiple modes) get +1 bonus
- Skill cap: Great (+5) at character creation
- Modes organized loosely as Origins, Backgrounds, Callings—but players can pick any 3
- **Custom modes**: Pick 5 thematically coherent skills, add suggested aspects

### Magic System: Hybrid
- **Narrative magic**: Having a magic aspect lets you describe any skill roll as spellcasting
- **Brainstorms**: For major magical research/problem-solving (from Atomic Robo)
- **Invention rules**: For creating magical items (from Atomic Robo)

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
- Adversary building (nameless NPCs, supporting NPCs, main NPCs)
- All major factions as characters with aspects and agendas
- Compel examples for Eberron themes
- Five campaign frameworks (Inquisitive Agency, Xen'drik Expedition, Shadow War, Mournland Salvage, Dragonmarked Intrigue)
- Scene types (investigation, chase, social, combat)
- Bronze Rule applications (airships, locations, organizations)
- The Mourning guidance
- Quick antagonist templates
- Sharn quick reference

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

---

*Last updated: Session 3*
