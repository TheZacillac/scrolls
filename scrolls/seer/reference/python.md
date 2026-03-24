# Seer Python Library

```python
import seer

# Core lookups
result = seer.lookup("example.com")
whois = seer.whois("example.com")
rdap = seer.rdap_domain("example.com")
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

# Domain-to-domain diff (registration, DNS, SSL)
delta = seer.diff("example.com", "example.org")

# Bulk operations
results = seer.bulk_lookup(["example.com", "google.com"], concurrency=10)
results = seer.bulk_whois(["example.com", "google.com"], concurrency=10)
results = seer.bulk_dig(["example.com", "google.com"], record_type="A", concurrency=10)
results = seer.bulk_propagation(["example.com", "google.com"], record_type="A", concurrency=5)
results = seer.bulk_status(["example.com", "google.com"], concurrency=10)
```
