# CDN & Hosting HTTP Header Detection

## Response Header Patterns

| Header | Value Pattern | Provider |
|--------|---------------|----------|
| `Server` | `cloudflare` | Cloudflare |
| `Server` | `AmazonS3` | AWS S3 |
| `Server` | `gws` | Google |
| `Server` | `GitHub.com` | GitHub Pages |
| `Server` | `Vercel` | Vercel |
| `Server` | `Netlify` | Netlify |
| `Server` | `nginx` | Often self-hosted or generic |
| `Server` | `Apache` | Often self-hosted or shared hosting |
| `Server` | `Microsoft-IIS/*` | IIS (often Azure/Windows) |
| `Server` | `LiteSpeed` | LiteSpeed (often shared hosting) |
| `cf-ray` | any value | Cloudflare |
| `cf-cache-status` | `HIT`, `MISS`, `DYNAMIC` | Cloudflare |
| `x-amz-cf-id` | any value | Amazon CloudFront |
| `x-amz-cf-pop` | any value | Amazon CloudFront |
| `x-cache` | `* from cloudfront` | Amazon CloudFront |
| `x-served-by` | `cache-*` | Fastly |
| `x-fastly-request-id` | any value | Fastly |
| `x-vercel-id` | any value | Vercel |
| `x-vercel-cache` | any value | Vercel |
| `x-nf-request-id` | any value | Netlify |
| `x-github-request-id` | any value | GitHub Pages |
| `x-azure-ref` | any value | Azure CDN / Front Door |
| `x-ms-ref` | any value | Azure CDN |
| `x-akamai-transformed` | any value | Akamai |
| `x-goog-*` | any value | Google Cloud |
| `x-guploader-uploadid` | any value | Google Cloud Storage |
| `fly-request-id` | any value | Fly.io |
| `x-render-origin-server` | any value | Render |
| `via` | `1.1 varnish` | Often Fastly |
| `x-sucuri-id` | any value | Sucuri |
| `x-cdn` | `Incapsula` | Imperva |
