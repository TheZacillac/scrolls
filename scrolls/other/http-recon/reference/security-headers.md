# HTTP Security Headers

## Essential Headers

| Header | Purpose | Recommended Value |
|--------|---------|-------------------|
| `Strict-Transport-Security` | Force HTTPS | `max-age=31536000; includeSubDomains; preload` |
| `Content-Security-Policy` | Control resource loading | Specific to application |
| `X-Content-Type-Options` | Prevent MIME sniffing | `nosniff` |
| `X-Frame-Options` | Prevent clickjacking | `DENY` or `SAMEORIGIN` |
| `Referrer-Policy` | Control referrer leakage | `strict-origin-when-cross-origin` |
| `Permissions-Policy` | Control browser features | Restrict unused features |

## HSTS (HTTP Strict Transport Security)

```
Strict-Transport-Security: max-age=31536000; includeSubDomains; preload
```

| Directive | Purpose | Recommendation |
|-----------|---------|----------------|
| `max-age` | Duration (seconds) browser remembers HTTPS-only | ≥ 31536000 (1 year) for production |
| `includeSubDomains` | Apply to all subdomains | Include unless subdomains need HTTP |
| `preload` | Submit to browser HSTS preload list | Add after testing; hard to undo |

**Deployment steps:** Start `max-age=300` → 604800 (1w) → 31536000 (1y) → add `includeSubDomains` → add `preload`.

## Content Security Policy (CSP)

```
Content-Security-Policy: default-src 'self'; script-src 'self' cdn.example.com; style-src 'self' 'unsafe-inline'; img-src 'self' data: *.cdn.com; frame-ancestors 'none'
```

| Directive | Controls |
|-----------|----------|
| `default-src` | Fallback for all resource types |
| `script-src` | JavaScript sources |
| `style-src` | CSS sources |
| `img-src` | Image sources |
| `font-src` | Font sources |
| `connect-src` | XHR/fetch/WebSocket targets |
| `frame-src` | Iframe sources |
| `frame-ancestors` | Who can embed this page (replaces X-Frame-Options) |
| `base-uri` | Restrict `<base>` element |
| `form-action` | Restrict form submission targets |
| `report-uri` / `report-to` | Where to send violation reports |

**Common CSP issues:**
- `unsafe-inline` in `script-src` — undermines XSS protection
- `unsafe-eval` — allows `eval()`, major XSS risk
- `*` wildcard — too permissive
- Missing `frame-ancestors` — clickjacking possible
- Missing `default-src` — no fallback protection

## Permissions Policy

```
Permissions-Policy: camera=(), microphone=(), geolocation=(), payment=()
```

Common features to restrict: `camera`, `microphone`, `geolocation`, `payment`, `usb`, `magnetometer`, `gyroscope`, `accelerometer`

## Cookie Security

| Attribute | Purpose | Recommended |
|-----------|---------|-------------|
| `Secure` | Only sent over HTTPS | Always set |
| `HttpOnly` | Not accessible via JavaScript | Set for session cookies |
| `SameSite` | Cross-site request control | `Strict` or `Lax` |
| `Path` | Restrict cookie scope | Set to narrowest path needed |
| `Domain` | Restrict to specific domain | Omit to restrict to exact domain |
| `Max-Age`/`Expires` | Cookie lifetime | Set reasonable expiry |

## Audit Checklist

### Redirect Chain
- [ ] All HTTP URLs redirect to HTTPS (301)
- [ ] Canonical URL is consistent (www vs non-www)
- [ ] No redirect loops
- [ ] Maximum 2–3 hops
- [ ] Final destination returns 200

### Security Headers
- [ ] `Strict-Transport-Security` present with `max-age` ≥ 31536000
- [ ] `Content-Security-Policy` present and restrictive
- [ ] `X-Content-Type-Options: nosniff` present
- [ ] `X-Frame-Options` or CSP `frame-ancestors` present
- [ ] `Referrer-Policy` present
- [ ] `Permissions-Policy` present

### Cookie Security
- [ ] Session cookies have `Secure` flag
- [ ] Session cookies have `HttpOnly` flag
- [ ] Cookies have appropriate `SameSite` attribute

## Severity Classification

| Severity | Examples |
|----------|---------|
| **Critical** | No HTTPS redirect, open redirect vulnerability |
| **High** | Missing HSTS, CSP allows `unsafe-eval`, no `Secure` flag on session cookies |
| **Medium** | Short HSTS max-age, missing `X-Content-Type-Options`, no `X-Frame-Options` |
| **Low** | Server version disclosed, missing `Permissions-Policy`, 302 instead of 301 |
