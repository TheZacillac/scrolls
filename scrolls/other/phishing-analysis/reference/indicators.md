# Phishing & Abuse Threat Indicators

## 1. Registration Signals

```bash
seer lookup suspicious-domain.com --format json
seer whois suspicious-domain.com
```

| Signal | Low Risk | Suspicious | High Risk |
|--------|----------|-----------|-----------|
| **Domain age** | > 2 years | 3–24 months | < 3 months (newly registered) |
| **Registrar** | Established | Budget registrar | Known abuse-friendly registrar |
| **WHOIS privacy** | Normal for legitimate domains | Combined with other signals | Privacy + new + suspicious name |
| **Registration period** | Multi-year | 1 year | 1 year (minimum commitment) |
| **Registrant** | Consistent, verifiable | Privacy-protected | Clearly fake details |
| **Status codes** | `clientTransferProhibited` | No locks | `serverHold` (suspended) |

### Newly Registered Domain (NRD) Risk

Domains registered within the past 30 days are statistically far more likely to be malicious:
- Phishing campaigns (register → attack → abandon)
- Spam infrastructure
- Malware command and control
- SEO spam / link farms

## 2. Domain Name Signals

| Signal | Pattern | Risk |
|--------|---------|------|
| **Brand impersonation** | Contains well-known brand (`paypal-secure.com`) | High |
| **Typosquat** | Close misspelling of legitimate domain | High |
| **Excessive length** | Very long domain with keyword stuffing | Medium |
| **Random characters** | `xk3j9f2m.com` | Medium (may be C2) |
| **Suspicious keywords** | `login`, `secure`, `verify`, `update`, `account`, `confirm` | High |
| **Hyphen abuse** | Multiple hyphens (`pay-pal-secure-login.com`) | High |
| **TLD** | `.xyz`, `.top`, `.club`, `.work`, `.buzz`, `.gq`, `.ml`, `.tk`, `.cf`, `.ga` | Elevated |
| **Subdomain depth** | `login.paypal.com.suspicious.com` | Critical |

## 3. DNS Signals

```bash
seer dig suspicious-domain.com A AAAA MX TXT NS CNAME
```

| Signal | What to Check | Risk Indicator |
|--------|--------------|----------------|
| **A record** | IP address reputation | Known bulletproof hosting range |
| **MX records** | Mail infrastructure | Active MX on a brand-new domain |
| **SPF record** | Mail authorization | Overly permissive (`+all`) |
| **DMARC** | Mail policy | Missing entirely |
| **NS** | Nameserver provider | Free/abuse-prone DNS |
| **Multiple A records** | Fast-flux hosting | IP changes rapidly |
| **Low TTL** | Short cache time | TTL < 300 on A record (fast-flux indicator) |

### Fast-Flux Detection

```bash
seer dig suspicious-domain.com A
# Check again — do IPs change?
seer prop suspicious-domain.com A
```

Indicators:
- A records change between queries
- Many different IPs across global resolvers
- Very low TTL (60–300 seconds)
- IPs in residential/consumer ranges (botnet nodes)

## 4. SSL/TLS Signals

```bash
seer ssl suspicious-domain.com
```

| Signal | Low Risk | Suspicious |
|--------|----------|-----------|
| **Certificate type** | OV/EV cert | Free DV cert on brand-impersonation domain |
| **Certificate age** | Issued months/years ago | Issued within days |
| **SAN entries** | Matches domain | Contains many unrelated domains |
| **Self-signed** | Never for public sites | May indicate hasty setup |

**Note:** Free DV certificates are not inherently suspicious. They become a signal only in combination with other indicators.

## 5. Infrastructure Signals

| Signal | Check | Risk Indicator |
|--------|-------|----------------|
| **Hosting location** | IP geolocation | Lax enforcement jurisdiction |
| **Shared hosting** | Reverse DNS, SSL SANs | Many unrelated domains on same IP |
| **Bulletproof hosting** | IP range reputation | Known bulletproof hosting provider |
| **Nameservers** | NS records | Free DNS providers (often abused) |
| **CDN/proxy** | CNAME, headers | Using CDN to hide origin |

## Abuse-Prone TLDs

### Free Registration TLDs (Historical)

`.tk`, `.ml`, `.ga`, `.cf`, `.gq` — Freenom-operated, heavily abused, new registrations suspended.

### High-Volume Abuse TLDs

`.xyz`, `.top`, `.club`, `.work`, `.buzz`, `.surf`, `.icu`, `.cam`, `.monster`, `.rest`, `.cfd`

### Context Matters

Always consider the full context, not just the TLD. A `.xyz` from a tech startup is probably legitimate; a `.xyz` registered yesterday with `paypal` in the name is almost certainly phishing.
