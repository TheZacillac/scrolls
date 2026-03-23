# Email Authentication — SPF, DKIM & DMARC Analysis

## What is Email Authentication?

Email authentication validates that messages sent from a domain are authorized and unaltered. Three DNS-based mechanisms work together: **SPF** (who can send), **DKIM** (message integrity), and **DMARC** (policy tying them together with reporting). Misconfigured email authentication is one of the most common domain security issues.

## Quick Start

```bash
seer dig example.com TXT                           # SPF
seer dig _dmarc.example.com TXT                    # DMARC
seer dig selector1._domainkey.example.com TXT      # DKIM
seer dig example.com MX                            # Mail exchangers (context)
```

## Reference

- [SPF Analysis](reference/spf.md) — Record format, mechanisms, qualifiers, lookup limits, common provider includes
- [DKIM Analysis](reference/dkim.md) — Key records, selectors by provider, validation checks
- [DMARC Analysis](reference/dmarc.md) — Policy tags, alignment, deployment progression
- [Audit Workflow](reference/audit-workflow.md) — Step-by-step validation checklist and ideal configuration

## Scripts

- [check-email-auth.sh](scripts/check-email-auth.sh) — Check all email authentication records for a domain
