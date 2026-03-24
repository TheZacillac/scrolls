# Typosquatting Detection — Lookalike Domain Generation & Monitoring

## What is Typosquatting Detection?

Typosquatting exploits typing errors, visual similarity, and cognitive biases to register domains that impersonate legitimate brands. This skill covers the generation techniques attackers use and how to systematically detect, check, and monitor lookalike domains for brand protection.

## Quick Start

```bash
# Check a suspected typosquat
seer avail exampl.com
seer lookup exampl.com
seer status exampl.com

# Bulk check generated candidates
echo -e "exampl.com\nexmple.com\nexaple.com\nexamle.com" > candidates.txt
seer --format json bulk avail candidates.txt
```

## Reference

- [Generation Techniques](reference/techniques.md) — All typosquatting methods: omission, transposition, homoglyphs, bitsquatting, TLD swaps, and more
- [Triage & Monitoring](reference/triage.md) — Risk assessment matrix, investigation workflow, and ongoing monitoring strategy

## Scripts

- [generate-candidates.sh](scripts/generate-candidates.sh) — Generate basic typosquat candidates for a domain label
