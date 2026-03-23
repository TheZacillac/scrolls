# DMARC Record Analysis

DMARC policies are published at `_dmarc.<domain>` as a TXT record.

## Record Format

```
_dmarc.example.com. IN TXT "v=DMARC1; p=reject; rua=mailto:dmarc@example.com; ruf=mailto:forensic@example.com; adkim=s; aspf=s; pct=100"
```

## Record Tags

| Tag | Required | Purpose | Values |
|-----|----------|---------|--------|
| `v` | Required | Version | `DMARC1` (must be first tag) |
| `p` | Required | Policy | `none`, `quarantine`, `reject` |
| `sp` | Optional | Subdomain policy | `none`, `quarantine`, `reject` (inherits `p` if absent) |
| `rua` | Optional | Aggregate report URI | `mailto:addr` (comma-separated for multiple) |
| `ruf` | Optional | Forensic report URI | `mailto:addr` |
| `adkim` | Optional | DKIM alignment | `r` (relaxed, default), `s` (strict) |
| `aspf` | Optional | SPF alignment | `r` (relaxed, default), `s` (strict) |
| `pct` | Optional | Policy percentage | `0`–`100` (default: `100`) |
| `ri` | Optional | Report interval | Seconds (default: `86400` / 24h) |
| `fo` | Optional | Failure reporting | `0` (default), `1`, `d`, `s` |

## Policy Progression

The recommended deployment path:

1. **Monitor** — `p=none; rua=mailto:dmarc@example.com` — collect reports, no enforcement
2. **Quarantine partial** — `p=quarantine; pct=25; rua=...` — quarantine 25% of failures
3. **Quarantine full** — `p=quarantine; pct=100; rua=...` — quarantine all failures
4. **Reject** — `p=reject; rua=...` — reject all failures (full protection)

## Alignment

DMARC passes when **at least one** of SPF or DKIM passes **and** aligns:

- **SPF alignment**: The `RFC5321.MailFrom` domain (envelope sender) matches the `RFC5322.From` domain (header From)
  - Relaxed (`aspf=r`): organizational domain match (subdomains OK)
  - Strict (`aspf=s`): exact domain match
- **DKIM alignment**: The `d=` domain in the DKIM signature matches the `RFC5322.From` domain
  - Relaxed (`adkim=r`): organizational domain match
  - Strict (`adkim=s`): exact domain match

## Common Issues

1. **`p=none` indefinitely** — Monitor mode provides no protection. Should be a temporary phase, not permanent.
2. **No `rua` tag** — Without aggregate reporting, you're flying blind. Always collect reports.
3. **`pct` less than 100** — Reduces policy effectiveness. Should be ramped to 100.
4. **Missing subdomain policy** — Without `sp=`, subdomains inherit `p=`. If subdomains don't send mail, `sp=reject` is safest.
5. **External report destination** — If `rua` points to a different domain, that domain must publish an authorization record: `<original-domain>._report._dmarc.<report-domain>. IN TXT "v=DMARC1"`
6. **Relaxed alignment with forwarding** — Relaxed alignment is more forgiving of mailing lists and forwarding, but strict alignment is more secure.
