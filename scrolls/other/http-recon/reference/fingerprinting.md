# Server Fingerprinting & Technology Detection

## Headers That Reveal Server Info

| Header | Example | Info Leaked |
|--------|---------|-------------|
| `Server` | `nginx/1.24.0` | Web server and version |
| `X-Powered-By` | `PHP/8.2.1` | Application framework |
| `X-AspNet-Version` | `4.0.30319` | .NET version |
| `X-Generator` | `WordPress 6.4` | CMS |
| `Via` | `1.1 varnish (Varnish/7.0)` | Proxy/cache |
| `X-Cache` | `HIT from cloudfront` | CDN |
| `X-Served-By` | `cache-lax17823-LAX` | Edge node |

**Recommendation:** Production servers should suppress version information in `Server` and remove `X-Powered-By` headers.

## Technology Detection Signals

Beyond headers, technology can be inferred from:

- **Cookie names** — `PHPSESSID` (PHP), `JSESSIONID` (Java), `ASP.NET_SessionId` (.NET), `_rails_session` (Rails)
- **URL patterns** — `/wp-content/` (WordPress), `/wp-admin/` (WordPress), `/api/v1/` (generic API)
- **Response body** — Meta generators, framework-specific HTML
- **Error page formats** — Default error pages reveal server/framework
- **JavaScript files** — Framework-specific bundles and libraries

## Information Disclosure Checks

- [ ] `Server` header does not expose version
- [ ] `X-Powered-By` header removed
- [ ] No framework-specific version headers
- [ ] Error pages don't expose stack traces or server details
- [ ] Directory listing disabled
