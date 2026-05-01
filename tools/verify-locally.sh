#!/usr/bin/env bash
#
# verify-locally.sh — one-shot offline verification helper.
#
# Usage:  ./tools/verify-locally.sh path/to/receipt.json YYYY-MM-DD
# Output: PASS / FAIL with details.
#
# Prerequisites: lattiq-verify installed (will be brew-installable at Phase 3
#                as botrite-observe). Until then, see botrite.lattiq.ai for
#                installation instructions.

set -euo pipefail

if [[ $# -ne 2 ]]; then
    echo "Usage: $0 <path/to/receipt.json> <YYYY-MM-DD>"
    exit 2
fi

RECEIPT="$1"
DATE="$2"
REPO_DIR="$(cd "$(dirname "$0")/.." && pwd)"

if [[ ! "$DATE" =~ ^[0-9]{4}-[0-9]{2}-[0-9]{2}$ ]]; then
    echo "Error: <YYYY-MM-DD> required, got: $DATE" >&2
    exit 2
fi

lattiq-verify --receipt "$RECEIPT" --against-merkle "$DATE" --merkle-mirror "$REPO_DIR"
