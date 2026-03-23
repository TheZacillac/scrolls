# DNS Migration Phases

## Phase 1: Pre-Migration Audit

### Inventory Current Records

```bash
seer dig example.com SOA NS A AAAA MX TXT CNAME CAA --format json > before.json
seer dig www.example.com A AAAA CNAME
seer dig mail.example.com A AAAA
seer dig api.example.com A AAAA CNAME
seer dig example.com TXT                     # SPF
seer dig _dmarc.example.com TXT              # DMARC
seer dig selector1._domainkey.example.com TXT # DKIM
seer dnssec example.com
seer status example.com --format json
```

### Record Inventory Checklist

- [ ] Zone apex records: A, AAAA, MX, TXT, CAA, SOA
- [ ] www subdomain: A, AAAA, or CNAME
- [ ] Mail subdomain(s): A, AAAA
- [ ] API/service subdomains: A, AAAA, CNAME
- [ ] SPF record (TXT at apex)
- [ ] DMARC record (TXT at `_dmarc`)
- [ ] DKIM records (TXT at `*._domainkey`)
- [ ] SRV records (e.g., `_sip._tcp`, `_autodiscover._tcp`)
- [ ] Verification TXT records
- [ ] Glue records (if NS is within the zone)
- [ ] DNSSEC DS records at parent

### Pre-Flight Checks

- [ ] Current TTLs documented
- [ ] Registrar lock status checked (`seer lookup example.com`)
- [ ] Domain not expiring within 30 days
- [ ] No pending registrar transfers
- [ ] Access to both old and new DNS providers confirmed
- [ ] Access to domain registrar confirmed
- [ ] DNSSEC implications understood

## Phase 2: Prepare New Zone

### Lower TTLs (24–48 hours before)

Reduce TTLs at the **current** provider:

```
Current TTL  →  Migration TTL
3600 (1h)    →  300 (5m)
86400 (24h)  →  300 (5m)
```

**Critical:** Lower TTLs at least 1× the current TTL before migration. If current TTL is 86400, lower it at least 24h before.

Records to lower: NS, A/AAAA, CNAME, MX.

### Replicate Zone

1. Create the zone at the new DNS provider
2. Add every record from the inventory
3. Verify record-by-record match

### DNSSEC Considerations

**Option A: Disable before migration** (simpler, brief security gap)
1. Remove DS record from parent zone (registrar)
2. Wait for DS TTL to expire (24–48h)
3. Migrate DNS
4. Re-enable DNSSEC at new provider
5. Add new DS record at registrar

**Option B: Pre-publish keys** (no gap, complex)
1. Pre-publish new provider's DNSKEY at old provider
2. Add new DS record at registrar (both active)
3. Switch nameservers
4. Remove old DS record after propagation

**Recommendation:** Option A for most migrations.

## Phase 3: Execute Migration

### Nameserver Switch

Update NS records at the domain registrar to the new provider's nameservers.

### Monitor Propagation

```bash
seer prop example.com NS
seer prop example.com A
seer prop example.com MX
seer status example.com
```

### Propagation Timeline

| Record Type | Typical Propagation | Maximum Wait |
|-------------|-------------------|--------------|
| NS (at parent) | 1–24 hours | 48 hours |
| A/AAAA | Minutes (if TTL lowered) | Old TTL duration |
| MX | Minutes (if TTL lowered) | Old TTL duration |
| TXT | Minutes (if TTL lowered) | Old TTL duration |

## Phase 4: Post-Migration Validation

### Immediate (0–1 hours)

```bash
seer dig example.com NS
seer dig example.com A AAAA MX TXT
seer dig example.com TXT          # SPF
seer dig _dmarc.example.com TXT   # DMARC
seer status example.com
```

### Short-term (1–24 hours)

```bash
seer prop example.com NS
seer prop example.com A
seer prop example.com MX
seer dig example.com SOA NS A AAAA MX TXT CNAME CAA --format json > after.json
```

### Verification Checklist

- [ ] NS records point to new provider globally
- [ ] A/AAAA records resolve correctly
- [ ] Website loads via HTTPS
- [ ] MX records correct — test sending/receiving email
- [ ] SPF record present and valid
- [ ] DMARC record present
- [ ] DKIM records resolvable
- [ ] SSL certificate valid (`seer ssl example.com`)
- [ ] DNSSEC validates if re-enabled (`seer dnssec example.com`)
- [ ] CAA records present
- [ ] All subdomains resolve correctly

## Phase 5: Cleanup (48–72 hours post-migration)

1. **Restore TTLs** — Raise TTLs back to production values
2. **Re-enable DNSSEC** — If disabled, enable at new provider and add DS at registrar
3. **Decommission old zone** — Remove from old provider (only after confident)
4. **Lock domain** — Re-enable registrar lock
5. **Document** — Record migration date, providers, and issues
