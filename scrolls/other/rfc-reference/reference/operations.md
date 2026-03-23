# DNS Operations & Best Practices RFCs

| RFC | Title | Status | Summary |
|-----|-------|--------|---------|
| **1912** | Common DNS Operational and Configuration Errors | Informational | Classic list of DNS mistakes: missing PTR records, CNAME chains, lame delegations, incorrect SOA values. |
| **2308** | Negative Caching of DNS Queries | Standard | How negative responses (NXDOMAIN, NODATA) are cached. SOA minimum field controls negative TTL. |
| **5936** | DNS Zone Transfer Protocol (AXFR) | Standard | Full zone transfer between primary and secondary DNS servers. |
| **1996** | Mechanism for Prompt Notification of Zone Changes (DNS NOTIFY) | Standard | Primary notifies secondaries when zone data changes, triggering immediate transfer. |
| **2136** | Dynamic Updates in DNS (DNS UPDATE) | Standard | Dynamically adding/deleting records without editing zone files. Used by DHCP, Let's Encrypt DNS-01. |
| **6698** | The DNS-Based Authentication of Named Entities (DANE) TLSA Record | Standard | TLSA record: pins TLS certificates to DNS (DNSSEC-secured). Alternative to CA trust model. |
| **7766** | DNS Transport over TCP | Standard | TCP is a first-class DNS transport, not just a fallback. Required for large responses. |
| **7858** | Specification for DNS over TLS (DoT) | Standard | DNS queries encrypted with TLS on port 853. Prevents eavesdropping. |
| **8484** | DNS Queries over HTTPS (DoH) | Standard | DNS queries over HTTPS (port 443). Greater privacy, harder to block/filter. |
| **9250** | DNS over Dedicated QUIC Connections (DoQ) | Standard | DNS over QUIC. Combines DoT's privacy with QUIC's performance (0-RTT, multiplexing). |
| **8659** | DNS Certification Authority Authorization (CAA) | Standard | CAA record: `issue`, `issuewild`, `iodef` tags. CAs must check before issuing certificates. |
