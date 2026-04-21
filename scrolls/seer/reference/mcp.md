# Seer MCP Server

## Quick Start

```bash
seer-mcp    # Runs on stdio
```

## Claude Desktop Configuration

Add to `claude_desktop_config.json`:

```json
{
  "mcpServers": {
    "seer": {
      "command": "seer-mcp"
    }
  }
}
```

## Available Tools

15 tools over stdio transport:

**Single-domain:** `seer_lookup`, `seer_info`, `seer_whois`,
`seer_rdap_domain`, `seer_rdap_ip`, `seer_rdap_asn`, `seer_dig`,
`seer_propagation`, `seer_status`

**Bulk:** `seer_bulk_lookup`, `seer_bulk_info`, `seer_bulk_whois`,
`seer_bulk_dig`, `seer_bulk_propagation`, `seer_bulk_status`

## Notes

- `seer_info` merges RDAP + WHOIS into a flat field set. Prefer it over
  `seer_lookup` when you want both sources combined.
- Bulk tools accept up to 100 domains and cap concurrency at 50.
- MCP tools share the same SSRF guard as the REST API.
