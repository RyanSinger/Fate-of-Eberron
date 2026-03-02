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
