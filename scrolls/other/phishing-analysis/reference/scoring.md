# Phishing Threat Scoring Framework

## Weighted Indicators

| Category | Weight | Factors |
|----------|--------|---------|
| **Domain name** | 25% | Brand similarity, suspicious keywords, TLD |
| **Registration** | 25% | Age, registrar, registration period, WHOIS |
| **DNS configuration** | 20% | MX presence, SPF, TTL, fast-flux |
| **SSL/TLS** | 15% | Cert type, age, issuer, SANs |
| **Infrastructure** | 15% | Hosting provider, IP reputation, NS |

## Risk Levels

| Level | Score | Interpretation |
|-------|-------|---------------|
| **Critical** | 80–100 | Almost certainly malicious — active phishing or abuse |
| **High** | 60–79 | Strong indicators of malicious intent |
| **Medium** | 40–59 | Several suspicious signals, warrants investigation |
| **Low** | 20–39 | Minor signals, likely legitimate |
| **Clean** | 0–19 | No significant indicators |

## Investigation Workflow

### Quick Assessment

```bash
seer lookup suspicious-domain.com
seer dig suspicious-domain.com A MX TXT NS
seer status suspicious-domain.com
seer ssl suspicious-domain.com
```

### Deep Investigation

```bash
seer whois suspicious-domain.com
seer rdap suspicious-domain.com
seer dig suspicious-domain.com A AAAA MX TXT NS CNAME CAA SOA
seer dig suspicious-domain.com TXT
seer dig _dmarc.suspicious-domain.com TXT
seer prop suspicious-domain.com A
seer subdomains suspicious-domain.com
seer diff legitimate-brand.com suspicious-domain.com
```
