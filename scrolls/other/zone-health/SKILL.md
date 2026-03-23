# Zone Health — DNS Zone Best-Practice Auditing

## What is Zone Health?

A DNS zone health audit evaluates a domain's DNS configuration against best practices, identifying misconfigurations, security gaps, and operational risks. This skill turns raw DNS data from Seer into actionable recommendations.

## Quick Start

```bash
seer dig example.com SOA NS A AAAA MX TXT CNAME CAA
seer dnssec example.com
seer prop example.com A NS
seer status example.com
```

## Reference

- [Audit Checklist](reference/checklist.md) — Full checklist: SOA, NS, A/AAAA, MX, CNAME, TXT, CAA, DNSSEC, TTL consistency
- [Severity & Reporting](reference/severity.md) — Severity classification and audit report template

## Scripts

- [zone-audit.sh](scripts/zone-audit.sh) — Gather all DNS records for zone health analysis
