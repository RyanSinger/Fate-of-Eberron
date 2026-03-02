# GM Skills Testing Implementation Plan

> **For Claude:** REQUIRED SUB-SKILL: Use superpowers:executing-plans to implement this plan task-by-task.

**Goal:** Build an automated test suite for the three GM skills (gm-generate, gm-prep, gm-campaign) with static lint checks and live smoke tests via `claude -p`.

**Architecture:** Two-layer bash test suite. Layer 1 validates skill files and campaign infrastructure structurally (fast, free). Layer 2 invokes each skill via `claude -p`, captures output, and checks for expected patterns (thorough, costs API calls). A shared helper library provides assertion functions and reporting.

**Tech Stack:** Bash, `claude` CLI (`claude -p` for non-interactive invocation), grep/awk for pattern matching.

---

### Task 1: Create Test Helper Library

**Files:**
- Create: `tests/lib/helpers.sh`

**Step 1: Write the helper library**

```bash
#!/usr/bin/env bash
# Test helper library for GM skills test suite

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
NC='\033[0m' # No Color

# Counters
PASS_COUNT=0
FAIL_COUNT=0
SKIP_COUNT=0

# Current test context
CURRENT_SECTION=""

section() {
  CURRENT_SECTION="$1"
  echo ""
  echo -e "--- $1 ---"
}

pass() {
  local name="$1"
  PASS_COUNT=$((PASS_COUNT + 1))
  echo -e "${GREEN}[PASS]${NC} $name"
}

fail() {
  local name="$1"
  local reason="$2"
  FAIL_COUNT=$((FAIL_COUNT + 1))
  echo -e "${RED}[FAIL]${NC} $name"
  if [ -n "$reason" ]; then
    echo -e "       ${RED}↳ $reason${NC}"
  fi
}

skip() {
  local name="$1"
  local reason="$2"
  SKIP_COUNT=$((SKIP_COUNT + 1))
  echo -e "${YELLOW}[SKIP]${NC} $name"
  if [ -n "$reason" ]; then
    echo -e "       ${YELLOW}↳ $reason${NC}"
  fi
}

summary() {
  local total=$((PASS_COUNT + FAIL_COUNT + SKIP_COUNT))
  echo ""
  echo "=== Results: ${PASS_COUNT}/${total} passed, ${FAIL_COUNT} failed, ${SKIP_COUNT} skipped ==="
  if [ "$FAIL_COUNT" -gt 0 ]; then
    return 1
  fi
  return 0
}

# Assertion: output contains a string (case-insensitive)
assert_contains() {
  local output="$1"
  local pattern="$2"
  echo "$output" | grep -qi "$pattern"
}

# Assertion: output contains at least one of the given patterns
assert_contains_any() {
  local output="$1"
  shift
  for pattern in "$@"; do
    if echo "$output" | grep -qi "$pattern"; then
      return 0
    fi
  done
  return 1
}

# Assertion: output word count is within range
assert_word_count() {
  local output="$1"
  local min="$2"
  local max="$3"
  local count
  count=$(echo "$output" | wc -w | tr -d ' ')
  [ "$count" -ge "$min" ] && [ "$count" -le "$max" ]
}

# Assertion: file exists
assert_file_exists() {
  [ -f "$1" ]
}

# Assertion: directory exists
assert_dir_exists() {
  [ -d "$1" ]
}

# Assertion: file contains pattern
assert_file_contains() {
  local file="$1"
  local pattern="$2"
  grep -q "$pattern" "$file" 2>/dev/null
}

# Run a claude -p command with timeout
run_claude() {
  local prompt="$1"
  local timeout="${2:-120}"
  local output
  output=$(timeout "$timeout" claude -p "$prompt" 2>&1)
  local exit_code=$?
  if [ $exit_code -eq 124 ]; then
    echo "TIMEOUT: claude -p did not respond within ${timeout}s"
    return 1
  fi
  echo "$output"
  return $exit_code
}

# Get the project root (parent of tests/)
PROJECT_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)"
```

**Step 2: Verify the helper library is syntactically valid**

Run: `bash -n tests/lib/helpers.sh`
Expected: No output (no syntax errors)

**Step 3: Commit**

```bash
git add tests/lib/helpers.sh
git commit -m "Add test helper library with assertion functions and reporting"
```

---

### Task 2: Create Test Fixtures

**Files:**
- Create: `tests/fixtures/state.md`
- Create: `tests/fixtures/npcs.md`
- Create: `tests/fixtures/factions.md`
- Create: `tests/fixtures/clues.md`
- Create: `tests/fixtures/locations.md`
- Create: `tests/fixtures/sessions/001.md`

**Step 1: Write all fixture files**

`tests/fixtures/state.md`:

```markdown
# Campaign State

**Campaign**: Sharn Inquisitives
**Current Date**: 10 Olarune 998 YK
**Status**: Active

## Active Cases

### The Cliffside Shipments
- **Client**: Merrix d'Cannith (South)
- **Hook**: Khyber dragonshards are being smuggled through Cliffside docks, bypassing House Cannith's normal supply chain
- **Status**: Under investigation
- **Sessions**: 1

## Party

### Investigative Agency: Sharn Eye
- **Tal** (Cyran human, Inquisitive/Mage/Scholar): *Last Survivor of Metrol's Watch*, *The Truth Is Worth Any Price*
- **Brick** (Warforged, Warrior/Soldier/Artificer): *Built for the Last War, Searching for Purpose*, *I Protect Those Who Cannot Protect Themselves*
- **Sera** (Changeling, Face/Spy/Criminal): *A Thousand Faces, One Agenda*, *Haunted by the Day of Mourning*

## Faction Heat

| Faction | Heat | Notes |
|---------|------|-------|
| Boromar Clan | 1 | Investigated their warehouse in Session 1 |
| House Tarkanan | 0 | Not yet aware of the agency |
| Sharn Watch | 0 | Neutral — haven't crossed paths yet |
```

