# Redirect Chain Analysis

## Ideal Redirect Pattern

```
http://example.com       → 301 → https://example.com       (preferred)
http://www.example.com   → 301 → https://example.com
https://www.example.com  → 301 → https://example.com
https://example.com      → 200  (canonical)
```

## Common Issues

| Issue | Description | Impact |
|-------|-------------|--------|
| **Redirect loop** | A → B → A | Site unreachable |
| **Excessive hops** | More than 3 redirects | Performance, SEO penalty |
| **HTTP → HTTP redirect** | Redirect doesn't upgrade to HTTPS | Insecure first hop |
| **302 instead of 301** | Temporary vs permanent redirect | SEO: link equity not transferred |
| **Mixed canonical** | Some paths go to www, others to non-www | SEO: duplicate content |
| **No HTTPS redirect** | HTTP version serves content without redirect | Insecure by default |
| **Open redirect** | Redirect target influenced by user input | Phishing vector |

## Redirect Status Codes

| Code | Meaning | Use Case |
|------|---------|----------|
| 301 | Moved Permanently | Domain canonicalization, old URLs |
| 302 | Found (Temporary) | Temporary redirects, A/B testing |
| 303 | See Other | Post-redirect-get pattern |
| 307 | Temporary Redirect | Like 302 but preserves HTTP method |
| 308 | Permanent Redirect | Like 301 but preserves HTTP method |
