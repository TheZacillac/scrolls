# Email Authentication Audit Workflow

## Step 1: Gather Records

```bash
seer dig example.com TXT          # SPF record
seer dig example.com MX           # Mail exchangers
seer dig _dmarc.example.com TXT   # DMARC policy
# Try common DKIM selectors
seer dig google._domainkey.example.com TXT
seer dig selector1._domainkey.example.com TXT
seer dig default._domainkey.example.com TXT
```

## Step 2: Validate SPF

- [ ] Exactly one `v=spf1` record exists
- [ ] Record ends with `-all` or `~all`
- [ ] Total DNS lookup count ≤ 10 (count recursively)
- [ ] No deprecated `ptr` mechanism
- [ ] No overly permissive `+all`
- [ ] Record length manageable (watch for TXT string splitting issues)

## Step 3: Validate DKIM

- [ ] At least one selector resolves with a valid public key
- [ ] Key length ≥ 1024 bits (2048 preferred)
- [ ] `p=` tag is not empty (not revoked)
- [ ] `t=y` testing flag removed in production
- [ ] Multiple selectors available for rotation

## Step 4: Validate DMARC

- [ ] `_dmarc.` record exists with `v=DMARC1`
- [ ] Policy is `quarantine` or `reject` (not perpetual `none`)
- [ ] `rua=` tag present for aggregate reporting
- [ ] `pct=100` (or ramping toward it)
- [ ] Subdomain policy (`sp=`) explicitly set
- [ ] Alignment modes appropriate for mail flow

## Step 5: Cross-Validation

- [ ] SPF includes match actual mail providers (cross-reference MX records)
- [ ] DKIM selectors match the sending providers
- [ ] DMARC alignment mode compatible with mail flow (forwarding, mailing lists)
- [ ] No conflicting configurations (e.g., SPF allows a host that DKIM doesn't cover)

## Ideal Configuration

```dns
; SPF — authorize known senders, hard-fail everything else
example.com.  IN TXT  "v=spf1 include:_spf.google.com ip4:203.0.113.5 -all"

; DKIM — 2048-bit key, two selectors for rotation
selector1._domainkey.example.com.  IN TXT  "v=DKIM1; k=rsa; p=MIIBIjAN..."
selector2._domainkey.example.com.  IN TXT  "v=DKIM1; k=rsa; p=MIIBIjAN..."

; DMARC — reject policy with reporting
_dmarc.example.com.  IN TXT  "v=DMARC1; p=reject; sp=reject; rua=mailto:dmarc-agg@example.com; ruf=mailto:dmarc-forensic@example.com; adkim=s; aspf=s; pct=100"
```
