# Migration Rollback & Common Pitfalls

## Rollback Plan

### Quick Rollback (NS not yet propagated)

1. Revert NS records at registrar to old provider's nameservers
2. Old provider still has the zone — traffic returns as NS propagates back

### Partial Rollback (NS partially propagated)

1. Revert NS at registrar
2. Ensure old zone is still intact and serving correct records
3. Monitor with `seer prop example.com NS` until old NS is fully restored

### No Rollback Possible (old zone deleted)

1. Ensure new zone has all correct records
2. Fix any discrepancies at the new provider
3. Monitor and resolve issues in place

**Rule:** Keep the old zone active for at least 7 days after migration.

## Common Pitfalls

| Pitfall | Consequence | Prevention |
|---------|-------------|-----------|
| Forgetting MX records | Email stops working | Inventory all record types before migration |
| Missing DKIM selectors | DKIM validation fails | Check all `*._domainkey` records |
| Not lowering TTLs | Slow propagation, extended risk | Lower TTLs 24–48h before |
| Breaking DNSSEC chain | DNS resolution fails entirely | Disable DNSSEC first or pre-publish keys |
| Deleting old zone too early | No rollback possible | Keep old zone 7+ days |
| Migrating during business hours | Higher impact if issues | Schedule for low-traffic window |
| Forgetting glue records | NS resolution breaks | Check if NS hostnames are in-zone |
| Ignoring CAA records | New SSL certs may fail to issue | Replicate CAA records |
