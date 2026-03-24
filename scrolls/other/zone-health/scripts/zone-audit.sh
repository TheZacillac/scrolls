#!/usr/bin/env bash
# Gather all DNS records for zone health analysis
# Usage: ./zone-audit.sh example.com

set -euo pipefail

DOMAIN="${1:?Usage: $0 <domain>}"

echo "=== Zone Health Audit: ${DOMAIN} ==="
echo "Date: $(date -I)"
echo ""

echo "--- SOA ---"
seer dig "${DOMAIN}" SOA 2>/dev/null || echo "  No SOA record"
echo ""

echo "--- NS ---"
seer dig "${DOMAIN}" NS 2>/dev/null || echo "  No NS records"
echo ""

echo "--- A ---"
seer dig "${DOMAIN}" A 2>/dev/null || echo "  No A records"
echo ""

echo "--- AAAA ---"
seer dig "${DOMAIN}" AAAA 2>/dev/null || echo "  No AAAA records"
echo ""

echo "--- MX ---"
seer dig "${DOMAIN}" MX 2>/dev/null || echo "  No MX records"
echo ""

echo "--- TXT ---"
seer dig "${DOMAIN}" TXT 2>/dev/null || echo "  No TXT records"
echo ""

echo "--- CNAME (www) ---"
seer dig "www.${DOMAIN}" CNAME 2>/dev/null || echo "  No www CNAME record"
echo ""

echo "--- A (www) ---"
seer dig "www.${DOMAIN}" A 2>/dev/null || echo "  No www A record"
echo ""

echo "--- CAA ---"
seer dig "${DOMAIN}" CAA 2>/dev/null || echo "  No CAA records"
echo ""

echo "--- DNSSEC ---"
seer dnssec "${DOMAIN}" 2>/dev/null || echo "  DNSSEC check failed"
echo ""

echo "--- DMARC ---"
seer dig "_dmarc.${DOMAIN}" TXT 2>/dev/null || echo "  No DMARC record"
echo ""

echo "--- Propagation (A) ---"
seer prop "${DOMAIN}" A 2>/dev/null || echo "  Propagation check failed"
echo ""

echo "=== Audit Complete ==="
