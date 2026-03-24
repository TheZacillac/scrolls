# Seer Python Library

```python
import seer

result = seer.lookup("example.com")
whois = seer.whois("example.com")
rdap = seer.rdap_domain("example.com")
dns = seer.dig("example.com", record_type="MX")
prop = seer.propagation("example.com", record_type="A")
status = seer.status("example.com")

# Bulk
results = seer.bulk_lookup(["example.com", "google.com"], concurrency=10)
results = seer.bulk_whois(["example.com", "google.com"], concurrency=10)
results = seer.bulk_dig(["example.com", "google.com"], record_type="A", concurrency=10)
results = seer.bulk_propagation(["example.com", "google.com"], record_type="A", concurrency=5)
results = seer.bulk_status(["example.com", "google.com"], concurrency=10)
```
