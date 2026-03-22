# Scrolls

**A collection of skills for working with domain names, designed for use with AI agents.**

Scrolls is a sister project to [Seer](https://github.com/TheZacillac/seer) and [Tome](https://github.com/TheZacillac/tome). It provides skill definitions, reference documentation, and helper scripts that give AI agents contextual knowledge about these tools.

Scrolls is installed automatically as a dependency of [Tower](https://github.com/TheZacillac/tower).

---

## Installation

```bash
pip install -e .
```

Or as part of a Tower installation:

```bash
pip install -e /path/to/tower
```

## Usage

```python
import scrolls

# List available skills
scrolls.list_skills()          # ['seer', 'tome']

# Get paths to skill files
scrolls.skills_path()          # Path to the skills directory
scrolls.skill_path("seer")    # Path to the seer skill directory
scrolls.skill_file("seer")    # Path to seer/SKILL.md
scrolls.skill_file("seer", "reference/cli.md")  # Path to a specific reference file
```

## Skills

| Skill | Description |
|-------|-------------|
| **[seer](scrolls/seer/SKILL.md)** | Domain intelligence toolkit — WHOIS, RDAP, DNS, status, SSL, bulk operations |
| **[tome](scrolls/tome/SKILL.md)** | Reference database — TLDs, DNS record types, glossary |

## License

MIT License — Copyright (c) 2026 Zac Roach
