#!/usr/bin/env bash
# Generate basic typosquat candidates for a domain label
# Usage: ./generate-candidates.sh example
# Covers: character omission, adjacent transposition, character duplication

set -euo pipefail

LABEL="${1:?Usage: $0 <domain-label> (without TLD, e.g., 'example')}"
TLD="${2:-.com}"

echo "=== Typosquat Candidates for ${LABEL}.${TLD} ==="
echo ""

# Character omission
echo "--- Character Omission ---"
for ((i=0; i<${#LABEL}; i++)); do
  echo "  ${LABEL:0:i}${LABEL:i+1}.${TLD}"
done
echo ""

# Adjacent transposition
echo "--- Adjacent Transposition ---"
for ((i=0; i<${#LABEL}-1; i++)); do
  SWAPPED="${LABEL:0:i}${LABEL:i+1:1}${LABEL:i:1}${LABEL:i+2}"
  if [ "${SWAPPED}" != "${LABEL}" ]; then
    echo "  ${SWAPPED}.${TLD}"
  fi
done
echo ""

# Character duplication
echo "--- Character Duplication ---"
for ((i=0; i<${#LABEL}; i++)); do
  echo "  ${LABEL:0:i+1}${LABEL:i:1}${LABEL:i+1}.${TLD}"
done
echo ""

# TLD swaps
echo "--- TLD Swaps ---"
for ALT_TLD in com net org co io app dev info biz xyz me; do
  if [ "${ALT_TLD}" != "${TLD#.}" ]; then
    echo "  ${LABEL}.${ALT_TLD}"
  fi
done
