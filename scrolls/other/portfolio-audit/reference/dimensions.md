# Portfolio Audit Dimensions

## 1. Registration Health

| Check | What to Look For | Risk |
|-------|-----------------|------|
| **Expiry date** | Days until expiration | Domain loss if not renewed |
| **Auto-renew** | Whether auto-renew is enabled | Accidental expiry |
| **Registrar lock** | `clientTransferProhibited` status | Unauthorized transfer |
| **Registration consistency** | Same registrar, consistent contacts | Operational fragmentation |
| **WHOIS privacy** | Privacy protection enabled | Contact data exposure |

### Expiry Risk Tiers

| Tier | Days Until Expiry | Action |
|------|------------------|--------|
| **Critical** | ≤ 7 days | Immediate renewal required |
| **Urgent** | 8–30 days | Renew this week |
| **Warning** | 31–90 days | Schedule renewal |
| **OK** | 91–365 days | Monitor normally |
| **Healthy** | > 365 days | No action needed |

## 2. DNS Health

| Check | What to Look For | Risk |
|-------|-----------------|------|
| **NS count** | At least 2, preferably 3+ | Outage if single NS fails |
| **NS diversity** | Different networks/providers | Single point of failure |
| **A/AAAA resolution** | Records resolve correctly | Site unreachable |
| **Propagation** | Consistent across global resolvers | Regional outages |
| **DNSSEC** | Signed and chain validates (optional — low adoption among major brands) | DNS spoofing |
| **Dangling records** | CNAMEs/NS pointing to deprovisioned targets | Subdomain takeover |

## 3. SSL/TLS Health

| Check | What to Look For | Risk |
|-------|-----------------|------|
| **Certificate present** | Valid cert on HTTPS | Browser warnings |
| **Expiry** | Days until cert expiration | Site downtime |
| **Issuer** | Known/trusted CA | Untrusted certificate warnings |
| **SAN coverage** | Cert covers www and apex | Partial HTTPS |
| **Protocol version** | TLS 1.2+ | Insecure connection |
| **Key size** | RSA ≥ 2048 or ECDSA ≥ 256 | Weak encryption |
| **CAA records** | Restrict authorized CAs | Unauthorized cert issuance |

### SSL Expiry Risk Tiers

| Tier | Days Until Expiry | Action |
|------|------------------|--------|
| **Critical** | ≤ 7 days | Immediate renewal/reissue |
| **Urgent** | 8–14 days | Renew this week |
| **Warning** | 15–30 days | Schedule renewal |
| **OK** | > 30 days | Monitor normally |

## 4. Email Authentication

| Check | What to Look For | Risk |
|-------|-----------------|------|
| **SPF** | Valid `v=spf1` record | Email spoofing |
| **DMARC** | Policy at `_dmarc.` subdomain | No spoofing protection |
| **DMARC policy** | `quarantine` or `reject` vs `none` | Unenforced policy |
| **DKIM** | At least one selector resolvable | Message integrity |
| **Null MX** | Set for non-mail domains | Abuse vector |

## 5. Registrar Diversity

| Metric | Healthy | Concerning |
|--------|---------|------------|
| **Registrar count** | 1–2 registrars | 5+ registrars (fragmentation) |
| **Per-registrar distribution** | Balanced | 90%+ at one registrar (concentration risk) |
| **Registrar reputation** | ICANN-accredited, established | Unknown/unreliable registrar |
