#!/usr/bin/env bash
# Check all email authentication records for a domain
# Usage: ./check-email-auth.sh example.com

set -euo pipefail

DOMAIN="${1:?Usage: $0 <domain>}"

echo "=== Email Authentication Check: ${DOMAIN} ==="
echo ""

echo "--- SPF (TXT at apex) ---"
seer dig "${DOMAIN}" TXT --quiet 2>/dev/null | grep -i "spf1" || echo "  No SPF record found"
echo ""

echo "--- MX Records ---"
seer dig "${DOMAIN}" MX 2>/dev/null || echo "  No MX records found"
echo ""

echo "--- DMARC ---"
seer dig "_dmarc.${DOMAIN}" TXT --quiet 2>/dev/null || echo "  No DMARC record found"
echo ""

echo "--- DKIM (common selectors) ---"
for SELECTOR in google selector1 selector2 default s1 s2 k1 fm1 protonmail smtp; do
  RESULT=$(seer dig "${SELECTOR}._domainkey.${DOMAIN}" TXT --quiet 2>/dev/null || true)
  if [ -n "${RESULT}" ]; then
    echo "  [${SELECTOR}] ${RESULT}"
  fi
done
echo ""

echo "=== Done ==="
