# CDN & Hosting Detection — Infrastructure Provider Identification

## What is CDN & Hosting Detection?

CDN and hosting detection identifies the infrastructure providers serving a domain by analyzing DNS records, HTTP headers, IP ranges, and SSL certificates. Useful for competitive intelligence, migration planning, security assessments, and understanding a domain's architecture.

## Quick Start

```bash
seer dig example.com CNAME NS A          # DNS signals
seer dig www.example.com CNAME A         # www may differ from apex
seer status example.com                   # Includes some header info
seer ssl example.com                      # Certificate issuer/SANs
```

## Reference

- [DNS Patterns](reference/dns-patterns.md) — CNAME, nameserver, and IP range detection tables
- [HTTP Patterns](reference/http-patterns.md) — CDN-specific response headers
- [SSL Patterns](reference/ssl-patterns.md) — Certificate-based provider identification and common architectures
