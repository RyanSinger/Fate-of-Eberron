# GM Skills — Design Document

## Goal

Build a family of Claude Code skills that help GM a Fate of Eberron campaign: session prep, in-play generation, and campaign management. Eberron-first but structured so the approach could work with other Fate games.

## Campaign Data Structure

Campaign working files live in `campaign/`, separate from the public `campaign.md` page. Excluded from Jekyll build via `_config.yml`.

```
campaign/
├── state.md          # Current date, active cases, faction heat, party status
├── npcs.md           # NPC roster: aspects, affiliations, status, notes
├── factions.md       # Faction state: current agendas, threat levels, recent moves
├── clues.md          # What the PCs know, what they don't, connections between clues
├── locations.md      # Key locations with scene aspects
└── sessions/
    └── NNN.md        # Individual session summaries
```

All files are plain markdown with a consistent heading structure. Example NPC entry:

```markdown
### Councilor Beren ir'Tonn
- **Aspects**: *Sharn Council Member with Dirty Hands*, *The Boromar Clan Owns My Vote*
- **Affiliation**: Sharn Council (public), Boromar Clan (secret)
- **Status**: Active
- **Notes**: Hired the party to investigate a "missing shipment"
```

**Campaign auto-init:** First run of any `gm:` skill creates the directory structure and populates starter content from `campaign.md` and the GM's Guide faction list.

## The Three Skills

### `gm:prep` — Session Preparation

Invoked before a session. Reads campaign state, recent session logs, faction agendas, and active clues.

**What it does:**
- Generate case hooks connecting to existing threads or starting new ones
- Build NPCs with proper Fate stat blocks (following GM's Guide adversary templates)
- Plan 3-4 scenes with scene aspects, opposition, and complications
- Create countdown clocks for time pressure
- Suggest compels for each PC based on their aspects and the session's themes

**Behavior:**
- Asks what kind of session you want (investigation, action, social, mixed)
- Writes new NPCs to `npcs.md`, updates `factions.md` if faction moves are planned
- Can create a session prep outline for reference during play
- Optionally reads flavor text aloud via OpenAI TTS

### `gm:generate` — In-Play Generation

Quick, focused generation for things needed at the table. Output only — no file writes unless explicitly asked.

**What it generates:**
- Stat blocks (any adversary type: threat, filler, hitter, boss)
- Scene aspects for specific locations or situations
- Compel ideas for a specific PC
- NPC names and hooks (quick throwaway NPCs)
- Investigation complications
- Chase zone layouts
- Countdown clocks

**Invocation examples:**
- `/gm:generate stat block for a Daask enforcer hitter`
- `/gm:generate scene aspects for a chase through the Cogs`
- `/gm:generate compel ideas for Kira`

### `gm:campaign` — Campaign Management

Post-session and between-session bookkeeping.

**What it does:**
- Write session summaries (you describe what happened, it structures into `sessions/NNN.md`)
- Update NPC statuses (alive, dead, allied, hostile, missing)
- Advance faction agendas
- Update the clue tracker
- Review campaign state and suggest emerging threads or loose ends

**Behavior:**
- Always reads current state before writing
- Shows proposed changes before committing
- Never writes without approval

## Conventions

**Context loading:** Each skill reads only what it needs. `gm:generate` reads GM's Guide templates and maybe the NPC roster. `gm:prep` reads more broadly. `gm:campaign` focuses on campaign state files.

**Eberron-first, extensible:** Skills reference Eberron content by reading the repo's guide files rather than hardcoding lore. A fork with different guide files would still work.

**Stat block format:** Follows GM's Guide adversary templates exactly. Threats, fillers, hitters, bosses each have their defined format. No invented formats.

**No unsolicited writes:** `gm:generate` outputs to conversation only. `gm:prep` and `gm:campaign` propose changes and show them before writing.

## Out of Scope

- Player-facing tools
- Dice rolling or mechanical resolution
- Web interface (CLI only)
- Automated session logging from conversation history
- Map generation or visual aids
- Rules arbitration
