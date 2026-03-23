# SPF Record Analysis

SPF records are published as DNS TXT records at the domain apex. A domain MUST have at most one SPF record.

## Record Format

```
v=spf1 [mechanisms...] [modifiers...] [qualifier]all
```

## Mechanisms

| Mechanism | Syntax | Purpose |
|-----------|--------|---------|
| `ip4` | `ip4:203.0.113.0/24` | Allow IPv4 address or CIDR range |
| `ip6` | `ip6:2001:db8::/32` | Allow IPv6 address or CIDR range |
| `a` | `a` or `a:other.com` | Allow IPs in the domain's A/AAAA records |
| `mx` | `mx` or `mx:other.com` | Allow IPs of the domain's MX hosts |
| `include` | `include:_spf.google.com` | Recursively evaluate another domain's SPF |
| `exists` | `exists:%{i}.bl.example.com` | Pass if A record exists (macro-based) |
| `redirect` | `redirect=_spf.example.com` | Replace entire SPF with another domain's record (modifier) |

## Qualifiers

| Qualifier | Prefix | Meaning |
|-----------|--------|---------|
| Pass | `+` (default) | Authorized sender |
| Fail | `-` | Unauthorized — reject |
| SoftFail | `~` | Unauthorized — accept but mark |
| Neutral | `?` | No assertion |

## Common Issues

1. **DNS lookup limit exceeded** — SPF allows a maximum of **10 DNS lookups** (includes `include`, `a`, `mx`, `exists`, `redirect`). Each `include` can chain further lookups. Exceeding this causes a `permerror` and SPF fails open.
   - `ip4` and `ip6` do NOT count toward the limit
   - Count recursively through all `include` chains
2. **Multiple SPF records** — Only one `v=spf1` TXT record is allowed per domain. Multiple records cause a `permerror`.
3. **Missing `all` mechanism** — Every SPF record should end with `-all` (hard fail), `~all` (soft fail), or `?all` (neutral). Missing `all` means implicit `?all`.
4. **Overly permissive policy** — `+all` authorizes the entire internet to send as your domain. Almost always a misconfiguration.
5. **`ptr` mechanism** — Deprecated (RFC 7208 §5.5). Slow, unreliable, replace with `ip4`/`ip6`/`a`.
6. **Flat record too long** — A single DNS TXT record has a 255-byte string limit. SPF records exceeding this must be split into multiple strings within one TXT record (the DNS layer concatenates them).

## Common Provider SPF Includes

| Provider | Include |
|----------|---------|
| Google Workspace | `include:_spf.google.com` |
| Microsoft 365 | `include:spf.protection.outlook.com` |
| Amazon SES | `include:amazonses.com` |
| Mailchimp | `include:servers.mcsv.net` |
| SendGrid | `include:sendgrid.net` |
| Mailgun | `include:mailgun.org` |
| Zoho | `include:zoho.com` |
| Fastmail | `include:spf.messagingengine.com` |
| ProtonMail | `include:_spf.protonmail.ch` |

## Lookup Count Example

```
v=spf1 include:_spf.google.com include:spf.protection.outlook.com include:sendgrid.net -all
```

Lookup count:
1. `include:_spf.google.com` → 1 (plus its own includes: `_netblocks.google.com`, `_netblocks2.google.com`, `_netblocks3.google.com` = +3)
2. `include:spf.protection.outlook.com` → 1 (plus its own includes ≈ +2)
3. `include:sendgrid.net` → 1 (plus its own includes ≈ +1)

**Total: ~9 lookups** — close to the limit. Adding another provider risks `permerror`.
