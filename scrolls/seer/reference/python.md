# Seer Python Library

```python
import seer

# Core lookups
result = seer.lookup("example.com")               # RDAP-first, WHOIS fallback
info = seer.info("example.com")                   # Merged RDAP + WHOIS (flat fields)
whois = seer.whois("example.com")
rdap = seer.rdap_domain("example.com")
rdap = seer.rdap_auto("8.8.8.8")                  # Auto-route: domain/IP/ASN
rdap_ip = seer.rdap_ip("8.8.8.8")
rdap_asn = seer.rdap_asn(15169)
dns = seer.dig("example.com", record_type="MX")
prop = seer.propagation("example.com", record_type="A")
status = seer.status("example.com")

# Availability, SSL, DNSSEC
avail = seer.availability("example.com")
ssl_report = seer.ssl("example.com")
dnssec_report = seer.dnssec("example.com")

# Subdomain enumeration (Certificate Transparency logs)
subs = seer.subdomains("example.com")

# DNS comparison between nameservers
cmp = seer.dns_compare("example.com", "A", "8.8.8.8", "1.1.1.1")

# DNS change monitoring over time
follow = seer.dns_follow("example.com", record_type="A", iterations=3, interval_minutes=1.0)
seer.cancel_follow()    # Cancel an in-flight dns_follow from another thread

# Domain-to-domain diff (registration, DNS, SSL)
delta = seer.diff("example.com", "example.org")

# Bulk operations
results = seer.bulk_lookup(["example.com", "google.com"], concurrency=10)
results = seer.bulk_info(["example.com", "google.com"], concurrency=10)
results = seer.bulk_whois(["example.com", "google.com"], concurrency=10)
results = seer.bulk_dig(["example.com", "google.com"], record_type="A", concurrency=10)
results = seer.bulk_propagation(["example.com", "google.com"], record_type="A", concurrency=5)
results = seer.bulk_status(["example.com", "google.com"], concurrency=10)
results = seer.bulk_availability(["example.com", "google.com"], concurrency=10)
```

## SSRF helper

For integrations that accept user-supplied hosts (e.g. custom
nameservers), validate them before use:

```python
seer.validate_public_host("example.com", 443)    # raises ValueError on reserved/private
```

Rejects loopback, link-local, private, multicast, reserved, and
non-globally-routable addresses — whether passed as an IP literal or a
hostname that resolves to one.

## Notes

- All functions are synchronous; the underlying Tokio runtime is a
  process-wide singleton.
- Errors raise `RuntimeError` (network/parse) or `ValueError` (invalid
  input).
- Bulk functions return a list of per-domain result dicts; failures are
  captured in-band rather than raised.
