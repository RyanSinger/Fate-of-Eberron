#!/usr/bin/env bash
# Smoke tests for gm-prep skill

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
source "$SCRIPT_DIR/lib/helpers.sh"

section "Smoke Tests (gm-prep)"

# Test 1: Investigation session
set +e
output=$(run_claude "Use gm-prep. Session type: investigation. Generate a case hook involving House Tarkanan and aberrant dragonmarks in Lower Dura. Include NPCs with stat blocks and scene plans. Do not write any files." 180)
rc=$?
set -e
name="gm-prep #1: Investigation session (House Tarkanan)"
if [ $rc -ne 0 ]; then
  fail "$name" "claude -p failed or timed out"
else
  errors=""
  if ! assert_contains_any "$output" "Tarkanan" "aberrant"; then
    errors="${errors}missing Tarkanan/aberrant terms; "
  fi
  if ! assert_contains_any "$output" "aspect" "skill" "stress" "stunt"; then
    errors="${errors}missing stat block elements; "
  fi
  if ! assert_contains_any "$output" "scene" "plan" "investigation" "clue"; then
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
set +e
output=$(run_claude "Use gm-prep. Session type: action. The party is chasing a Daask smuggler through the Cogs. Generate scene plans with chase zones and a countdown clock. Do not write any files." 180)
rc=$?
set -e
name="gm-prep #2: Action session (Daask chase in Cogs)"
if [ $rc -ne 0 ]; then
  fail "$name" "claude -p failed or timed out"
else
  errors=""
  if ! assert_contains_any "$output" "Daask" "Droaam" "monster"; then
    errors="${errors}missing Daask/Droaam/monster terms; "
  fi
  if ! assert_contains_any "$output" "zone" "chase" "Cogs"; then
    errors="${errors}missing zone/chase/Cogs terms; "
  fi
  if ! assert_contains_any "$output" "countdown" "clock" "complication"; then
    errors="${errors}missing countdown/clock/complication terms; "
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
set +e
output=$(run_claude "Use gm-prep. Session type: social. The party attends a Brelish embassy gala in Upper Central. Generate social NPCs with motivations and compel suggestions. Do not write any files." 180)
rc=$?
set -e
name="gm-prep #3: Social session (Brelish embassy gala)"
if [ $rc -ne 0 ]; then
  fail "$name" "claude -p failed or timed out"
else
  errors=""
  if ! assert_contains_any "$output" "Breland" "Brelish" "gala"; then
    errors="${errors}missing Breland/Brelish/gala terms; "
  fi
  if ! assert_contains_any "$output" "compel" "aspect" "motivation"; then
    errors="${errors}missing compel/aspect/motivation terms; "
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
set +e
output=$(run_claude "Use gm-prep. Session type: mixed, continuing from last session. The party discovered a Mournland artifact that pulses with unstable energy. They need to figure out what it does while Boromar enforcers come looking for it. Generate a full session prep. Do not write any files." 180)
rc=$?
set -e
name="gm-prep #4: Mixed/continuing session (Mournland artifact)"
if [ $rc -ne 0 ]; then
  fail "$name" "claude -p failed or timed out"
else
  errors=""
  if ! assert_contains_any "$output" "Mournland" "Mourning" "artifact"; then
    errors="${errors}missing Mournland/Mourning/artifact terms; "
  fi
  if ! assert_contains_any "$output" "scene" "investigation" "action" "social" "conflict" "chase"; then
    errors="${errors}missing multiple scene type terms; "
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
set +e
output=$(run_claude "Use gm-prep to generate compel suggestions for a character with the aspect 'Haunted by the Day of Mourning' who is investigating an arcane explosion in a Sharn workshop. Give 3 compel suggestions. Do not write any files." 180)
rc=$?
set -e
name="gm-prep #5: Compel suggestions (Haunted by Mourning)"
if [ $rc -ne 0 ]; then
  fail "$name" "claude -p failed or timed out"
else
  errors=""
  if ! assert_contains_any "$output" "Mourning" "haunted"; then
    errors="${errors}missing Mourning/haunted terms; "
  fi
  if ! assert_contains_any "$output" "compel" "fate point" "because"; then
    errors="${errors}missing compel/fate point/because terms; "
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
set +e
output=$(run_claude "Use gm-prep to generate NPCs for a Sharn Watch confrontation: one Watch captain (Hitter), two Watch guards (Fillers), and a bystander witness. Use the adversary template categories from the GM Guide. Do not write any files." 180)
rc=$?
set -e
name="gm-prep #6: NPC generation with adversary categories"
if [ $rc -ne 0 ]; then
  fail "$name" "claude -p failed or timed out"
else
  errors=""
  if ! assert_contains_any "$output" "Watch" "captain" "guard"; then
    errors="${errors}missing Watch/captain/guard terms; "
  fi
  if ! assert_contains_any "$output" "Hitter" "hitter" "Filler" "filler"; then
    errors="${errors}missing Hitter/Filler category terms; "
  fi
  if ! assert_contains_any "$output" "aspect" "skill" "stress"; then
    errors="${errors}missing aspect/skill/stress terms; "
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
