# Seer - Domain Name Utility

## What is Seer?

Seer is a domain intelligence toolkit for querying WHOIS, RDAP, DNS, and domain health information. It provides a CLI with an interactive REPL, a Rust library, Python bindings, a REST API, and an MCP server.

## Quick Start

```bash
cargo install seer-cli
seer lookup example.com
```

## Reference

- [CLI Commands](reference/cli.md) - Full command reference, exit codes, output formats, CSV columns
- [Configuration](reference/config.md) - Config file, environment variables
- [REST API](reference/api.md) - Endpoints and documentation
- [MCP Server](reference/mcp.md) - Setup and available tools
- [Python Library](reference/python.md) - Python bindings usage
- [Interactive REPL](reference/repl.md) - REPL features and commands

## Scripts

- [setup-completions.sh](scripts/setup-completions.sh) - Install shell completions (bash/zsh/fish)
- [examples.sh](scripts/examples.sh) - Scripting patterns: field extraction, exit codes, JSON piping
