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

# Disable errexit around subcommands so we can capture exit codes
set +e

# Always run lint tests
bash "$SCRIPT_DIR/lint.sh"
lint_exit=$?

set -e

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

# Disable errexit around smoke tests too
set +e

# Run smoke tests
bash "$SCRIPT_DIR/smoke.sh" "$SKILL"
smoke_exit=$?

set -e

# Combined exit
if [ $lint_exit -ne 0 ] || [ $smoke_exit -ne 0 ]; then
  exit 1
fi
exit 0
