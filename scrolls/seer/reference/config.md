# Seer Configuration

## Setup

```bash
seer config --init    # Create ~/.seer/config.toml with defaults
seer config           # Show current config as JSON
```

## Config File

Location: `~/.seer/config.toml`

```toml
output_format = "human"    # human, json, yaml, markdown
# nameserver = "8.8.8.8"   # Optional default nameserver

[timeouts]
whois_secs = 15
rdap_secs = 30
dns_secs = 5
http_secs = 10

[bulk]
concurrency = 10
rate_limit_ms = 100
```

## Environment Variables

### Core (Rust)

| Variable | Description | Default |
|----------|-------------|---------|
| `RUST_LOG` | Log level: trace, debug, info, warn, error | warn |
| `SEER_LIVE_TESTS` | Enable live-network tests in `pytest` | unset |

### REST API / MCP (seer-api)

| Variable | Description | Default |
|----------|-------------|---------|
| `SEER_HOST` | API bind host. Non-loopback requires `SEER_API_KEY` | `127.0.0.1` |
| `SEER_PORT` | API bind port | `8000` |
| `SEER_API_KEY` | Bearer token required for all non-`/health` requests | — |
| `SEER_CORS_ORIGINS` | CORS origins (comma-separated) | `*` |
| `SEER_DOCS_ENABLED` | Expose `/docs`, `/redoc`, `/openapi.json` | `false` |
| `SEER_METRICS_ENABLED` | Expose `/metrics` to non-loopback clients | `false` |
| `SEER_RATE_LIMIT` | Default slowapi rate limit | `30/minute` |
| `SEER_RATE_LIMIT_STORAGE` | Rate-limit storage URI (e.g. `redis://host:6379`) | `memory://` |
| `SEER_TRUST_PROXY` | Honor `X-Forwarded-For` from trusted peers | `false` |
| `SEER_TRUSTED_PROXY_IPS` | Comma-separated IPs allowed to set XFF | — |
| `WEB_CONCURRENCY` | Uvicorn worker count. `>1` requires non-`memory://` store | `1` |

## Breaking Changes (v0.23.0)

The API now hard-fails at startup in these cases (previously logged a warning):

1. `SEER_HOST != 127.0.0.1` without `SEER_API_KEY` — public bind without auth is refused.
2. `WEB_CONCURRENCY > 1` with `SEER_RATE_LIMIT_STORAGE=memory://` — per-worker limiters would be bypassable.

`/docs`, `/redoc`, and `/openapi.json` are disabled by default. Set `SEER_DOCS_ENABLED=true` to re-enable.
