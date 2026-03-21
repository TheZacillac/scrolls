#!/usr/bin/env bash
# Example seer usage patterns for scripting and automation

set -euo pipefail

# --- Field extraction ---
# Use --quiet with --fields for scriptable output
seer --quiet --fields registrar lookup example.com
seer --quiet --fields certificate.issuer status example.com
seer --quiet --fields available avail example.com
seer --quiet --fields registrar,expires lookup example.com

# --- Bulk operations ---
# Process domains from a file, output to CSV
seer bulk lookup domains.txt
seer bulk status domains.txt -o results.csv

# --- Conditional logic using exit codes ---
if seer avail example.com; then
  echo "example.com is available!"
else
  echo "example.com is taken."
fi

if seer dnssec example.com; then
  echo "DNSSEC is configured."
else
  echo "DNSSEC is NOT configured."
fi

# --- JSON output for piping ---
seer --format json lookup example.com | jq '.registrar'
seer --format json dig example.com MX | jq '.records'

# --- DNS monitoring ---
# Watch for DNS changes (20 checks, 30s apart, only show changes)
seer follow example.com 20 0.5 --changes-only
