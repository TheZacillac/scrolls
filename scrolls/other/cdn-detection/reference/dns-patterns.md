# CDN & Hosting DNS Detection Patterns

## CNAME Patterns

```bash
seer dig example.com CNAME
seer dig www.example.com CNAME
```

| CNAME Pattern | Provider |
|---------------|----------|
| `*.cloudfront.net` | Amazon CloudFront |
| `*.cloudflare.net` | Cloudflare |
| `*.cdn.cloudflare.net` | Cloudflare |
| `*.azureedge.net` | Azure CDN |
| `*.azurefd.net` | Azure Front Door |
| `*.akamaiedge.net`, `*.akamai.net` | Akamai |
| `*.edgekey.net` | Akamai |
| `*.fastly.net`, `*.fastlylb.net` | Fastly |
| `*.netlify.app` | Netlify |
| `*.vercel-dns.com` | Vercel |
| `*.herokuapp.com` | Heroku |
| `*.github.io` | GitHub Pages |
| `*.gitlab.io` | GitLab Pages |
| `*.pages.dev` | Cloudflare Pages |
| `*.workers.dev` | Cloudflare Workers |
| `*.firebaseapp.com`, `*.web.app` | Firebase Hosting |
| `*.render.com`, `*.onrender.com` | Render |
| `*.fly.dev` | Fly.io |
| `*.railway.app` | Railway |
| `*.b-cdn.net` | BunnyCDN |
| `*.stackpathdns.com` | StackPath |
| `*.sucuri.net` | Sucuri (WAF/CDN) |
| `*.incapdns.net` | Imperva/Incapsula |
| `*.panthercdn.com` | KeyCDN |
| `*.hwcdn.net` | Highwinds/StackPath |
| `*.cdn77.org` | CDN77 |
| `*.ghs.googlehosted.com` | Google Cloud |
| `*.c.storage.googleapis.com` | Google Cloud Storage |
| `*.s3.amazonaws.com`, `*.s3-website-*.amazonaws.com` | AWS S3 |
| `*.elasticbeanstalk.com` | AWS Elastic Beanstalk |
| `*.elb.amazonaws.com`, `*.elb.*.amazonaws.com` | AWS ELB |
| `*.wpengine.com` | WP Engine |
| `*.kinsta.cloud` | Kinsta |
| `*.myshopify.com` | Shopify |
| `*.squarespace.com` | Squarespace |
| `*.wixsite.com`, `*.wixdns.net` | Wix |

## Nameserver Patterns

```bash
seer dig example.com NS
```

| NS Pattern | Provider |
|------------|----------|
| `*.cloudflare.com` | Cloudflare |
| `*.awsdns-*.*` | AWS Route 53 |
| `ns-cloud-*.googledomains.com` | Google Cloud DNS |
| `*.azure-dns.*` | Azure DNS |
| `*.dnsimple.com` | DNSimple |
| `*.nsone.net` | NS1 |
| `*.digitalocean.com` | DigitalOcean |
| `*.linode.com` | Linode/Akamai |
| `*.domaincontrol.com` | GoDaddy |
| `*.registrar-servers.com` | Namecheap |
| `*.name-services.com` | Enom |
| `*.dynect.net` | Oracle Dyn |
| `*.ultradns.*` | UltraDNS/Neustar |
| `*.vercel-dns.com` | Vercel |
| `*.netlify.com` | Netlify |

## IP Range Detection

```bash
seer dig example.com A
```

| IP Range (prefix) | Provider |
|-------------------|----------|
| `104.16.0.0/12` | Cloudflare |
| `103.21.244.0/22`, `103.22.200.0/22` | Cloudflare |
| `13.*, 52.*, 54.*, 3.*` (various) | AWS |
| `34.*, 35.*` (various) | Google Cloud |
| `20.*, 40.*, 52.*` (various) | Azure |
| `151.101.*` | Fastly |
| `23.*, 2.16–23.*` (various) | Akamai |
| `199.232.*` | Fastly |
| `185.199.108–111.*` | GitHub Pages |
| `76.76.21.*` | Vercel |

**Note:** IP-based detection is less reliable than CNAME/NS patterns. Cloud providers have vast, overlapping ranges. Use as a supporting signal.
