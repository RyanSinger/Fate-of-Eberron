---
name: gm-campaign
description: Use when managing Fate of Eberron campaign state between sessions — writing session summaries, updating NPCs, advancing factions, tracking clues, and reviewing campaign threads.
---

# GM Campaign — Campaign Management

Post-session and between-session bookkeeping for Fate of Eberron. Reads current state, proposes updates, writes with approval.

## How to Use

Invoke `/gm-campaign` with what you need:

$ARGUMENTS

Examples:
- `/gm-campaign write up session 3`
- `/gm-campaign update factions after last session`
- `/gm-campaign what loose threads do we have`
- `/gm-campaign Councilor ir'Tonn is dead, update NPCs`

## Before Any Changes

1. Read all campaign files to understand current state:
   - `campaign/state.md`
   - `campaign/npcs.md`
   - `campaign/factions.md`
   - `campaign/clues.md`
   - `campaign/locations.md`
   - Recent session files in `campaign/sessions/`

2. **Always show proposed changes before writing.** Never write without approval.

## Session Summary

When the user describes what happened in a session, write a summary to `campaign/sessions/NNN.md`:

~~~markdown
# Session N — [Title]

**Date**: [Real-world date]
**In-Game Date**: [Eberron date if tracked]

## What Happened

[Narrative summary of major events, 3-5 paragraphs]

## Key Decisions

- [Decision the PCs made and its consequence]

## NPCs Encountered

- **[Name]**: [What they did, current status]

## Clues Discovered

- [What was learned and from where]

## Faction Moves

- **[Faction]**: [What they did this session, visible or behind the scenes]

## Open Threads

- [Unresolved questions or hooks for future sessions]

## Fate Point Economy

- [Notable compels, invokes, or fate point moments]
~~~

Determine the session number from existing files in `campaign/sessions/`.

## NPC Updates

When the user reports NPC changes:
- Update status (Active, Dead, Missing, Allied, Hostile)
- Add new aspects if they've been revealed
- Update notes with recent events
- Add new NPCs from the session

Show the diff before writing to `campaign/npcs.md`.

## Faction Advances

After a session or between sessions, update faction state:
- What did each active faction do (on-screen or behind the scenes)?
- Has any faction's threat level changed?
- Are any new factions now active?

Move factions from the Reference section to Active in `campaign/factions.md` when they enter play. Add current agenda and recent moves.

## Clue Tracker

Update `campaign/clues.md`:
- Move discovered clues to the Known section
- Add connections between clues
- Note which clues the PCs haven't found yet (for GM reference)
- Track what session each clue was discovered in

## Campaign State Review

When asked "what loose threads do we have" or similar, review all campaign files and present:
- Active cases and their status
- Unresolved clues and possible connections
- Faction agendas in motion
- NPCs the PCs haven't seen in a while
- Potential hooks for future sessions

This is read-only — just analysis and suggestions, no file writes.

## Campaign State Update

After writing a session summary, also update `campaign/state.md`:
- Current in-game date
- Active cases
- Party status (any consequences, resource changes)
- Faction heat table