`tests/fixtures/npcs.md`:

```markdown
# NPC Roster

### Kira Talan
- **Aspects**: *Boromar Enforcer With a Grudge*, *Nobody Escapes Cliffside*
- **Affiliation**: Boromar Clan
- **Status**: Active
- **Stats**: Hitter — Fight Good (+3), Athletics Fair (+2), Notice Fair (+2). Stress: 3 boxes. Consequence: Mild.
- **Stunt**: *Back-Alley Ambush* — +2 to Fight when attacking from hiding
- **Notes**: Encountered in Session 1 at the Cliffside warehouse. Escaped when the Watch showed up.

### Sgt. Dolom ir'Karrath
- **Aspects**: *By-the-Book Sharn Watch Sergeant*, *Owes a Favor to the Boromars*
- **Affiliation**: Sharn Watch (public), Boromar Clan (compromised)
- **Status**: Active
- **Stats**: Hitter — Rapport Good (+3), Notice Fair (+2), Fight Fair (+2). Stress: 2 boxes.
- **Notes**: Responded to the warehouse disturbance. Seemed eager to close the case quickly.
```

`tests/fixtures/factions.md`:

```markdown
# Faction State

## Active Factions

### Boromar Clan
- **Agenda**: Protect smuggling routes through Cliffside, keep the Watch cooperative
- **Recent Moves**: Kira Talan posted to guard the warehouse. Sgt. Dolom pressured to close investigation.
- **Threat Level**: Moderate — they know someone was snooping

### House Tarkanan
- **Agenda**: Quietly expand into Lower Dura while Boromar is distracted
- **Recent Moves**: None visible yet — operating in the background
- **Threat Level**: Low — not yet engaged with the party

## Reference

### Dragonmarked Houses
- **House Cannith**: Fragmented into three branches, competing to reunify
- **House Deneith**: Expanding mercenary contracts, filling the power vacuum

### Criminal Organizations
- **Daask**: Monster-run organization pushing into Boromar territory

### Secret Powers
- **The Aurum**: Wealthy conspiracy seeking to control Khorvaire through gold
```

`tests/fixtures/clues.md`:

```markdown
# Clue Tracker

## Known

### Khyber Shards at Cliffside
- **Source**: Warehouse search, Session 1
- **Session**: 1
- **Connects to**: Boromar Clan, House Cannith
- **Details**: Crates of unrefined Khyber dragonshards found at a Boromar-controlled warehouse in Cliffside. Shipping manifests showed deliveries from Xen'drik, but the route doesn't match standard House Lyrandar schedules.

### Sgt. Dolom's Suspicious Behavior
- **Source**: Observation during Watch response, Session 1
- **Session**: 1
- **Connects to**: Boromar Clan, Sharn Watch
- **Details**: Dolom arrived fast, tried to shut down the scene, didn't take detailed statements. Sera noticed he exchanged a look with Kira before she fled.

### The Unmarked Ship
- **Source**: Dock records, Session 1
- **Session**: 1
- **Connects to**: Khyber Shards at Cliffside
- **Details**: A ship called the *Gray Tide* made three deliveries in the past month. No House Lyrandar registration. Dock workers said the crew "didn't talk much and paid in platinum."

## Unknown

### The Buyer
- **Details**: Someone is purchasing the Khyber shards in bulk. Merrix d'Cannith suspects a rival branch but doesn't know for certain.

### Tarkanan's Interest
- **Details**: House Tarkanan has been monitoring the Cliffside smuggling operation. They want the shards for their own purposes — powering aberrant dragonmarks.

## Connections

- Khyber Shards → Boromar Clan (smuggling) → Sgt. Dolom (covering it up)
- Gray Tide ship → unknown crew → unknown buyer
- House Cannith hired the agency → Cannith wants the shards → but who's buying them?
```

`tests/fixtures/locations.md`:

```markdown
# Key Locations

### Cliffside Warehouse
- **Ward**: Lower Dura, Cliffside
- **Aspects**: *Boromar Turf — Everyone Knows It*, *Crates Stacked to the Rafters*
- **Notes**: Site of Session 1 investigation. Boromar uses it as a smuggling waypoint.

### The Broken Anchor Tavern
- **Ward**: Lower Dura, Precarious
- **Aspects**: *Dim Everbright Lanterns Flicker Overhead*, *The Barkeep Owes the Boromars*
- **Notes**: Common meeting spot in Lower Dura. Good place to find informants.
```

`tests/fixtures/sessions/001.md`:

```markdown
# Session 1 — The Cliffside Job

**Date**: 2026-02-28
**In-Game Date**: 10 Olarune 998 YK

## What Happened

Merrix d'Cannith (South) hired the Sharn Eye to investigate a disruption in Khyber dragonshard supply. The party tracked shipments to a Boromar-controlled warehouse in Cliffside.

Tal used Lore to identify the shards as unrefined Khyber dragonshards — unusual because they normally come through House Tharashk. Brick stood watch outside while Sera infiltrated disguised as a dock worker.

Inside, Sera found crates of shards and shipping manifests from the *Gray Tide*, an unregistered vessel. Kira Talan, a Boromar enforcer, caught Sera snooping and a fight broke out. Brick crashed through the loading door. The Watch arrived before the party could capture Kira — led by Sgt. Dolom, who seemed very interested in shutting the investigation down.

## Key Decisions

- The party chose to investigate the warehouse directly rather than stake it out (aggressive approach)
- Sera kept copies of the shipping manifests rather than handing them to Dolom

## NPCs Encountered

- **Kira Talan**: Boromar enforcer. Fought the party, escaped when Watch arrived.
- **Sgt. Dolom ir'Karrath**: Watch sergeant, suspiciously eager to close the case.

## Clues Discovered

- Khyber shards being smuggled through Cliffside
- The *Gray Tide* — unregistered ship making deliveries
- Dolom exchanged a look with Kira before she fled

## Faction Moves

- **Boromar Clan**: Now aware someone is investigating their Cliffside operation
- **Sharn Watch**: Dolom filed a "resolved" report on the warehouse incident

## Open Threads

- Who is buying the Khyber shards?
- What is the *Gray Tide* and who crews it?
- How deep does Dolom's Boromar connection go?
- Why Khyber shards specifically? What are they for?

## Fate Point Economy

- Sera compelled on *A Thousand Faces, One Agenda* — couldn't resist stealing the manifests rather than just reading them (risked getting caught)
- Tal invoked *The Truth Is Worth Any Price* to push past a warded door
- Brick used a free invoke on *Built for the Last War* for the dramatic entrance
```

