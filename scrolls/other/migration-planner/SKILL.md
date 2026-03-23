# Migration Planner — DNS Provider Migration Workflows

## What is a Migration Planner?

DNS provider migration moves a domain's authoritative DNS from one provider to another. Mistakes cause downtime. This skill provides step-by-step workflows, pre-flight checks, and validation procedures using Seer for each phase.

## Migration Types

| Type | What Moves | Risk Level |
|------|-----------|------------|
| **DNS hosting** | Zone records to new DNS provider | Medium |
| **Registrar transfer** | Domain registration to new registrar | Medium |
| **Full migration** | Both registrar and DNS hosting | High |
| **Nameserver update** | Just NS records at registrar | Low |

**Golden rule:** Never migrate DNS hosting and registrar simultaneously.

## Reference

- [Migration Phases](reference/phases.md) — Five-phase workflow: audit, prepare, execute, validate, cleanup
- [Rollback & Pitfalls](reference/pitfalls.md) — Rollback plan and common mistakes to avoid

## Scripts

- [pre-migration-audit.sh](scripts/pre-migration-audit.sh) — Inventory all DNS records before migration
