# Phishing & Abuse Analysis — Domain Threat Indicator Detection

## What is Phishing & Abuse Analysis?

Phishing and abuse analysis examines a domain for indicators of malicious use — phishing, spam, malware distribution, or brand impersonation. This skill provides a framework for assessing domain threat levels using DNS, WHOIS, and infrastructure signals from Seer.

## Quick Start

```bash
seer lookup suspicious-domain.com       # Registration info
seer dig suspicious-domain.com A MX TXT NS  # DNS configuration
seer status suspicious-domain.com       # Health check
seer ssl suspicious-domain.com          # SSL certificate
```

## Reference

- [Threat Indicators](reference/indicators.md) — Registration, domain name, DNS, SSL, and infrastructure signals
- [Threat Scoring](reference/scoring.md) — Weighted scoring framework and risk levels
- [Abuse Reporting](reference/reporting.md) — Where and how to report malicious domains
