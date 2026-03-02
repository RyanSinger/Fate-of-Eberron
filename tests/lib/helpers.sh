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

# Run a claude -p command with timeout (portable, no GNU timeout needed)
# Unsets CLAUDECODE to allow nested invocation from within a Claude Code session
run_claude() {
  local prompt="$1"
  local max_time="${2:-120}"
  local tmpfile
  tmpfile=$(mktemp)

  (unset CLAUDECODE; claude -p "$prompt" > "$tmpfile" 2>&1) &
  local pid=$!

  local elapsed=0
  while kill -0 "$pid" 2>/dev/null; do
    if [ "$elapsed" -ge "$max_time" ]; then
      kill "$pid" 2>/dev/null
      wait "$pid" 2>/dev/null
      rm -f "$tmpfile"
      echo "TIMEOUT: claude -p did not respond within ${max_time}s"
      return 1
    fi
    sleep 1
    elapsed=$((elapsed + 1))
  done

  wait "$pid"
  local exit_code=$?
  local output
  output=$(cat "$tmpfile")
  rm -f "$tmpfile"
  echo "$output"
  return $exit_code
}

# Get the project root (parent of tests/)
PROJECT_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)"
