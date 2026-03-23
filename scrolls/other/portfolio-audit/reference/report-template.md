# Portfolio Audit Report Template

## Report Format

```
Portfolio Audit Report
Date: YYYY-MM-DD
Domains Audited: N

Portfolio Score: XX/100 (Grade: X)

═══════════════════════════════════════
SUMMARY
═══════════════════════════════════════
  Domains:        N total
  Registration:   N healthy, N warning, N critical
  DNS:            N healthy, N warning, N critical
  SSL:            N healthy, N warning, N critical, N missing
  Email Auth:     N complete, N partial, N missing
  DNSSEC:         N enabled, N disabled

═══════════════════════════════════════
CRITICAL FINDINGS (Immediate Action)
═══════════════════════════════════════
  [!] domain1.com — expires in 3 days, no auto-renew
  [!] domain2.com — SSL certificate expired 2 days ago
  [!] domain3.com — dangling CNAME (subdomain takeover risk)

═══════════════════════════════════════
EXPIRY TIMELINE
═══════════════════════════════════════
  Next 7 days:    domain1.com (2024-04-01)
  Next 30 days:   domain4.com (2024-04-15)
  Next 90 days:   domain5.com (2024-06-01), domain6.com (2024-06-15)

═══════════════════════════════════════
PER-DOMAIN DETAILS
═══════════════════════════════════════
  domain1.com ............... Score: 35/100 (F)
    Registration: ⚠ Expires in 3 days, no registrar lock
    DNS:          ✓ 3 NS, propagation OK
    SSL:          ✓ Valid, 45 days remaining
    Email:        ✗ No SPF, no DMARC
    DNSSEC:       ✗ Not enabled

  domain2.com ............... Score: 72/100 (C)
    Registration: ✓ Expires in 400 days, locked
    DNS:          ✓ 2 NS, propagation OK
    SSL:          ✗ Expired 2 days ago
    Email:        ✓ SPF + DMARC (reject)
    DNSSEC:       ✓ Valid
```

## Recommended Audit Frequency

| Portfolio Size | Full Audit | Expiry Check | SSL Check |
|---------------|------------|--------------|-----------|
| 1–10 domains | Monthly | Weekly | Weekly |
| 11–50 domains | Monthly | Weekly | Weekly |
| 51–200 domains | Bi-weekly | Daily | Daily |
| 200+ domains | Weekly | Daily | Daily |
