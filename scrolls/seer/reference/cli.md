# Seer CLI Reference

## Quick Start

```bash
# Install
cargo install seer-cli

# Or run from source
cargo run --release -p seer-cli -- <command>
```

## Lookup Commands

```bash
# Smart lookup (concurrent RDAP + WHOIS, availability fallback)
seer lookup example.com

# WHOIS only
seer whois example.com

# RDAP (domains, IPs, ASNs)
seer rdap example.com
seer rdap 8.8.8.8
seer rdap AS15169
```

## DNS Commands

```bash
# Query DNS records (default: A)
seer dig example.com
seer dig example.com MX
seer dig example.com A -s @8.8.8.8    # Custom nameserver

# Check DNS propagation across 29 global servers
seer prop example.com
seer prop example.com AAAA

# Compare DNS records across two nameservers
seer compare example.com A 8.8.8.8 1.1.1.1

# Monitor DNS records over time
seer follow example.com                           # 10 checks, 1 min apart
seer follow example.com 20 0.5                    # 20 checks, 30s apart
seer follow example.com 10 1 MX --changes-only    # Only show changes

# Reverse DNS
seer reverse 8.8.8.8
```

## Utility Commands

```bash
# Check domain availability (exit code: 0=available, 1=taken)
seer avail example.com

# Check DNSSEC configuration (exit code: 0=secure, 1=not secure)
seer dnssec example.com

# Look up TLD info (WHOIS server, RDAP endpoint, registry)
seer tld .com
seer tld uk

# Enumerate subdomains via Certificate Transparency logs
seer subdomains example.com
```

## Status & SSL

```bash
# Full domain health (exit code: 0=healthy, 1=issues)
seer status example.com

# Inspect SSL certificate chain, SANs, and key details
seer ssl example.com
```

## Domain Comparison

```bash
# Compare two domains side-by-side (registration, DNS, SSL)
seer diff example.com google.com
```

## Monitoring

```bash
# Domain watchlist
seer watch add example.com        # Add domain
seer watch add google.com
seer watch list                   # Show watchlist
seer watch                        # Check all domains for expiring certs/registrations
seer watch remove example.com     # Remove domain

# Lookup history (persisted to ~/.seer/history.json)
seer history example.com          # Show past lookups for a domain
seer history                      # Show all domains with history
seer history --clear              # Clear history
```

## Bulk Operations

Process domains from a file, output to CSV:

```bash
seer bulk lookup domains.txt
seer bulk whois domains.txt
seer bulk rdap domains.txt
seer bulk dig domains.txt MX
seer bulk prop domains.txt
seer bulk status domains.txt
seer bulk avail domains.txt
seer bulk status domains.txt -o results.csv    # Custom output path
```

Input file format: one domain per line (# for comments), or CSV (first column).

## Output Formats

The `--format` flag goes **before** the subcommand:

```bash
seer --format json lookup example.com       # JSON
seer --format yaml dig example.com MX       # YAML
seer --format markdown status example.com   # Markdown
seer --format human lookup example.com      # Human-readable (default)
```

## Field Extraction (Scripting)

Use `--quiet` with `--fields` for scriptable output:

```bash
seer --quiet --fields registrar lookup example.com
seer --quiet --fields certificate.issuer status example.com
seer --quiet --fields available avail example.com
seer --quiet --fields registrar,expires lookup example.com   # Multiple fields
```

## DNS Record Types

`A`, `AAAA`, `MX`, `TXT`, `NS`, `SOA`, `CNAME`, `CAA`, `PTR`, `SRV`, `DNSKEY`, `DS`, `ANY`

## Exit Codes

| Command | Exit 0 | Exit 1 |
|---------|--------|--------|
| `avail` | Domain available | Domain taken |
| `status` | Healthy (HTTP 2xx, valid SSL, not expiring) | Any issue |
| `dnssec` | DNSSEC secure | Not secure |
| `compare` | Records match | Records differ |
| All others | Success | Error |

## CSV Output Columns

| Operation | Columns |
|-----------|---------|
| **status** | domain, success, http_status, http_status_text, title, ssl_issuer, ssl_valid_until, ssl_days_remaining, domain_expires, domain_days_remaining, registrar, dns_resolves, dns_a_records, dns_aaaa_records, dns_cname, dns_nameservers, duration_ms, error |
| **lookup/whois/rdap** | domain, success, registrar, created, expires, updated, duration_ms, error |
| **dig** | domain, success, record_type, records, duration_ms, error |
| **prop** | domain, success, propagation_pct, servers_total, servers_responded, duration_ms, error |
| **avail** | domain, success, available, confidence, method, details, duration_ms, error |
