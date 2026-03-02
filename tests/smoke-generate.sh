#!/usr/bin/env bash
# Smoke tests for gm-generate skill

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
source "$SCRIPT_DIR/lib/helpers.sh"

section "Smoke Tests (gm-generate)"

# Test 1: Threat stat block
set +e
output=$(run_claude "Use gm-generate to create a Threat stat block for a Karrnathi undead soldier. Output the stat block only, no other commentary." 120)
rc=$?
set -e
name="gm-generate #1: Karrnathi undead Threat stat block"
if [ $rc -ne 0 ]; then
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
set +e
output=$(run_claude "Use gm-generate to create a Boss stat block for a Lord of Dust rakshasa operating in Sharn. Output the stat block only." 120)
rc=$?
set -e
name="gm-generate #2: Lord of Dust Boss stat block"
if [ $rc -ne 0 ]; then
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
set +e
output=$(run_claude "Use gm-generate to create scene aspects for a Sharn skybridge chase at night. Just the aspects, nothing else." 120)
rc=$?
set -e
name="gm-generate #3: Sharn skybridge scene aspects"
if [ $rc -ne 0 ]; then
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
set +e
output=$(run_claude "Use gm-generate to suggest compels for a PC with the aspect 'Last Heir of House Cannith'. Give 2-3 compel suggestions." 120)
rc=$?
set -e
name="gm-generate #4: Compel ideas for House Cannith heir"
if [ $rc -ne 0 ]; then
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
set +e
output=$(run_claude "Use gm-generate to create a countdown clock for a Mourning anniversary event threatening Sharn. Include boxes, triggers, and what happens when it fills." 120)
rc=$?
set -e
name="gm-generate #5: Mourning anniversary countdown clock"
if [ $rc -ne 0 ]; then
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
set +e
output=$(run_claude "Use gm-generate to create 3 chase zones through the Cogs district of Sharn. Each zone needs a name, aspect, and obstacle." 120)
rc=$?
set -e
name="gm-generate #6: Cogs chase zones"
if [ $rc -ne 0 ]; then
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
set +e
output=$(run_claude "Use gm-generate to create a throwaway NPC — a Brelish spy working in Sharn. Just a name, one aspect, and a one-sentence hook." 120)
rc=$?
set -e
name="gm-generate #7: Brelish spy NPC"
if [ $rc -ne 0 ]; then
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
