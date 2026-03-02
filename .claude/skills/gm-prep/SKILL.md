---
name: gm-prep
description: Use when preparing a Fate of Eberron session — generates case hooks, builds NPCs, plans scenes, creates complications and countdown clocks, and suggests compels. Reads and writes campaign files.
---

# GM Prep — Session Preparation

Prepare for an upcoming Fate of Eberron session. Reads campaign state, generates content, and writes new material to campaign files (with approval).

## How to Use

Invoke `/gm-prep` before a session. Optionally pass context about what you want:

$ARGUMENTS

## Step 1: Load Campaign Context

Read these files to understand current state:
- `campaign/state.md` — active cases, party status, faction heat
- `campaign/clues.md` — what the PCs know, open threads
- `campaign/npcs.md` — active NPCs
- `campaign/factions.md` — faction agendas and recent moves
- `campaign/sessions/` — most recent 1-2 session summaries (if any)

Also read relevant sections of `gm-guide.md` for adversary templates, scene types, and compel patterns.

If `campaign/` doesn't exist or is empty, tell the user and offer to initialize it from `campaign.md` and `gm-guide.md`.

## Step 2: Ask What Kind of Session

If the user didn't specify, ask:

"What kind of session are you prepping for?"
- **Investigation-heavy**: New case or continuing a mystery thread
- **Action-heavy**: Chase, combat, heist, or escape
- **Social**: Political maneuvering, faction negotiation, underworld dealing
- **Mixed**: Typical session with investigation leading to action
- **Continuing from last session**: Pick up where we left off

One question only. If they gave enough context in their invocation, skip this.

## Step 3: Generate Session Prep

Generate the following, tailored to the session type:

### Case Hook (if starting a new case)

A case hook has:
- **The Client**: Who comes to the agency, what they want, what they're not telling
- **The Real Problem**: What's actually going on (the PCs discover this through play)
- **Factions Involved**: Which factions have a stake, what they want
- **Opening Scene**: Where the case starts, first scene aspects

Connect to existing threads when possible. Check `campaign/clues.md` for loose ends.

### NPCs Needed

Build stat blocks for NPCs who'll appear this session. Use the adversary template format from `gm-guide.md`:
- Threats for mooks
- Fillers for squads
- Hitters for named enemies
- Bosses only if this is a climactic session

Include non-combat NPCs too (witnesses, clients, contacts) — they just need a name, aspect, and hook.

### Scene Plan

Plan 3-4 scenes with:
- **Type**: Investigation, chase, social, combat
- **Location**: Where in Sharn (ward, district, specific place)
- **Scene Aspects**: 2-3 aspects for the location/situation
- **Opposition**: Who or what opposes the PCs
- **Purpose**: What this scene accomplishes in the case
- **Possible Complications**: What could go wrong or get interesting

Scenes should follow the GM's Guide principles: "Put a Scene On It" (establish when/where/who), the "TV Test" (would this scene make it into a TV episode?).

### Countdown Clocks

If there's time pressure, create 1-2 countdowns:
- What fills each box
- What happens when it completes
- How many boxes (3-6)

### Compel Suggestions

For each PC, suggest 1-2 compels based on their aspects that fit this session's themes. Format as ready-to-use prompts:

"Because you're [aspect], it makes sense that [complication]. Accept a fate point?"

## Step 4: Review and Write

Present all generated content. Ask: "Want me to save these NPCs and update the campaign files?"

If yes:
- Add new NPCs to `campaign/npcs.md`
- Update `campaign/factions.md` if factions made moves
- Add new locations to `campaign/locations.md`
- Show each file change before writing

## Optional: Read Aloud

If the user wants to hear how flavor text sounds, use the TTS command from CLAUDE.md to read case hook narration or scene-setting descriptions aloud.
