# DNSSEC RFCs

| RFC | Title | Status | Summary |
|-----|-------|--------|---------|
| **4033** | DNS Security Introduction and Requirements | Standard | Overview of DNSSEC: threat model, chain of trust concept, authenticated denial of existence. |
| **4034** | Resource Records for DNS Security Extensions | Standard | Defines DNSKEY, RRSIG, NSEC, and DS record types. |
| **4035** | Protocol Modifications for DNS Security Extensions | Standard | How resolvers validate DNSSEC signatures, chain of trust from root to leaf, and how servers serve signed zones. |
| **5155** | DNS Security (DNSSEC) Hashed Authenticated Denial of Existence | Standard | Defines NSEC3 — hashed version of NSEC that prevents zone enumeration/walking. |
| **6781** | DNSSEC Operational Practices, Version 2 | Informational | Practical guidance: key management, rollovers, signing strategies, troubleshooting. |
| **8624** | Algorithm Implementation Requirements and Usage Guidance for DNSSEC | Standard | Which algorithms to use. Recommends ECDSAP256SHA256 (13) and ED25519 (15). |
| **9276** | Guidance for NSEC3 Parameter Settings | Best Current Practice | Recommends NSEC3 iterations=0 and no salt for performance. |
