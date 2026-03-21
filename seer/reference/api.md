# Seer REST API

## Quick Start

```bash
seer-api    # Starts on http://localhost:8000
```

## Endpoints

| Endpoint | Description |
|----------|-------------|
| `GET /lookup/{domain}` | Smart lookup |
| `POST /lookup/bulk` | Bulk lookups (JSON body: `{"domains": [...]}`) |
| `GET /whois/{domain}` | WHOIS lookup |
| `GET /rdap/domain/{domain}` | RDAP domain |
| `GET /rdap/ip/{ip}` | RDAP IP |
| `GET /rdap/asn/{asn}` | RDAP ASN |
| `GET /dns/{domain}/{type}` | DNS query |
| `GET /propagation/{domain}/{type}` | Propagation check |
| `GET /status/{domain}` | Domain status |
| `POST /status/bulk` | Bulk status checks |

## Documentation

- Swagger: http://localhost:8000/docs
- ReDoc: http://localhost:8000/redoc
