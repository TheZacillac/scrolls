# CDN & Hosting SSL Certificate Detection

## Certificate Patterns

```bash
seer ssl example.com --format json
```

| Certificate Pattern | Provider |
|--------------------|----------|
| Issuer: `Cloudflare Inc` | Cloudflare (Universal SSL) |
| SAN: `*.cloudfront.net` | Amazon CloudFront |
| Issuer: `Amazon` | AWS Certificate Manager |
| Issuer: `Google Trust Services` | Google-managed cert |
| Issuer: `Microsoft` / `DigiCert` with Azure SAN | Azure |
| SAN includes `*.netlify.app` | Netlify |
| SAN includes `*.vercel.app` | Vercel |
| SAN includes `*.herokuapp.com` | Heroku |
| Issuer: `Fastly` | Fastly |

## Multi-CDN Detection

Signs of multiple CDN providers:
- Different CNAME targets for `www` vs apex
- DNS-based load balancing returning different IPs per query
- Geographic variation in `seer prop` results
- Different `Server` or CDN headers depending on edge location

```bash
seer prop example.com A  # Check for geographic variation
```

## Common Architectures

| Architecture | DNS Pattern | Description |
|-------------|-------------|-------------|
| **Direct hosting** | A record → hosting IP | No CDN, single origin |
| **CDN proxy** | CNAME → CDN, or CDN nameservers | CDN fronts origin |
| **DNS-level CDN** | Cloudflare/similar NS | CDN at DNS layer |
| **Multi-tier** | CNAME → CDN → origin | CDN + cloud hosting |
| **Static + API split** | www → CDN, api → cloud provider | Separate static/dynamic |
| **Multi-CDN** | Different providers per region/subdomain | Redundancy and performance |