**Step 2: Verify all fixture files exist**

Run: `ls -la tests/fixtures/ && ls -la tests/fixtures/sessions/`
Expected: All 6 files present

**Step 3: Commit**

```bash
git add tests/fixtures/
git commit -m "Add test fixtures with populated campaign data for smoke tests"
```

---

### Task 3: Write Lint Tests

**Files:**
- Create: `tests/lint.sh`

**Step 1: Write the lint test script**

```bash
#!/usr/bin/env bash
# Static lint tests for GM skill files and campaign infrastructure

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
source "$SCRIPT_DIR/lib/helpers.sh"

echo "=== GM Skills Lint Tests ==="

# --- Skill File Checks ---

section "Skill File Structure"

for skill in gm-generate gm-prep gm-campaign; do
  skill_file="$PROJECT_ROOT/.claude/skills/$skill/SKILL.md"

  # Check 1: File exists
  if assert_file_exists "$skill_file"; then
    pass "$skill: SKILL.md exists"
  else
    fail "$skill: SKILL.md exists" "File not found at $skill_file"
    continue  # Skip remaining checks for this skill
  fi

  # Check 2: Valid YAML frontmatter
  if head -1 "$skill_file" | grep -q "^---$"; then
    if grep -q "^name:" "$skill_file" && grep -q "^description:" "$skill_file"; then
      pass "$skill: valid YAML frontmatter"
    else
      fail "$skill: valid YAML frontmatter" "Missing name: or description: field"
    fi
  else
    fail "$skill: valid YAML frontmatter" "File does not start with ---"
  fi

  # Check 3: Contains expected sections
  case "$skill" in
    gm-generate)
      if assert_file_contains "$skill_file" "## Generation Types" && \
         assert_file_contains "$skill_file" "### Stat Blocks" && \
         assert_file_contains "$skill_file" "## Output Format"; then
        pass "$skill: contains expected sections"
      else
        fail "$skill: contains expected sections" "Missing Generation Types, Stat Blocks, or Output Format"
      fi
      ;;
    gm-prep)
      if assert_file_contains "$skill_file" "## Step 1: Load Campaign Context" && \
         assert_file_contains "$skill_file" "## Step 3: Generate Session Prep" && \
         assert_file_contains "$skill_file" "## Step 4: Review and Write"; then
        pass "$skill: contains expected sections"
      else
        fail "$skill: contains expected sections" "Missing Step 1, Step 3, or Step 4 sections"
      fi
      ;;
    gm-campaign)
      if assert_file_contains "$skill_file" "## Session Summary" && \
         assert_file_contains "$skill_file" "## NPC Updates" && \
         assert_file_contains "$skill_file" "## Campaign State Review"; then
        pass "$skill: contains expected sections"
      else
        fail "$skill: contains expected sections" "Missing Session Summary, NPC Updates, or Campaign State Review"
      fi
      ;;
  esac
done

# Check 4: Referenced project files exist
section "Referenced Files"

referenced_files=(
  "gm-guide.md"
  "campaign/state.md"
  "campaign/npcs.md"
  "campaign/factions.md"
  "campaign/clues.md"
  "campaign/locations.md"
)

for ref_file in "${referenced_files[@]}"; do
  if assert_file_exists "$PROJECT_ROOT/$ref_file"; then
    pass "Referenced file exists: $ref_file"
  else
    fail "Referenced file exists: $ref_file" "Not found at $PROJECT_ROOT/$ref_file"
  fi
done

# --- Campaign Template Checks ---

section "Campaign Infrastructure"

# Check 5: Campaign directory structure
for campaign_file in state.md npcs.md factions.md clues.md locations.md; do
  if assert_file_exists "$PROJECT_ROOT/campaign/$campaign_file"; then
    pass "Campaign file exists: $campaign_file"
  else
    fail "Campaign file exists: $campaign_file" "Not found"
  fi
done

if assert_dir_exists "$PROJECT_ROOT/campaign/sessions"; then
  pass "Campaign sessions directory exists"
else
  fail "Campaign sessions directory exists" "Not found"
fi

# Check 6: Campaign excluded from Jekyll build
if assert_file_contains "$PROJECT_ROOT/_config.yml" "campaign"; then
  pass "Campaign directory excluded from Jekyll build"
else
  fail "Campaign directory excluded from Jekyll build" "_config.yml doesn't reference campaign in excludes"
fi

# Check 7: Template files contain format comments
for campaign_file in npcs.md clues.md locations.md; do
  if assert_file_contains "$PROJECT_ROOT/campaign/$campaign_file" "<!-- Format:"; then
    pass "Format guide comment in campaign/$campaign_file"
  else
    fail "Format guide comment in campaign/$campaign_file" "Missing <!-- Format: comment"
  fi
done

# --- Cross-Reference Checks ---

section "Cross-References"

# Check 8: Adversary categories in gm-guide.md
gm_guide="$PROJECT_ROOT/gm-guide.md"
if assert_file_exists "$gm_guide"; then
  missing_categories=""
  for category in Threat Filler Hitter Boss; do
    if ! assert_file_contains "$gm_guide" "$category"; then
      missing_categories="$missing_categories $category"
    fi
  done
  if [ -z "$missing_categories" ]; then
    pass "GM Guide contains all adversary categories (Threat, Filler, Hitter, Boss)"
  else
    fail "GM Guide contains all adversary categories" "Missing:$missing_categories"
  fi
else
  skip "GM Guide adversary categories" "gm-guide.md not found"
fi

# Check 9: Dragonmark houses cross-reference
players_guide="$PROJECT_ROOT/players-guide.md"
if assert_file_exists "$players_guide"; then
  missing_houses=""
  for house in Cannith Deneith Medani Phiarlan Thuranni; do
    if ! assert_file_contains "$players_guide" "$house"; then
      missing_houses="$missing_houses $house"
    fi
  done
  if [ -z "$missing_houses" ]; then
    pass "Player's Guide contains key Dragonmarked Houses"
  else
    fail "Player's Guide contains key Dragonmarked Houses" "Missing:$missing_houses"
  fi
else
  skip "Dragonmarked Houses cross-reference" "players-guide.md not found"
fi

summary
```

