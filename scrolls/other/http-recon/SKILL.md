# HTTP Recon — Header Analysis, Redirect Tracing & Security Auditing

## What is HTTP Recon?

HTTP reconnaissance examines a domain's web server behavior beyond what DNS and SSL reveal. It covers redirect chains, HTTP security headers, server fingerprinting, and response analysis. This skill extends Seer's domain diagnostics into the HTTP layer.

## Quick Start

Test all entry points for redirect behavior:
```
http://example.com       → ?
http://www.example.com   → ?
https://example.com      → ?
https://www.example.com  → ?
```

All should converge on a single canonical URL with minimal hops.

## Reference

- [Redirect Analysis](reference/redirects.md) — Redirect chain tracing, status codes, common issues
- [Security Headers](reference/security-headers.md) — HSTS, CSP, X-Content-Type-Options, Permissions-Policy, and more
- [Server Fingerprinting](reference/fingerprinting.md) — Technology detection from headers, cookies, and response patterns
