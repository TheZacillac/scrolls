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

| Variable | Description | Default |
|----------|-------------|---------|
| `RUST_LOG` | Log level: trace, debug, info, warn, error | warn |
| `SEER_CORS_ORIGINS` | CORS origins for REST API (comma-separated) | `*` |
| `SEER_RATE_LIMIT` | REST API rate limit (requests/minute) | `30` |
