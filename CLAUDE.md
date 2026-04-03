# CLAUDE.md - Scrolls

Scrolls is a collection of AI agent skill definitions and reference documentation for the Arcanum Suite tools. It provides structured knowledge that Tower and Familiar load to give AI assistants context about Seer and Tome capabilities.

**No runtime dependencies.** Pure documentation package.

---

## Structure

```
scrolls/
├── pyproject.toml
└── scrolls/
    ├── __init__.py              # Python API for accessing skill files
    ├── seer/
    │   ├── SKILL.md             # Seer skill definition (what it does, quick start)
    │   ├── reference/
    │   │   ├── api.md           # REST API endpoints and usage
    │   │   ├── cli.md           # CLI command reference (all commands, flags, exit codes)
    │   │   ├── config.md        # Configuration file and environment variables
    │   │   ├── mcp.md           # MCP server setup and tool list
    │   │   ├── python.md        # Python library usage
    │   │   └── repl.md          # Interactive REPL commands and features
    │   └── scripts/
    │       ├── examples.sh      # CLI scripting patterns
    │       └── setup-completions.sh  # Shell completion installer
    └── tome/
        └── SKILL.md             # Tome skill definition (placeholder, empty)
```

---

## Python API

```python
import scrolls

scrolls.list_skills()                          # ['other/cdn-detection', 'other/email-auth', ..., 'seer', 'tome']
scrolls.skills_path()                          # Path to skills directory
scrolls.skill_path("seer")                     # Path to seer skill directory
scrolls.skill_file("seer")                     # Path to seer/SKILL.md
scrolls.skill_file("seer", "reference/cli.md") # Path to specific reference file
```

### How Skills Are Discovered

`list_skills()` returns sorted names of directories that:
- Contain a `SKILL.md` file
- Don't start with `_` or `.`

### Errors

- `FileNotFoundError` if skill or file doesn't exist

---

## Skill File Structure

Each skill directory follows this convention:

```
skillname/
├── SKILL.md             # Main definition: what it does, install, quick start
├── reference/           # Detailed documentation by interface
│   ├── cli.md           # CLI commands, flags, exit codes
│   ├── api.md           # REST API endpoints
│   ├── python.md        # Python library usage
│   ├── mcp.md           # MCP tool definitions
│   └── ...
└── scripts/             # Helper scripts and examples
    └── ...
```

---

## Seer Reference Documentation

The seer skill contains comprehensive reference docs covering:

**cli.md** — Full CLI command reference:
- Lookup: `seer lookup`, `seer whois`, `seer rdap`
- DNS: `seer dig`, `seer prop`, `seer compare`, `seer follow`, `seer reverse`
- Utility: `seer avail`, `seer dnssec`, `seer tld`, `seer subdomains`
- Status: `seer status`, `seer ssl`
- Comparison: `seer diff`
- Monitoring: `seer watch`, `seer history`
- Bulk: `seer bulk lookup|whois|rdap|dig|prop|status|avail`
- Output: `--format human|json|yaml|markdown`, `--quiet --fields`
- Exit codes per command

**api.md** — REST API reference:
- All endpoints with methods and paths
- Swagger at `/docs`, ReDoc at `/redoc`

**config.md** — Configuration:
- `~/.seer/config.toml` format and defaults
- Timeout, bulk, output settings
- Environment variables: `RUST_LOG`, `SEER_CORS_ORIGINS`, `SEER_RATE_LIMIT`

**mcp.md** — MCP server:
- 13 available tools
- Claude Desktop configuration

**python.md** — Python library:
- All functions with examples
- Single and bulk operations

**repl.md** — Interactive REPL:
- All REPL commands
- Tab completion, history, session management

---

## How Scrolls Is Used

### By Tower (MCP server)
- Installed as dependency
- Scrolls content available for AI assistants via skill definitions

### By Familiar (AI agent)
- Loads skill documentation at startup via `scrolls.list_skills()` and `scrolls.skill_file()`
- Reads all reference docs from each skill's `reference/` directory
- Merges documentation into the agent's system prompt

---

## Build & Install

```bash
pip install -e .
```

Build uses Hatchling. The `[tool.hatch.build.targets.wheel.force-include]` ensures all skill files (markdown, scripts) are packaged in the wheel.

---

## Adding a New Skill

1. Create `scrolls/newskill/SKILL.md` with overview, install, quick start
2. Add `reference/` directory with per-interface documentation
3. Add `scripts/` directory with helper scripts (optional)
4. The skill will be auto-discovered by `list_skills()`

---

## Conventions

- SKILL.md is the entry point — keep it concise (what, install, quick start, reference links)
- Reference docs should be complete and self-contained per interface
- Scripts should be documented and executable
- All content is designed for AI agent consumption — be precise about parameters, types, and return values
