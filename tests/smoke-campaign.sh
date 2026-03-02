#!/usr/bin/env bash
# Smoke tests for gm-campaign skill

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
source "$SCRIPT_DIR/lib/helpers.sh"

section "Smoke Tests (gm-campaign)"

# Test 1: Session summary
set +e
output=$(run_claude "Use gm-campaign to write a session summary for Session 2. Here's what happened: The party followed up on the Gray Tide lead from Session 1. They went to the Cliffside docks and bribed a dock worker who told them the ship is crewed by warforged with no identifying marks. Sera tried to sneak aboard but was spotted by a warforged sentry. A fight broke out on the docks — Brick held off two warforged while Tal used magic to grab the ship's log. They escaped but the Gray Tide departed immediately. The log is written in an encoded cipher. Compels: Tal was compelled on 'The Truth Is Worth Any Price' to grab the log instead of retreating safely. Do not write any files, just output the summary." 180)
rc=$?
set -e
name="gm-campaign #1: Session summary"
if [ $rc -ne 0 ]; then
  fail "$name" "claude -p failed or timed out"
else
  errors=""
  if ! assert_contains_any "$output" "What Happened" "what happened" "Summary" "Recap"; then
    errors="${errors}missing What Happened section; "
  fi
  if ! assert_contains_any "$output" "Key Decision" "key decision" "Decision" "Choices"; then
    errors="${errors}missing Key Decisions section; "
  fi
  if ! assert_contains_any "$output" "Clue" "clue" "Discovered" "discovered" "Discovery"; then
    errors="${errors}missing Clue/Discovered section; "
  fi
  if ! assert_contains_any "$output" "Open Thread" "open thread" "Loose End" "loose end" "Unresolved" "Hook"; then
    errors="${errors}missing Open Thread section; "
  fi
  if ! assert_contains_any "$output" "Gray Tide" "warforged" "dock" "log" "cipher"; then
    errors="${errors}missing story details (Gray Tide/warforged/dock/log/cipher); "
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
set +e
output=$(run_claude "Use gm-campaign to update NPC status. Kira Talan (Boromar enforcer) was captured by the party during a second encounter at the Broken Anchor tavern. She's now in party custody and willing to talk if they protect her from the Boromars. Also add a new NPC: a warforged called Anvil, crew of the Gray Tide, Threat-level, fought the party at the docks. Do not write any files, just show the proposed changes." 180)
rc=$?
set -e
name="gm-campaign #2: NPC update"
if [ $rc -ne 0 ]; then
  fail "$name" "claude -p failed or timed out"
else
  errors=""
  if ! assert_contains_any "$output" "Kira" "Talan"; then
    errors="${errors}missing Kira/Talan terms; "
  fi
  if ! assert_contains_any "$output" "captured" "custody" "status" "prisoner"; then
    errors="${errors}missing captured/custody/status terms; "
  fi
  if ! assert_contains_any "$output" "Anvil" "warforged"; then
    errors="${errors}missing Anvil/warforged terms; "
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
set +e
output=$(run_claude "Use gm-campaign to advance faction agendas after Session 2. The Boromar Clan is now actively hunting for whoever raided their warehouse — they've put a bounty out. House Tarkanan is quietly making contact with dock workers in Cliffside, moving into the smuggling vacuum. The Gray Tide crew (identity unknown) has left Sharn. Do not write any files, just show the proposed changes." 180)
rc=$?
set -e
name="gm-campaign #3: Faction advancement"
if [ $rc -ne 0 ]; then
  fail "$name" "claude -p failed or timed out"
else
  errors=""
  if ! assert_contains_any "$output" "Boromar" "bounty" "hunting"; then
    errors="${errors}missing Boromar/bounty/hunting terms; "
  fi
  if ! assert_contains_any "$output" "Tarkanan" "aberrant" "Cliffside"; then
    errors="${errors}missing Tarkanan/aberrant/Cliffside terms; "
  fi
  if ! assert_contains_any "$output" "Gray Tide" "departed" "left"; then
    errors="${errors}missing Gray Tide/departed/left terms; "
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
set +e
output=$(run_claude "Use gm-campaign to update the clue tracker after Session 2. The party now knows: the Gray Tide is crewed by unmarked warforged, and they have the ship's log but it's in cipher. Unknown: who built or commands the warforged crew, what the cipher decodes to, where the Gray Tide went. Connection: the warforged crew might link to House Cannith (who makes warforged). Do not write any files, just show the proposed changes." 180)
rc=$?
set -e
name="gm-campaign #4: Clue tracker update"
if [ $rc -ne 0 ]; then
  fail "$name" "claude -p failed or timed out"
else
  errors=""
  if ! assert_contains_any "$output" "Known" "known" "Confirmed" "confirmed"; then
    errors="${errors}missing Known/known section; "
  fi
  if ! assert_contains_any "$output" "Unknown" "unknown" "Unanswered" "unanswered"; then
    errors="${errors}missing Unknown/unknown section; "
  fi
  if ! assert_contains_any "$output" "warforged" "cipher" "Gray Tide"; then
    errors="${errors}missing warforged/cipher/Gray Tide terms; "
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
set +e
output=$(run_claude "Use gm-campaign to do a campaign state review. Read the campaign files and tell me: what loose threads do we have, what factions are in motion, and what hooks could drive the next session. Do not write any files." 180)
rc=$?
set -e
name="gm-campaign #5: Campaign state review (read-only)"
if [ $rc -ne 0 ]; then
  fail "$name" "claude -p failed or timed out"
else
  errors=""
  if ! assert_contains_any "$output" "thread" "hook" "loose" "unresolved" "open"; then
    errors="${errors}missing thread/hook/loose/unresolved/open terms; "
  fi
  if ! assert_contains_any "$output" "faction" "Boromar" "Tarkanan"; then
    errors="${errors}missing faction/Boromar/Tarkanan terms; "
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
set +e
output=$(run_claude "Use gm-campaign to update campaign state. The in-game date advances to 12 Olarune 998 YK. The Cliffside Shipments case is still active. Boromar heat increases to 2. Add a new case thread: 'The Cipher Log' — decoding the Gray Tide's ship log. Do not write any files, just show the proposed changes." 180)
rc=$?
set -e
name="gm-campaign #6: Campaign state update"
if [ $rc -ne 0 ]; then
  fail "$name" "claude -p failed or timed out"
else
  errors=""
  if ! assert_contains_any "$output" "Olarune" "998" "date"; then
    errors="${errors}missing Olarune/998/date terms; "
  fi
  if ! assert_contains_any "$output" "heat" "Boromar" "2"; then
    errors="${errors}missing heat/Boromar/2 terms; "
  fi
  if ! assert_contains_any "$output" "Cipher" "cipher" "log" "Log"; then
    errors="${errors}missing Cipher/cipher/log/Log terms; "
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