**Step 2: Make it executable and run it**

Run: `chmod +x tests/lint.sh && bash tests/lint.sh`
Expected: All tests PASS (the project structure is intact)

**Step 3: Commit**

```bash
git add tests/lint.sh
git commit -m "Add lint tests for GM skill files and campaign infrastructure"
```

---

### Task 4: Write Smoke Tests — gm-generate

**Files:**
- Create: `tests/smoke-generate.sh`

**Step 1: Write the gm-generate smoke test script**

```bash
#!/usr/bin/env bash
# Smoke tests for gm-generate skill

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
source "$SCRIPT_DIR/lib/helpers.sh"

section "Smoke Tests (gm-generate)"

# Test 1: Threat stat block
output=$(run_claude "Use gm-generate to create a Threat stat block for a Karrnathi undead soldier. Output the stat block only, no other commentary." 120)
name="gm-generate #1: Karrnathi undead Threat stat block"
if [ $? -ne 0 ]; then
  fail "$name" "claude -p failed or timed out"
else
  errors=""
  if ! assert_contains "$output" "aspect"; then
    errors="${errors}missing aspects; "
  fi
  if ! assert_contains_any "$output" "weapon" "attack" "fight" "rating"; then
    errors="${errors}missing attack/weapon rating; "
  fi
  if ! assert_contains_any "$output" "Karrnath" "undead" "zombie" "skeleton"; then
    errors="${errors}missing Karrnath/undead terms; "
  fi
  if ! assert_word_count "$output" 30 500; then
    errors="${errors}word count out of range; "
  fi
  if [ -z "$errors" ]; then
    pass "$name"
  else
    fail "$name" "$errors"
  fi
fi

# Test 2: Boss stat block
output=$(run_claude "Use gm-generate to create a Boss stat block for a Lord of Dust rakshasa operating in Sharn. Output the stat block only." 120)
name="gm-generate #2: Lord of Dust Boss stat block"
if [ $? -ne 0 ]; then
  fail "$name" "claude -p failed or timed out"
else
  errors=""
  if ! assert_contains "$output" "aspect"; then
    errors="${errors}missing aspects; "
  fi
  if ! assert_contains_any "$output" "stress" "consequence"; then
    errors="${errors}missing stress/consequences; "
  fi
  if ! assert_contains_any "$output" "stunt" "feature"; then
    errors="${errors}missing stunts/features; "
  fi
  if ! assert_contains_any "$output" "rakshasa" "overlord" "Khyber" "Lord" "Dust"; then
    errors="${errors}missing Eberron terms; "
  fi
  if ! assert_word_count "$output" 80 800; then
    errors="${errors}word count out of range; "
  fi
  if [ -z "$errors" ]; then
    pass "$name"
  else
    fail "$name" "$errors"
  fi
fi

# Test 3: Scene aspects
output=$(run_claude "Use gm-generate to create scene aspects for a Sharn skybridge chase at night. Just the aspects, nothing else." 120)
name="gm-generate #3: Sharn skybridge scene aspects"
if [ $? -ne 0 ]; then
  fail "$name" "claude -p failed or timed out"
else
  errors=""
  if ! assert_contains_any "$output" "Sharn" "skybridge" "bridge" "tower"; then
    errors="${errors}missing Sharn/skybridge terms; "
  fi
  if ! assert_word_count "$output" 10 300; then
    errors="${errors}word count out of range; "
  fi
  if [ -z "$errors" ]; then
    pass "$name"
  else
    fail "$name" "$errors"
  fi
fi

# Test 4: Compel ideas
output=$(run_claude "Use gm-generate to suggest compels for a PC with the aspect 'Last Heir of House Cannith'. Give 2-3 compel suggestions." 120)
name="gm-generate #4: Compel ideas for House Cannith heir"
if [ $? -ne 0 ]; then
  fail "$name" "claude -p failed or timed out"
else
  errors=""
  if ! assert_contains_any "$output" "Cannith" "heir" "house"; then
    errors="${errors}missing Cannith terms; "
  fi
  if ! assert_contains_any "$output" "compel" "fate point" "because" "it makes sense" "it would make sense"; then
    errors="${errors}missing compel format language; "
  fi
  if ! assert_word_count "$output" 30 500; then
    errors="${errors}word count out of range; "
  fi
  if [ -z "$errors" ]; then
    pass "$name"
  else
    fail "$name" "$errors"
  fi
fi

# Test 5: Countdown clock
output=$(run_claude "Use gm-generate to create a countdown clock for a Mourning anniversary event threatening Sharn. Include boxes, triggers, and what happens when it fills." 120)
name="gm-generate #5: Mourning anniversary countdown clock"
if [ $? -ne 0 ]; then
  fail "$name" "claude -p failed or timed out"
else
  errors=""
  if ! assert_contains_any "$output" "Mourning" "Mournland" "mourning"; then
    errors="${errors}missing Mourning references; "
  fi
  if ! assert_contains_any "$output" "box" "clock" "countdown" "fill" "trigger" "step"; then
    errors="${errors}missing countdown format terms; "
  fi
  if ! assert_word_count "$output" 40 500; then
    errors="${errors}word count out of range; "
  fi
  if [ -z "$errors" ]; then
    pass "$name"
  else
    fail "$name" "$errors"
  fi
fi

# Test 6: Chase zones
output=$(run_claude "Use gm-generate to create 3 chase zones through the Cogs district of Sharn. Each zone needs a name, aspect, and obstacle." 120)
name="gm-generate #6: Cogs chase zones"
if [ $? -ne 0 ]; then
  fail "$name" "claude -p failed or timed out"
else
  errors=""
  if ! assert_contains_any "$output" "Cogs" "cog" "forge" "foundry" "lava" "steam"; then
    errors="${errors}missing Cogs flavor; "
  fi
  if ! assert_contains_any "$output" "aspect" "obstacle" "hazard"; then
    errors="${errors}missing zone structure terms; "
  fi
  if ! assert_word_count "$output" 50 600; then
    errors="${errors}word count out of range; "
  fi
  if [ -z "$errors" ]; then
    pass "$name"
  else
    fail "$name" "$errors"
  fi
fi

# Test 7: NPC name and hook
output=$(run_claude "Use gm-generate to create a throwaway NPC — a Brelish spy working in Sharn. Just a name, one aspect, and a one-sentence hook." 120)
name="gm-generate #7: Brelish spy NPC"
if [ $? -ne 0 ]; then
  fail "$name" "claude -p failed or timed out"
else
  errors=""
  if ! assert_contains_any "$output" "Breland" "Brelish" "spy" "Lantern" "intelligence"; then
    errors="${errors}missing Brelish/spy terms; "
  fi
  if ! assert_word_count "$output" 10 300; then
    errors="${errors}word count out of range; "
  fi
  if [ -z "$errors" ]; then
    pass "$name"
  else
    fail "$name" "$errors"
  fi
fi
```

