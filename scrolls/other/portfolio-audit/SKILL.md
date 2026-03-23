# Portfolio Audit — Domain Portfolio Health Assessment

## What is a Portfolio Audit?

A portfolio audit evaluates a collection of domains across multiple health vectors: registration status, DNS configuration, SSL certificates, security posture, and operational consistency. It identifies domains at risk of expiry, misconfiguration, or security gaps.

## Quick Start

```bash
seer bulk lookup domain1.com domain2.com domain3.com --format json
seer bulk status domain1.com domain2.com domain3.com --format json
seer bulk dig domain1.com domain2.com domain3.com --format json
```

## Reference

- [Audit Dimensions](reference/dimensions.md) — Registration, DNS, SSL, email auth, and registrar diversity checks
- [Scoring & Grading](reference/scoring.md) — Per-domain scoring framework and portfolio grading scale
- [Report Template](reference/report-template.md) — Structured audit report format and recommended frequency
