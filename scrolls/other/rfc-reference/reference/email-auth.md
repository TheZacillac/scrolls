# Email Authentication RFCs

| RFC | Title | Status | Summary |
|-----|-------|--------|---------|
| **7208** | Sender Policy Framework (SPF) | Standard | SPF record syntax (`v=spf1`), mechanisms (ip4, include, a, mx), qualifiers, 10 DNS lookup limit, evaluation algorithm. |
| **6376** | DomainKeys Identified Mail (DKIM) Signatures | Standard | DKIM signature format, canonicalization, key records (`v=DKIM1`), signing and verification. |
| **7489** | Domain-based Message Authentication, Reporting, and Conformance (DMARC) | Informational | DMARC policy records (`v=DMARC1`), alignment, policies (none/quarantine/reject), reporting. |
| **7601** | Message Header Field for Indicating Message Authentication Status | Standard | The `Authentication-Results` header showing SPF, DKIM, and DMARC results. |
| **8301** | Cryptographic Algorithm and Key Usage Update to DKIM | Standard | Deprecates SHA-1 for DKIM. Requires SHA-256. Recommends RSA keys ≥ 1024 bits (2048 preferred). |
| **8463** | A New Cryptographic Signature Method for DKIM | Standard | Adds Ed25519-SHA256 as a DKIM signing algorithm. Smaller keys, faster verification. |
| **8616** | Email Authentication for Internationalized Mail | Standard | How SPF, DKIM, and DMARC work with internationalized email addresses (EAI) and domain names (IDN). |
| **8617** | The Authenticated Received Chain (ARC) | Experimental | ARC preserves authentication results across forwarding hops. Three headers: ARC-Seal, ARC-Message-Signature, ARC-Authentication-Results. |
| **7505** | A "Null MX" No Service Resource Record | Standard | `0 .` MX record indicating a domain does not accept email. |
