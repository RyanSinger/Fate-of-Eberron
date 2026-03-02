# GM Skills Testing Design

## Goal

Comprehensive automated testing for the three GM skills (gm-generate, gm-prep, gm-campaign). Two test layers: static lint checks (fast, free) and live smoke tests via `claude -p` (thorough, costs API calls).

## Structure

```
tests/
├── run.sh              # Orchestrator: lint then smoke, reports summary
├── lint.sh             # Static validation of skill files and campaign templates
├── smoke.sh            # Live tests via claude -p
├── fixtures/           # Populated test campaign data
│   ├── state.md
│   ├── npcs.md
│   ├── factions.md
│   ├── clues.md
│   ├── locations.md
│   └── sessions/
│       └── 001.md
└── lib/
    └── helpers.sh      # Shared: assert_contains, assert_word_count, color output, counters
```

## Layer 1: Static Lint Tests (~9 checks)

### Skill file checks (per skill)
1. File exists at `.claude/skills/{name}/SKILL.md`
2. Valid YAML frontmatter (starts with `---`, has `name:` and `description:` fields)
3. Contains expected sections (varies by skill)
4. All referenced project files exist (e.g., `gm-guide.md`, `campaign/state.md`)

### Campaign template checks
5. All campaign files exist (`campaign/state.md`, `npcs.md`, `factions.md`, `clues.md`, `locations.md`, `sessions/`)
6. Campaign directory excluded from Jekyll build (`_config.yml` excludes `campaign/`)
7. Template files contain format-guide HTML comments

### Cross-reference checks
8. Skills reference adversary categories that exist in `gm-guide.md` (Threat, Filler, Hitter, Boss)
9. Dragonmark houses referenced in skills match those in `players-guide.md`

## Layer 2: Smoke Tests (19 scenarios)

Each test invokes `claude -p` with a specific prompt, captures stdout, and checks patterns. 60-second timeout per test. Sequential execution to avoid rate limits.

### Validation helpers
- `assert_contains PATTERN` — output includes a string/regex
- `assert_contains_any PATTERN1 PATTERN2 ...` — output includes at least one
- `assert_word_count MIN MAX` — output length in reasonable range
- `assert_section HEADER` — output has a section matching header pattern

### gm-generate (7 tests)

| # | Scenario | Prompt summary | Checks |
|---|----------|---------------|--------|
| 1 | Threat stat block | Karrnathi undead soldier | Aspects/Skills/Stress/Stunts sections. Karrnath terms. |
| 2 | Boss stat block | Lord of Dust rakshasa | Boss format (multiple stress tracks, consequences). Overlords/Khyber terms. |
| 3 | Scene aspects | Sharn skybridge chase | 2+ aspects. Invokable phrasing. Sharn references. |
| 4 | Compel ideas | "Last Heir of House Cannith" | Compel format (aspect + complication). Cannith specifics. |
| 5 | Countdown clock | Mourning anniversary event | Steps/boxes, fill conditions, completion trigger. Mourning references. |
| 6 | Chase zones | Cogs district of Sharn | 3+ zones with aspects and obstacles. Cogs flavor. |
| 7 | NPC name/hook | Brelish spy | Name, high concept, minimal stats. Breland references. |

### gm-prep (6 tests)

| # | Scenario | Prompt summary | Checks |
|---|----------|---------------|--------|
| 1 | Investigation session | Case involving House Tarkanan | Case hook, NPC with stat block, Tarkanan references. |
| 2 | Action session | Daask smuggler chase through Cogs | Zone encounter, Daask references, countdown/complication. |
| 3 | Social session | Brelish embassy gala | Social NPCs with motivations, compels, scene aspects. |
| 4 | Mixed/continuing | Party found Mournland artifact | References campaign context, multiple scene types. |
| 5 | Compel generation | "Haunted by the Day of Mourning" | Compel format, Mourning complications, 2+ suggestions. |
| 6 | NPC generation | Sharn Watch officer + guards | Multiple NPCs, different adversary categories. |

### gm-campaign (6 tests)

| # | Scenario | Prompt summary | Checks |
|---|----------|---------------|--------|
| 1 | Session summary | Boromar warehouse investigation | Summary format sections, correct names/details from prompt. |
| 2 | NPC update | Kira Talan captured | NPC format, status change reflected. |
| 3 | Faction advancement | Boromar losing to Daask, Tarkanan expanding | Faction format, multiple factions, agenda progression. |
| 4 | Clue tracker update | Khyber shards through Cliffside, unknown buyer | Known/Unknown/Connections format, proper categorization. |
| 5 | Campaign state review | Read-only analysis | Identifies loose threads from fixtures, references active state. |
| 6 | State update | Date advance, case activation, heat table | State format, Eberron calendar, heat table. |

## Scope exclusions

- **No file write validation.** Skills ask for confirmation before writing; `claude -p` has no interactive confirmation. File writing is a Claude Code feature, not skill logic. We test output quality only.
- **No TTS testing.** The OpenAI TTS integration in gm-prep is optional and environment-dependent.

## Fixtures

Minimal but populated test campaign:
- 2 NPCs (Kira Talan — Boromar enforcer, active; Sgt. Dolom — Sharn Watch, active)
- 1 active case (Khyber shard smuggling through Cliffside)
- 2 factions with agendas (Boromar Clan, House Tarkanan)
- 3 known clues, 2 unknown
- 1 session summary (Session 1)
- Campaign date: 10 Olarune 998 YK
- Party: 3 PCs, heat table with Boromar at 1

## Execution

```bash
./tests/run.sh              # Full suite
./tests/run.sh --lint-only  # Structural checks only
./tests/run.sh --skill gm-generate  # One skill's smoke tests
```

## Output format

```
=== GM Skills Test Suite ===

--- Lint Tests ---
[PASS] gm-generate: SKILL.md exists
[PASS] gm-generate: valid YAML frontmatter
[FAIL] gm-prep: references nonexistent file
...

--- Smoke Tests (gm-generate) ---
[PASS] #1 Karrnathi stat block: format OK, Eberron terms OK
[FAIL] #3 Sharn aspects: missing scene aspects
...

=== Results: 17/19 passed, 2 failed ===
```

## Test count

- 9 lint checks
- 7 gm-generate smoke tests
- 6 gm-prep smoke tests
- 6 gm-campaign smoke tests
- **28 tests total**
