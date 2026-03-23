# Zone Health Severity Classification

## Severity Levels

| Severity | Criteria | Examples |
|----------|----------|---------|
| **Critical** | Security vulnerability or service outage risk | Dangling CNAME (subdomain takeover), no NS, DNSSEC chain broken |
| **High** | Significant misconfiguration affecting deliverability or security | No SPF, DMARC `p=none` permanently, CNAME at apex, MX pointing to CNAME |
| **Medium** | Best practice violation with operational impact | Single NS, no CAA, no DNSSEC, inconsistent TTLs |
| **Low** | Advisory / optimization opportunity | Missing AAAA, stale TXT records, no null MX on non-mail domain |

## Audit Report Template

```
Zone Health Audit: example.com
Date: YYYY-MM-DD

Summary: X critical, Y high, Z medium, W low findings

CRITICAL
  [C1] Dangling CNAME: blog.example.com → old-host.provider.com (NXDOMAIN)
       Risk: Subdomain takeover — attacker can claim old-host.provider.com
       Fix: Remove the CNAME record or update to a valid target

HIGH
  [H1] No DMARC record at _dmarc.example.com
       Risk: No protection against email spoofing
       Fix: Publish DMARC record, start with p=none and rua= for monitoring

MEDIUM
  [M1] Single nameserver network — all NS on 198.51.100.0/24
       Risk: Single point of failure
       Fix: Add NS on a different network/provider

LOW
  [L1] No AAAA records for example.com
       Risk: Not reachable over IPv6
       Fix: Add AAAA record if host supports IPv6
```
