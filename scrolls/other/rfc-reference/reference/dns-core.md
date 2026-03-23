# DNS Core RFCs

| RFC | Title | Status | Summary |
|-----|-------|--------|---------|
| **1034** | Domain Names — Concepts and Facilities | Standard | Defines the DNS architecture: hierarchical namespace, zones, delegation, resolvers vs authoritative servers. The conceptual foundation for all DNS. |
| **1035** | Domain Names — Implementation and Specification | Standard | Wire protocol, message format, record types (A, NS, CNAME, SOA, MX, TXT, PTR), master file format. The original DNS implementation spec. |
| **2181** | Clarifications to the DNS Specification | Standard | Resolves ambiguities in 1034/1035. Key rules: CNAME cannot coexist with other types at same name; only one SOA and NS set per zone. |
| **3596** | DNS Extensions to Support IPv6 | Standard | Defines the AAAA record type for IPv6 addresses and updates to ip6.arpa for reverse DNS. |
| **4343** | Domain Name System Case Insensitivity Clarification | Standard | DNS names are case-insensitive for matching but case-preserving in storage. |
| **6891** | Extension Mechanisms for DNS (EDNS0) | Standard | Extends DNS message format beyond 512 bytes via OPT pseudo-record. Required for DNSSEC and modern DNS. |
| **8482** | Providing Minimal-Sized Responses to ANY Queries | Standard | Allows servers to decline `ANY` queries. Reduces amplification attack surface. |
| **8499** | DNS Terminology | Informational | Comprehensive glossary of DNS terms. Authoritative definitions for zone, delegation, glue, referral, etc. |
| **9460** | Service Binding and Parameter Specification via DNS (SVCB and HTTPS) | Standard | Defines SVCB and HTTPS record types for service endpoint discovery, ECH key distribution, and HTTPS upgrade signaling. |
