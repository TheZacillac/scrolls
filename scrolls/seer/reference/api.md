# Seer REST API

## Quick Start

```bash
seer-api    # Starts on http://127.0.0.1:8000 by default
```

## Security Defaults (v0.23.0)

- **Binds to `127.0.0.1` by default.** Set `SEER_HOST=0.0.0.0` to expose
  publicly — but this is **refused at startup** unless `SEER_API_KEY` is
  also set.
- **Bearer auth.** When `SEER_API_KEY` is set, every request except
  `GET /health` must include `Authorization: Bearer <key>`.
- **Docs disabled by default.** `/docs`, `/redoc`, and `/openapi.json`
  return 404 unless `SEER_DOCS_ENABLED=true`.
- **SSRF-guarded.** Lookup, RDAP, and DNS routes reject reserved/private
  IPs and hostnames that resolve to them.
- **Request body cap.** Bulk endpoints reject payloads above the size
  limit (400 response).
- **XFF trust.** `X-Forwarded-For` is ignored unless `SEER_TRUST_PROXY=true`
  and the peer is in `SEER_TRUSTED_PROXY_IPS`.

See [config.md](config.md) for all env vars.

## Endpoints

| Endpoint | Description |
|----------|-------------|
| `GET /health` | Liveness probe (no auth required) |
| `GET /lookup/{domain}` | Smart lookup |
| `POST /lookup/bulk` | Bulk lookups (JSON: `{"domains": [...]}`) |
| `POST /lookup/bulk/stream` | Streaming bulk lookups (SSE) |
| `GET /whois/{domain}` | WHOIS lookup |
| `POST /whois/bulk` | Bulk WHOIS |
| `POST /whois/bulk/stream` | Streaming bulk WHOIS (SSE) |
| `GET /rdap/domain/{domain}` | RDAP domain |
| `GET /rdap/ip/{ip}` | RDAP IP |
| `GET /rdap/asn/{asn}` | RDAP ASN |
| `GET /dns/{domain}/{type}` | DNS query |
| `POST /dns/bulk` | Bulk DNS |
| `POST /dns/bulk/stream` | Streaming bulk DNS (SSE) |
| `GET /propagation/{domain}/{type}` | Propagation check |
| `POST /propagation/bulk` | Bulk propagation |
| `POST /propagation/bulk/stream` | Streaming bulk propagation (SSE) |
| `GET /status/{domain}` | Domain status |
| `POST /status/bulk` | Bulk status checks |
| `POST /status/bulk/stream` | Streaming bulk status (SSE) |

## Bulk Limits

- Max 100 domains per bulk request
- Max concurrency: 50

## Documentation

When `SEER_DOCS_ENABLED=true`:

- Swagger: `http://127.0.0.1:8000/docs`
- ReDoc: `http://127.0.0.1:8000/redoc`
- OpenAPI JSON: `http://127.0.0.1:8000/openapi.json`

## Metrics

Set `SEER_METRICS_ENABLED=true` to expose `/metrics` to non-loopback
clients. Without it, `/metrics` is loopback-only.
