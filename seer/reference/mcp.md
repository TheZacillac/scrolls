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

`seer_lookup`, `seer_whois`, `seer_rdap_domain`, `seer_rdap_ip`, `seer_rdap_asn`, `seer_dig`, `seer_propagation`, `seer_status`, `seer_bulk_lookup`, `seer_bulk_whois`, `seer_bulk_dig`, `seer_bulk_status`, `seer_bulk_propagation`
