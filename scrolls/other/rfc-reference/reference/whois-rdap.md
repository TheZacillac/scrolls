# WHOIS & RDAP RFCs

| RFC | Title | Status | Summary |
|-----|-------|--------|---------|
| **3912** | WHOIS Protocol Specification | Standard | The original WHOIS protocol (port 43). Simple text query/response. No structured data. |
| **7480** | HTTP Usage in RDAP | Standard | How RDAP uses HTTP: URLs, content types (application/rdap+json), status codes, redirects. |
| **7481** | Security Services for RDAP | Standard | Authentication, authorization, and encryption for RDAP. TLS required. |
| **7482** | Registration Data Access Protocol (RDAP) Query Format | Standard | URL patterns: `/domain/`, `/nameserver/`, `/ip/`, `/entity/`, `/autnum/`. |
| **7483** | JSON Responses for RDAP | Standard | JSON response structure: objectClassName, handle, links, events, entities, remarks, notices. |
| **7484** | Finding the Authoritative RDAP Service | Standard | RDAP bootstrap: how to find the correct server using IANA bootstrap files. |
| **9082** | RDAP Query Format (updated) | Standard | Updates 7482 with additional query parameters, search patterns, and sorting. |
| **9083** | JSON Responses for RDAP (updated) | Standard | Updates 7483 with additional response fields, improved error handling, and conformance levels. |