**Step 2: Make it executable and do a syntax check**

Run: `chmod +x tests/smoke-generate.sh && bash -n tests/smoke-generate.sh`
Expected: No syntax errors

**Step 3: Commit**

```bash
git add tests/smoke-generate.sh
git commit -m "Add smoke tests for gm-generate skill (7 scenarios)"
```

---

### Task 5: Write Smoke Tests — gm-prep

**Files:**
- Create: `tests/smoke-prep.sh`

**Step 1: Write the gm-prep smoke test script**

```bash
#!/usr/bin/env bash
# Smoke tests for gm-prep skill

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
source "$SCRIPT_DIR/lib/helpers.sh"

section "Smoke Tests (gm-prep)"

# Test 1: Investigation session
output=$(run_claude "Use gm-prep. Session type: investigation. Generate a case hook involving House Tarkanan and aberrant dragonmarks in Lower Dura. Include NPCs with stat blocks and scene plans. Do not write any files." 180)
name="gm-prep #1: Investigation session with House Tarkanan"
if [ $? -ne 0 ]; then
  fail "$name" "claude -p failed or timed out"
else
  errors=""
  if ! assert_contains_any "$output" "Tarkanan" "aberrant" "dragonmark"; then
    errors="${errors}missing Tarkanan/aberrant terms; "
  fi
  if ! assert_contains_any "$output" "aspect" "skill" "stress" "stunt"; then
    errors="${errors}missing stat block elements; "
  fi
  if ! assert_contains_any "$output" "scene" "investigation" "location"; then
    errors="${errors}missing scene plan elements; "
  fi
  if ! assert_word_count "$output" 100 3000; then
    errors="${errors}word count out of range; "
  fi
  if [ -z "$errors" ]; then
    pass "$name"
  else
    fail "$name" "$errors"
  fi
fi

# Test 2: Action session
output=$(run_claude "Use gm-prep. Session type: action. The party is chasing a Daask smuggler through the Cogs. Generate scene plans with chase zones and a countdown clock. Do not write any files." 180)
name="gm-prep #2: Action session — Daask chase through Cogs"
if [ $? -ne 0 ]; then
  fail "$name" "claude -p failed or timed out"
else
  errors=""
  if ! assert_contains_any "$output" "Daask" "Droaam" "monster" "smuggler"; then
    errors="${errors}missing Daask terms; "
  fi
  if ! assert_contains_any "$output" "zone" "chase" "Cogs"; then
    errors="${errors}missing chase/zone terms; "
  fi
  if ! assert_contains_any "$output" "countdown" "clock" "complication"; then
    errors="${errors}missing countdown/complication; "
  fi
  if ! assert_word_count "$output" 100 3000; then
    errors="${errors}word count out of range; "
  fi
  if [ -z "$errors" ]; then
    pass "$name"
  else
    fail "$name" "$errors"
  fi
fi

# Test 3: Social session
output=$(run_claude "Use gm-prep. Session type: social. The party attends a Brelish embassy gala in Upper Central. Generate social NPCs with motivations and compel suggestions. Do not write any files." 180)
name="gm-prep #3: Social session — Brelish embassy gala"
if [ $? -ne 0 ]; then
  fail "$name" "claude -p failed or timed out"
else
  errors=""
  if ! assert_contains_any "$output" "Breland" "Brelish" "gala" "embassy"; then
    errors="${errors}missing Brelish/gala terms; "
  fi
  if ! assert_contains_any "$output" "compel" "aspect" "motivation"; then
    errors="${errors}missing social elements; "
  fi
  if ! assert_word_count "$output" 100 3000; then
    errors="${errors}word count out of range; "
  fi
  if [ -z "$errors" ]; then
    pass "$name"
  else
    fail "$name" "$errors"
  fi
fi

# Test 4: Mixed/continuing session
output=$(run_claude "Use gm-prep. Session type: mixed, continuing from last session. The party discovered a Mournland artifact that pulses with unstable energy. They need to figure out what it does while Boromar enforcers come looking for it. Generate a full session prep. Do not write any files." 180)
name="gm-prep #4: Mixed session — Mournland artifact"
if [ $? -ne 0 ]; then
  fail "$name" "claude -p failed or timed out"
else
  errors=""
  if ! assert_contains_any "$output" "Mournland" "Mourning" "artifact"; then
    errors="${errors}missing Mournland terms; "
  fi
  if ! assert_contains_any "$output" "scene" "investigation" "combat" "social" "action"; then
    errors="${errors}missing multiple scene types; "
  fi
  if ! assert_word_count "$output" 150 3000; then
    errors="${errors}word count out of range; "
  fi
  if [ -z "$errors" ]; then
    pass "$name"
  else
    fail "$name" "$errors"
  fi
fi

# Test 5: Compel suggestions
output=$(run_claude "Use gm-prep to generate compel suggestions for a character with the aspect 'Haunted by the Day of Mourning' who is investigating an arcane explosion in a Sharn workshop. Give 3 compel suggestions. Do not write any files." 120)
name="gm-prep #5: Compel suggestions for Mourning-haunted character"
if [ $? -ne 0 ]; then
  fail "$name" "claude -p failed or timed out"
else
  errors=""
  if ! assert_contains_any "$output" "Mourning" "haunted" "Day of Mourning"; then
    errors="${errors}missing Mourning terms; "
  fi
  if ! assert_contains_any "$output" "compel" "fate point" "because"; then
    errors="${errors}missing compel format; "
  fi
  if ! assert_word_count "$output" 40 600; then
    errors="${errors}word count out of range; "
  fi
  if [ -z "$errors" ]; then
    pass "$name"
  else
    fail "$name" "$errors"
  fi
fi

# Test 6: NPC generation with adversary categories
output=$(run_claude "Use gm-prep to generate NPCs for a Sharn Watch confrontation: one Watch captain (Hitter), two Watch guards (Fillers), and a bystander witness. Use the adversary template categories from the GM Guide. Do not write any files." 180)
name="gm-prep #6: NPC generation with adversary categories"
if [ $? -ne 0 ]; then
  fail "$name" "claude -p failed or timed out"
else
  errors=""
  if ! assert_contains_any "$output" "Watch" "captain" "guard"; then
    errors="${errors}missing Watch NPC terms; "
  fi
  if ! assert_contains_any "$output" "Hitter" "hitter" "Filler" "filler"; then
    errors="${errors}missing adversary category terms; "
  fi
  if ! assert_contains_any "$output" "aspect" "skill" "stress"; then
    errors="${errors}missing stat block elements; "
  fi
  if ! assert_word_count "$output" 80 2000; then
    errors="${errors}word count out of range; "
  fi
  if [ -z "$errors" ]; then
    pass "$name"
  else
    fail "$name" "$errors"
  fi
fi
```

