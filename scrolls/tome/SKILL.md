# Tome - Domain Reference Database

## What is Tome?

Tome is a reference database for internet TLDs, DNS record types, and domain name terminology. It provides lookup and search across three knowledge bases: TLD information (registry, WHOIS/RDAP servers, registration rules), DNS record type definitions (format, RFCs, status), and a domain industry glossary. It offers a CLI, Python bindings, and a REST API.

## Quick Start

```bash
cargo install tome-cli
tome tld com
tome record MX
tome glossary registrar
tome search DNSSEC
```

## Capabilities

### TLD Database
- Look up any TLD: registry, type, WHOIS/RDAP servers, DNSSEC support
- Registration rules: restrictions, allowed countries, transfer requirements
- Period information: create/renew/transfer/redemption/grace periods
- Features: privacy protection, registry lock, restore support

### DNS Record Type Database
- Look up record types by name or IANA numeric code
- Definitions with rdata format, zone file examples, and related RFCs
- Status tracking: Active, Experimental, Obsolete, Reserved

### Glossary
- Domain industry terminology with abbreviations and descriptions
- Categories: DNS, Registration, Security, Abuse, Infrastructure, Protocol, General

## CLI Commands

```bash
tome tld <query>                         # Look up TLD (e.g., "com", ".uk")
tome record <query>                      # Look up record type by name or code
tome glossary <query>                    # Look up glossary term
tome search <query>                      # Cross-database search
tome list tlds [--type TYPE]             # List TLDs, optionally filtered
tome list records [--common]             # List record types
tome list glossary [--category CATEGORY] # List glossary terms
```

Global flag: `--format human|json|yaml|markdown`

## Python Library

```python
import tome

tome.tld_lookup("com")              # Returns dict or None
tome.tld_search("united")           # Returns list of dicts
tome.record_lookup("MX")            # By name or numeric code ("15")
tome.record_search("mail")          # Returns list of dicts
tome.glossary_lookup("registrar")
tome.glossary_search("DNSSEC")
```
