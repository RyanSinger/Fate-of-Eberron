---
name: gm-generate
description: Use when the GM needs quick in-play generation for Fate of Eberron — stat blocks, scene aspects, compel ideas, NPC names, complications, chase zones, or countdown clocks. Output only, no file writes.
---

# GM Generate — In-Play Quick Generation

Generate Fate of Eberron content on demand during play. Output to conversation only — no file writes unless explicitly asked.

## How to Use

The user invokes `/gm-generate` with a request. Parse what they need and generate it.

$ARGUMENTS

## Before Generating

1. Read `gm-guide.md` sections relevant to the request (adversary templates for stat blocks, scene types for complications, etc.)
2. If generating for a specific PC (compel ideas), read their character from `campaign/npcs.md` or `campaign/state.md`
3. If generating for a specific faction, check `campaign/factions.md` for current state

## Generation Types

### Stat Blocks

Follow the GM's Guide adversary template format exactly:

**Threat** (mooks, one-hit):
- 1-2 aspects
- Weapon rating (attack bonus)
- No stress track — one hit takes them out
- Group: "When 3+ threats attack together, combine into a single roll at +1 per extra threat"

**Filler** (squads, moderate opposition):
- 2 aspects
- One pointed skill at Fair (+2) or Good (+3)
- Shared stress track (4-6 boxes for the group)
- One mild consequence for the group

**Hitter** (named enemies, real danger):
- 2-3 aspects (high concept + trouble minimum)
- 2-3 pointed skills (peak at Good +3 or Great +4)
- Stress: 2-3 boxes
- Consequences: Mild, sometimes Moderate
- 1 stunt

**Boss** (major antagonists):
- 5 aspects (full spread)
- Skill pyramid (peak at Great +4 or Superb +5)
- Stress: 3-4 boxes (physical and/or mental)
- Consequences: Mild + Moderate + Severe
- 2-3 stunts
- 1+ boss features (extra action, absorption, zone control, lieutenants, recovery, special weakness)

Always include faction affiliation and Eberron-specific flavor. A Daask enforcer isn't just a "thug" — they're an ogre or gnoll with Droaam backing.

### Scene Aspects

Generate 2-3 scene aspects for a location or situation. Aspects should be:
- Invokable by both PCs and NPCs
- Specific to the fiction (not generic "Dark Room")
- Tied to Eberron flavor (magical infrastructure, war aftermath, vertical city)

Example for a lower ward tavern: *Dim Everbright Lanterns Flicker Overhead*, *The Barkeep Owes the Boromars*

### Compel Ideas

Given a PC's aspects, suggest 2-3 compels relevant to the current situation. Format:

"Because you're [aspect], it would make sense that [complication]. Accept a fate point?"

### NPC Names and Hooks

Generate a quick NPC with:
- Name (appropriate to their nation/species)
- One aspect
- One sentence hook (what they want, what they're hiding)

### Investigation Complications

Generate 1-2 complications for an investigation scene:
- Magical interference (warded evidence, altered memories, living spells)
- Social complications (witnesses scared, evidence owned by a House, Watch interference)
- Time pressure (evidence decaying, someone else looking for the same thing)

### Chase Zones

Generate 3-5 zones for a chase through a specific Sharn area. Each zone has:
- Name and brief description
- 1 aspect
- 1 obstacle or hazard

### Countdown Clocks

Generate a countdown with:
- What happens when it fills
- Number of boxes (3-6)
- Trigger (time, action, failure, neglect)
- What fills each box (specific fictional events)

## Output Format

Output in clean markdown, ready to read at the table. No preamble — go straight to the generated content. If the request is ambiguous, ask one clarifying question before generating.

## If Asked to Save

If the user says "save that NPC" or similar, write the NPC to `campaign/npcs.md` following the format in that file. Show the addition before writing.
