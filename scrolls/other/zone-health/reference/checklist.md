# Zone Health Audit Checklist

## 1. SOA Record

```
example.com. IN SOA ns1.example.com. admin.example.com. (
    2024031501  ; serial (YYYYMMDDNN format recommended)
    3600        ; refresh (1 hour)
    900         ; retry (15 minutes)
    604800      ; expire (7 days)
    300         ; minimum/negative TTL (5 minutes)
)
```

| Field | Best Practice | Common Issue |
|-------|--------------|--------------|
| **Serial** | YYYYMMDDNN format, always incrementing | Random/non-sequential serials confuse secondary NS |
| **Refresh** | 3600–86400 (1h–24h) | Too long = slow propagation to secondaries |
| **Retry** | 300–3600 (5m–1h), less than refresh | Retry > refresh makes no sense |
| **Expire** | 604800–2419200 (1w–4w) | Too short = secondaries drop zone during outages |
| **Minimum (Negative TTL)** | 300–3600 (5m–1h) | Too high = NXDOMAIN cached too long |

**Checks:**
- [ ] SOA record exists
- [ ] Serial follows a consistent scheme
- [ ] MNAME (primary NS) is a valid, resolvable nameserver
- [ ] RNAME (admin email) is valid (first `.` is `@`)
- [ ] Refresh < Expire
- [ ] Retry < Refresh

## 2. Nameserver Records

**Checks:**
- [ ] At least 2 NS records (RFC 1034), recommend 3–4
- [ ] NS on different networks/ASNs for resilience
- [ ] Parent and child NS sets match (no delegation mismatch)
- [ ] All NS hostnames resolve to valid A/AAAA records
- [ ] All NS respond authoritatively for the zone
- [ ] Glue records present where NS hostname is within the delegated zone
- [ ] NS TTL moderate (3600–86400)

## 3. A/AAAA Records

**Checks:**
- [ ] No private/reserved IPs (RFC 1918, RFC 4193) in public DNS
- [ ] No bogon/unroutable addresses
- [ ] TTLs appropriate (300–3600 for dynamic, 3600–86400 for stable)
- [ ] Both A and AAAA records where applicable (dual stack)

## 4. MX Records

**Checks:**
- [ ] MX records exist (or explicit null MX `0 .` for non-mail domains, RFC 7505)
- [ ] MX targets are not CNAMEs (RFC 2181)
- [ ] MX targets resolve to valid IPs
- [ ] Multiple MX with distinct priorities for redundancy
- [ ] MX hosts have PTR records
- [ ] TTL ~3600

## 5. CNAME Records

**Checks:**
- [ ] No CNAME at zone apex (must not coexist with other types, RFC 1034)
- [ ] No CNAME chains (CNAME → CNAME → A)
- [ ] All CNAME targets resolve (no dangling records → subdomain takeover risk)
- [ ] No CNAME coexisting with MX, NS, or SOA at the same name

## 6. TXT Records

**Checks:**
- [ ] SPF record present and valid (exactly one `v=spf1`)
- [ ] DMARC record at `_dmarc.` subdomain
- [ ] DKIM selectors resolvable
- [ ] No duplicate/conflicting SPF records
- [ ] Stale verification records cleaned up
- [ ] Individual TXT strings ≤ 255 bytes

## 7. CAA Records

```
example.com.  IN CAA  0 issue "letsencrypt.org"
example.com.  IN CAA  0 issuewild "letsencrypt.org"
example.com.  IN CAA  0 iodef "mailto:security@example.com"
```

**Checks:**
- [ ] CAA records present
- [ ] `issue` tag restricts to known/expected CAs
- [ ] `issuewild` explicitly set (doesn't inherit from `issue`)
- [ ] `iodef` tag present with valid contact

## 8. DNSSEC (Advisory)

> **Note:** DNSSEC has low adoption among major brands due to the operational complexity and risk of disruption to critical DNS services. Treat absence of DNSSEC as low severity. If DNSSEC is deployed, validate the chain is healthy.

**Checks (if DNSSEC is enabled):**
- [ ] DS record in parent zone matches DNSKEY
- [ ] Signature not expired
- [ ] Algorithm is current — ECDSAP256SHA256 (13) or ED25519 (15) preferred
- [ ] Chain of trust validates to root
- [ ] NSEC3 preferred over NSEC (prevents zone walking)

## 9. TTL Consistency

| Record Type | Recommended TTL | Rationale |
|-------------|----------------|-----------|
| SOA | 3600 | Moderate, allows timely updates |
| NS | 3600–86400 | Stable, infrequent changes |
| A/AAAA | 300–3600 | Depends on change frequency |
| MX | 3600 | Moderate stability |
| TXT (SPF) | 3600 | Moderate, changes infrequent |
| CNAME | 300–3600 | Match target's expected change rate |
| CAA | 3600–86400 | Rarely changes |

**Checks:**
- [ ] TTLs consistent within record groups
- [ ] No excessively low TTLs (< 60) without justification
- [ ] No excessively high TTLs (> 86400) for records that may need updates