**Step 2: Make it executable and syntax check**

Run: `chmod +x tests/smoke-prep.sh && bash -n tests/smoke-prep.sh`
Expected: No syntax errors

**Step 3: Commit**

```bash
git add tests/smoke-prep.sh
git commit -m "Add smoke tests for gm-prep skill (6 scenarios)"
```

---

### Task 6: Write Smoke Tests — gm-campaign

**Files:**
- Create: `tests/smoke-campaign.sh`

**Step 1: Write the gm-campaign smoke test script**

```bash
#!/usr/bin/env bash
# Smoke tests for gm-campaign skill

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
source "$SCRIPT_DIR/lib/helpers.sh"

section "Smoke Tests (gm-campaign)"

# Test 1: Session summary
output=$(run_claude "Use gm-campaign to write a session summary for Session 2. Here's what happened: The party followed up on the Gray Tide lead from Session 1. They went to the Cliffside docks and bribed a dock worker who told them the ship is crewed by warforged with no identifying marks. Sera tried to sneak aboard but was spotted by a warforged sentry. A fight broke out on the docks — Brick held off two warforged while Tal used magic to grab the ship's log. They escaped but the Gray Tide departed immediately. The log is written in an encoded cipher. Compels: Tal was compelled on 'The Truth Is Worth Any Price' to grab the log instead of retreating safely. Do not write any files, just output the summary." 180)
name="gm-campaign #1: Session summary"
if [ $? -ne 0 ]; then
  fail "$name" "claude -p failed or timed out"
else
  errors=""
  if ! assert_contains_any "$output" "What Happened" "what happened"; then
    errors="${errors}missing What Happened section; "
  fi
  if ! assert_contains_any "$output" "Key Decisions" "key decisions" "Decisions"; then
    errors="${errors}missing Key Decisions section; "
  fi
  if ! assert_contains_any "$output" "Clue" "clue" "Discovered"; then
    errors="${errors}missing Clues section; "
  fi
  if ! assert_contains_any "$output" "Open Thread" "open thread" "Thread"; then
    errors="${errors}missing Open Threads section; "
  fi
  if ! assert_contains_any "$output" "Gray Tide" "warforged" "dock" "log" "cipher"; then
    errors="${errors}missing key story details; "
  fi
  if ! assert_word_count "$output" 100 2000; then
    errors="${errors}word count out of range; "
  fi
  if [ -z "$errors" ]; then
    pass "$name"
  else
    fail "$name" "$errors"
  fi
fi

# Test 2: NPC update
output=$(run_claude "Use gm-campaign to update NPC status. Kira Talan (Boromar enforcer) was captured by the party during a second encounter at the Broken Anchor tavern. She's now in party custody and willing to talk if they protect her from the Boromars. Also add a new NPC: a warforged called Anvil, crew of the Gray Tide, Threat-level, fought the party at the docks. Do not write any files, just show the proposed changes." 180)
name="gm-campaign #2: NPC update"
if [ $? -ne 0 ]; then
  fail "$name" "claude -p failed or timed out"
else
  errors=""
  if ! assert_contains_any "$output" "Kira" "Talan"; then
    errors="${errors}missing Kira Talan; "
  fi
  if ! assert_contains_any "$output" "captured" "custody" "status"; then
    errors="${errors}missing status update; "
  fi
  if ! assert_contains_any "$output" "Anvil" "warforged"; then
    errors="${errors}missing new NPC Anvil; "
  fi
  if ! assert_word_count "$output" 50 1500; then
    errors="${errors}word count out of range; "
  fi
  if [ -z "$errors" ]; then
    pass "$name"
  else
    fail "$name" "$errors"
  fi
fi

# Test 3: Faction advancement
output=$(run_claude "Use gm-campaign to advance faction agendas after Session 2. The Boromar Clan is now actively hunting for whoever raided their warehouse — they've put a bounty out. House Tarkanan is quietly making contact with dock workers in Cliffside, moving into the smuggling vacuum. The Gray Tide crew (identity unknown) has left Sharn. Do not write any files, just show the proposed changes." 180)
name="gm-campaign #3: Faction advancement"
if [ $? -ne 0 ]; then
  fail "$name" "claude -p failed or timed out"
else
  errors=""
  if ! assert_contains_any "$output" "Boromar" "bounty" "hunting"; then
    errors="${errors}missing Boromar update; "
  fi
  if ! assert_contains_any "$output" "Tarkanan" "aberrant" "Cliffside"; then
    errors="${errors}missing Tarkanan update; "
  fi
  if ! assert_contains_any "$output" "Gray Tide" "departed" "left"; then
    errors="${errors}missing Gray Tide status; "
  fi
  if ! assert_word_count "$output" 50 1500; then
    errors="${errors}word count out of range; "
  fi
  if [ -z "$errors" ]; then
    pass "$name"
  else
    fail "$name" "$errors"
  fi
fi

# Test 4: Clue tracker update
output=$(run_claude "Use gm-campaign to update the clue tracker after Session 2. The party now knows: the Gray Tide is crewed by unmarked warforged, and they have the ship's log but it's in cipher. Unknown: who built or commands the warforged crew, what the cipher decodes to, where the Gray Tide went. Connection: the warforged crew might link to House Cannith (who makes warforged). Do not write any files, just show the proposed changes." 180)
name="gm-campaign #4: Clue tracker update"
if [ $? -ne 0 ]; then
  fail "$name" "claude -p failed or timed out"
else
  errors=""
  if ! assert_contains_any "$output" "Known" "known"; then
    errors="${errors}missing Known section; "
  fi
  if ! assert_contains_any "$output" "Unknown" "unknown"; then
    errors="${errors}missing Unknown section; "
  fi
  if ! assert_contains_any "$output" "warforged" "cipher" "Gray Tide"; then
    errors="${errors}missing key clue details; "
  fi
  if ! assert_word_count "$output" 50 1500; then
    errors="${errors}word count out of range; "
  fi
  if [ -z "$errors" ]; then
    pass "$name"
  else
    fail "$name" "$errors"
  fi
fi

# Test 5: Campaign state review (read-only)
output=$(run_claude "Use gm-campaign to do a campaign state review. Read the campaign files and tell me: what loose threads do we have, what factions are in motion, and what hooks could drive the next session. Do not write any files." 180)
name="gm-campaign #5: Campaign state review"
if [ $? -ne 0 ]; then
  fail "$name" "claude -p failed or timed out"
else
  errors=""
  if ! assert_contains_any "$output" "thread" "hook" "loose" "unresolved" "open"; then
    errors="${errors}missing thread/hook analysis; "
  fi
  if ! assert_contains_any "$output" "faction" "Boromar" "Tarkanan"; then
    errors="${errors}missing faction references; "
  fi
  if ! assert_word_count "$output" 80 2000; then
    errors="${errors}word count out of range; "
  fi
  if [ -z "$errors" ]; then
    pass "$name"
  else
    fail "$name" "$errors"
  fi
fi

# Test 6: Campaign state update
output=$(run_claude "Use gm-campaign to update campaign state. The in-game date advances to 12 Olarune 998 YK. The Cliffside Shipments case is still active. Boromar heat increases to 2. Add a new case thread: 'The Cipher Log' — decoding the Gray Tide's ship log. Do not write any files, just show the proposed changes." 180)
name="gm-campaign #6: Campaign state update"
if [ $? -ne 0 ]; then
  fail "$name" "claude -p failed or timed out"
else
  errors=""
  if ! assert_contains_any "$output" "Olarune" "998" "date"; then
    errors="${errors}missing date update; "
  fi
  if ! assert_contains_any "$output" "heat" "Boromar" "2"; then
    errors="${errors}missing heat update; "
  fi
  if ! assert_contains_any "$output" "Cipher" "cipher" "log" "Log"; then
    errors="${errors}missing new case thread; "
  fi
  if ! assert_word_count "$output" 50 1500; then
    errors="${errors}word count out of range; "
  fi
  if [ -z "$errors" ]; then
    pass "$name"
  else
    fail "$name" "$errors"
  fi
fi
```

