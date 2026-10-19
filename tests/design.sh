#!/usr/bin/env bash
# Design system tests: tokens, built site, component includes, raw color audit

set -uo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
PROJECT_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"
source "$SCRIPT_DIR/lib/helpers.sh"

echo "=== Design System Tests ==="

WORK_DIR="$(mktemp -d)"
trap 'rm -rf "$WORK_DIR"' EXIT

section "Unit tests"
for test_file in "$SCRIPT_DIR"/design/unit/*_test.rb; do
  name="$(basename "$test_file" .rb)"
  if ruby "$test_file"; then
    pass "$name"
  else
    fail "$name" "see minitest output above"
  fi
done

section "Site build"
if (cd "$PROJECT_ROOT" && bundle exec jekyll build --quiet -d "$WORK_DIR/site"); then
  pass "jekyll build"
  if SITE_DIR="$WORK_DIR/site" ruby "$SCRIPT_DIR/design/site_test.rb"; then
    pass "site_test"
  else
    fail "site_test" "see minitest output above"
  fi
else
  fail "jekyll build" "bundle exec jekyll build failed"
fi

section "No raw hex colors"
for css in style components handouts; do
  file="$PROJECT_ROOT/assets/css/$css.css"
  if [ ! -f "$file" ]; then
    skip "$css.css" "not created yet"
    continue
  fi
  if hits=$(grep -nE '#[0-9a-fA-F]{3,8}([^0-9a-zA-Z_-]|$)' "$file"); then
    fail "$css.css has no raw hex" "$hits"
  else
    pass "$css.css has no raw hex"
  fi
done

summary
