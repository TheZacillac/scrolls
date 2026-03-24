# Typosquatting Triage & Monitoring

## Checking Candidates with Seer

### Single Candidate

```bash
seer avail exampl.com             # Check availability
seer lookup exampl.com            # WHOIS + RDAP (if registered)
seer status exampl.com            # Full health check
seer ssl exampl.com               # SSL certificate (who's operating it?)
seer dig exampl.com A              # Where does it point?
seer dig exampl.com MX
seer dig exampl.com TXT
```

### Bulk Availability Check

```bash
echo -e "exampl.com\nexmple.com\nexaple.com\nexamle.com\nexampe.com" > candidates.txt
seer --format json bulk avail candidates.txt
```

Exit codes: `0` = available (not registered), `1` = taken (registered).

### Triage Registered Domains

```bash
echo -e "exampl.com\nexmple.com" > triage.txt
seer --format json bulk lookup triage.txt
seer status exampl.com
seer ssl exampl.com
```

## Risk Assessment Matrix

| Signal | Low Risk | Medium Risk | High Risk |
|--------|----------|-------------|-----------|
| **Registration date** | Old (years) | Recent (months) | Very recent (days/weeks) |
| **Registrant** | Known entity / parked | Privacy-protected | Fake/suspicious details |
| **DNS** | Parked / no records | Generic hosting | Clones brand's DNS setup |
| **Web content** | Parked page / for sale | Unrelated content | Mimics brand site |
| **SSL certificate** | None / self-signed | Generic DV cert | Cert with brand name |
| **MX records** | None | Generic mail | Active mail (phishing risk) |
| **Nameservers** | Registrar default | Generic hosting NS | Bulletproof hosting NS |

## Monitoring Strategy

### Initial Scan

1. Generate candidates using all techniques
2. Bulk check availability via `seer bulk avail`
3. Triage registered domains with `seer bulk lookup` and `seer bulk status`
4. Flag high-risk domains for investigation

### Ongoing Monitoring

```bash
seer watch add exampl.com
seer watch add exmple.com
seer watch
```

### Alert Triggers

Flag for immediate investigation when a watched domain:
- Was previously available and becomes registered
- Changes DNS to point to hosting (was parked)
- Adds MX records (potential phishing setup)
- Obtains an SSL certificate (preparing for HTTPS impersonation)
- Web content changes to mimic the protected brand