**Step 2: Make it executable and syntax check**

Run: `chmod +x tests/smoke-campaign.sh && bash -n tests/smoke-campaign.sh`
Expected: No syntax errors

**Step 3: Commit**

```bash
git add tests/smoke-campaign.sh
git commit -m "Add smoke tests for gm-campaign skill (6 scenarios)"
```

---

### Task 7: Write Test Orchestrator

**Files:**
- Create: `tests/run.sh`
- Create: `tests/smoke.sh`

**Step 1: Write the smoke test dispatcher**

`tests/smoke.sh`:

```bash
#!/usr/bin/env bash
# Dispatches smoke tests — runs all or a specific skill's tests

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
source "$SCRIPT_DIR/lib/helpers.sh"

SKILL="${1:-all}"

case "$SKILL" in
  gm-generate)
    source "$SCRIPT_DIR/smoke-generate.sh"
    ;;
  gm-prep)
    source "$SCRIPT_DIR/smoke-prep.sh"
    ;;
  gm-campaign)
    source "$SCRIPT_DIR/smoke-campaign.sh"
    ;;
  all)
    source "$SCRIPT_DIR/smoke-generate.sh"
    source "$SCRIPT_DIR/smoke-prep.sh"
    source "$SCRIPT_DIR/smoke-campaign.sh"
    ;;
  *)
    echo "Unknown skill: $SKILL"
    echo "Usage: smoke.sh [gm-generate|gm-prep|gm-campaign|all]"
    exit 1
    ;;
esac
```

