#!/usr/bin/env bash
# Inventory all DNS records before migration
# Usage: ./pre-migration-audit.sh example.com

set -euo pipefail

DOMAIN="${1:?Usage: $0 <domain>}"
OUTFILE="${2:-${DOMAIN}-pre-migration.json}"

echo "=== Pre-Migration DNS Audit: ${DOMAIN} ==="
echo "Output: ${OUTFILE}"
echo ""

echo "--- Core Records ---"
seer dig "${DOMAIN}" SOA NS A AAAA MX TXT CNAME CAA --format json | tee "${OUTFILE}"
echo ""

echo "--- www Subdomain ---"
seer dig "www.${DOMAIN}" A AAAA CNAME 2>/dev/null || echo "  No www records"
echo ""

echo "--- Email Authentication ---"
echo "SPF:"
seer dig "${DOMAIN}" TXT --quiet 2>/dev/null | grep -i "spf1" || echo "  No SPF"
echo "DMARC:"
seer dig "_dmarc.${DOMAIN}" TXT --quiet 2>/dev/null || echo "  No DMARC"
echo "DKIM (common selectors):"
for SEL in google selector1 selector2 default s1 s2 k1 fm1; do
  RESULT=$(seer dig "${SEL}._domainkey.${DOMAIN}" TXT --quiet 2>/dev/null || true)
  if [ -n "${RESULT}" ]; then
    echo "  [${SEL}] Found"
  fi
done
echo ""

echo "--- DNSSEC ---"
seer dnssec "${DOMAIN}" 2>/dev/null || echo "  DNSSEC check failed"
echo ""

echo "--- Registration Status ---"
seer lookup "${DOMAIN}" --quiet --fields status,expiry 2>/dev/null || echo "  Lookup failed"
echo ""

echo "=== Audit Complete ==="
echo "Review ${OUTFILE} and verify all records are replicated before migration."
