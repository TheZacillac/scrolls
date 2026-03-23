# Registration Data & ICANN Policies

## RDAP vs WHOIS

| Aspect | WHOIS | RDAP |
|--------|-------|------|
| **Protocol** | Port 43, plaintext | HTTPS, JSON |
| **Standard** | RFC 3912 (minimal) | RFC 7480–7484 |
| **Structured data** | No (free-text) | Yes (JSON) |
| **Authentication** | None | Supports auth |
| **Rate limiting** | Varies | Standardized |
| **ICANN mandate** | Being sunset | Required for gTLDs |

## Thick vs Thin WHOIS

| Model | Data at Registry | Data at Registrar |
|-------|-----------------|-------------------|
| **Thick** | Full registrant data | Full registrant data |
| **Thin** | Only registrar reference | Full registrant data |

As of 2024, ICANN requires thick WHOIS for `.com` and `.net`.

## GDPR Impact

| Field | Pre-GDPR | Post-GDPR (typical) |
|-------|----------|---------------------|
| Registrant name | Shown | `REDACTED FOR PRIVACY` |
| Registrant org | Shown | May be shown |
| Registrant email | Shown | Anonymized or `REDACTED` |
| Admin/Tech contact | Shown | `REDACTED FOR PRIVACY` |
| Registrant address | Shown | Country/state only |
| Phone | Shown | `REDACTED` |

Full data available via ICANN's SSAD for legitimate purposes (law enforcement, IP enforcement, security research).

## Registration Periods

| TLD Type | Minimum | Maximum | Increment |
|----------|---------|---------|-----------|
| Most gTLDs | 1 year | 10 years | 1 year |
| `.com`, `.net`, `.org` | 1 year | 10 years | 1 year |
| `.uk` | 1 year | 10 years | 1 year |
| `.de` | 1 year | 1 year | 1 year (annual) |
| `.au` | 1 year | 5 years | 1 year |

## Key ICANN Policies

| Policy | Scope | Summary |
|--------|-------|---------|
| **Transfer Policy** | gTLDs | Rules for inter-registrar transfers |
| **UDRP** | gTLDs + some ccTLDs | Trademark-based dispute resolution |
| **URS** | New gTLDs | Rapid suspension for clear infringement |
| **WDRP** | gTLDs | Annual registrant data accuracy reminder |
| **AGP** | gTLDs | 5-day refund window after registration |
| **ERRP** | gTLDs | Lifecycle rules for expired domains |
| **RAA** | ICANN-accredited registrars | Registrar obligations |
| **Registry Agreement** | Registry operators | Registry operator obligations |
| **Temporary Specification** | gTLDs | WHOIS data redaction (GDPR) |