**Step 2: Write the orchestrator**

`tests/run.sh`:

```bash
#!/usr/bin/env bash
# GM Skills Test Suite — orchestrator
#
# Usage:
#   ./tests/run.sh              # Full suite (lint + smoke)
#   ./tests/run.sh --lint-only  # Structural checks only
#   ./tests/run.sh --skill gm-generate  # One skill's smoke tests

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

LINT_ONLY=false
SKILL="all"

while [[ $# -gt 0 ]]; do
  case "$1" in
    --lint-only)
      LINT_ONLY=true
      shift
      ;;
    --skill)
      SKILL="$2"
      shift 2
      ;;
    *)
      echo "Unknown option: $1"
      echo "Usage: run.sh [--lint-only] [--skill gm-generate|gm-prep|gm-campaign]"
      exit 1
      ;;
  esac
done

echo "=== GM Skills Test Suite ==="
echo ""

# Always run lint tests
bash "$SCRIPT_DIR/lint.sh"
lint_exit=$?

if [ "$LINT_ONLY" = true ]; then
  exit $lint_exit
fi

echo ""

# Check if claude CLI is available
if ! command -v claude &> /dev/null; then
  echo "Error: 'claude' CLI not found in PATH. Smoke tests require claude CLI."
  echo "Run with --lint-only to skip smoke tests."
  exit 1
fi

# Run smoke tests
bash "$SCRIPT_DIR/smoke.sh" "$SKILL"
smoke_exit=$?

# Combined exit
if [ $lint_exit -ne 0 ] || [ $smoke_exit -ne 0 ]; then
  exit 1
fi
exit 0
```

**Step 3: Make both executable and syntax check**

Run: `chmod +x tests/run.sh tests/smoke.sh && bash -n tests/run.sh && bash -n tests/smoke.sh`
Expected: No syntax errors

**Step 4: Commit**

```bash
git add tests/run.sh tests/smoke.sh
git commit -m "Add test orchestrator with lint-only and per-skill options"
```

---

### Task 8: Run Lint Tests and Fix Issues

**Step 1: Run lint tests only**

Run: `bash tests/run.sh --lint-only`
Expected: All PASS. If any fail, fix the underlying issue (not the test).

**Step 2: Commit any fixes**

If fixes were needed:
```bash
git add -A
git commit -m "Fix issues found by lint tests"
```

---

### Task 9: Run Full Smoke Test Suite

**Step 1: Run the full suite**

Run: `bash tests/run.sh 2>&1 | tee tests/results.txt`
Expected: Lint tests all PASS. Smoke tests mostly PASS — some may fail due to LLM output variability. Record results.

**Step 2: Analyze failures**

For any smoke test failures:
- If the test is too strict (pattern doesn't match valid output), loosen the assertion
- If the skill output is genuinely wrong (wrong format, missing Eberron flavor), that's a skill issue to fix separately
- If the LLM didn't invoke the skill at all, check that `claude -p` prompts are clear enough

**Step 3: Iterate on flaky assertions**

Run failing tests individually to see if they're consistently failing or intermittent:
```bash
bash tests/run.sh --skill gm-generate
```

Adjust word count ranges and pattern lists based on actual output. The goal is tests that pass 90%+ of the time when the skill works correctly.

**Step 4: Commit tuned tests**

```bash
git add tests/
git commit -m "Tune smoke test assertions based on initial run results"
```

---

### Task 10: Add tests/ to Jekyll exclude and push

**Step 1: Exclude tests/ from Jekyll build**

Add `tests` to the exclude list in `_config.yml` (it may already be covered by the `docs` exclude, but tests/ is at the root level).

Check if `_config.yml` exclude already covers it. If not, add `- tests` to the exclude list.

**Step 2: Push everything**

```bash
git push
```

**Step 3: Verify remote is up to date**

Run: `git log --oneline -5`
Expected: All test-related commits present.
