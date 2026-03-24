# Portfolio Scoring & Grading

## Per-Domain Score

Assign points per category (0–100 scale):

| Category | Weight | Scoring |
|----------|--------|---------|
| **Registration** | 25% | Expiry risk, lock status, auto-renew |
| **DNS** | 25% | NS redundancy, propagation, dangling records |
| **SSL/TLS** | 20% | Cert validity, expiry, configuration |
| **Email Auth** | 15% | SPF + DMARC + DKIM presence and policy strength |
| **Security** | 15% | CAA, registrar lock, WHOIS privacy |

## Portfolio Score

```
Portfolio Score = average of all domain scores
```

## Grading Scale

| Grade | Score | Interpretation |
|-------|-------|---------------|
| **A** | 90–100 | Excellent — well-managed portfolio |
| **B** | 75–89 | Good — minor improvements needed |
| **C** | 60–74 | Fair — several issues to address |
| **D** | 40–59 | Poor — significant risks present |
| **F** | 0–39 | Critical — immediate attention required |
