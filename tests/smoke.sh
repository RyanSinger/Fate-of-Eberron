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
