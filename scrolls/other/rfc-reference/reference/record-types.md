# DNS Record Types Quick Reference

| Type | RFC | Value | Purpose |
|------|-----|-------|---------|
| A | 1035 | IPv4 address | Host address |
| AAAA | 3596 | IPv6 address | Host address (IPv6) |
| CNAME | 1035 | Domain name | Canonical name alias |
| MX | 1035 | Priority + domain | Mail exchange |
| NS | 1035 | Domain name | Authoritative nameserver |
| SOA | 1035 | Multiple fields | Zone authority and parameters |
| TXT | 1035 | Free text | Arbitrary text (SPF, DKIM, verification) |
| PTR | 1035 | Domain name | Reverse DNS (IP → name) |
| SRV | 2782 | Priority, weight, port, target | Service location |
| CAA | 8659 | Flag, tag, value | Certificate authority restriction |
| DNSKEY | 4034 | Flags, protocol, algorithm, key | DNSSEC public key |
| DS | 4034 | Key tag, algorithm, digest type, digest | DNSSEC delegation signer |
| RRSIG | 4034 | Signature over RRset | DNSSEC record signature |
| NSEC | 4034 | Next name + types | DNSSEC authenticated denial |
| NSEC3 | 5155 | Hashed name + types | DNSSEC hashed denial |
| TLSA | 6698 | Usage, selector, matching, data | DANE TLS certificate association |
| SVCB | 9460 | Priority, target, params | Service binding |
| HTTPS | 9460 | Priority, target, params | HTTPS service binding |
