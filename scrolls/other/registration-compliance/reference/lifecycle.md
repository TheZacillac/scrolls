# Domain Lifecycle & Status Codes

## EPP Status Codes (RFC 5731)

### Client-set (by registrar)

| Status | Meaning |
|--------|---------|
| `clientDeleteProhibited` | Registrar prevents deletion |
| `clientHold` | Registrar suspended DNS resolution |
| `clientRenewProhibited` | Registrar prevents renewal |
| `clientTransferProhibited` | Registrar prevents transfer |
| `clientUpdateProhibited` | Registrar prevents WHOIS/NS changes |

### Server-set (by registry)

| Status | Meaning |
|--------|---------|
| `serverDeleteProhibited` | Registry prevents deletion |
| `serverHold` | Registry suspended DNS resolution |
| `serverRenewProhibited` | Registry prevents renewal |
| `serverTransferProhibited` | Registry prevents transfer |
| `serverUpdateProhibited` | Registry prevents changes |

### Standard Statuses

| Status | Meaning |
|--------|---------|
| `ok` | Normal, no pending operations |
| `addPeriod` | Within Add Grace Period after initial registration |
| `autoRenewPeriod` | Auto-renewed, within Auto-Renew Grace Period |
| `inactive` | Registered but no NS delegated |
| `pendingCreate` | Registration in progress |
| `pendingDelete` | Scheduled for deletion |
| `pendingRenew` | Renewal in progress |
| `pendingRestore` | Restore requested, pending completion |
| `pendingTransfer` | Transfer in progress |
| `pendingUpdate` | Update in progress |
| `redemptionPeriod` | Expired and in redemption (can be restored at higher cost) |
| `renewPeriod` | Within Renew Grace Period |
| `transferPeriod` | Within Transfer Grace Period |

## Lifecycle Timeline

```
Registration → Active → Expiration → Grace → Redemption → Pending Delete → Available
     │           │          │          │          │               │
     │           │          │          │          │               └─ 5 days
     │           │          │          │          └─ 30 days (restore ~$80–200)
     │           │          │          └─ 0–45 days (varies by registrar)
     │           │          └─ Registration period ends
     │           └─ 1–10 years
     └─ Initial registration
```

## Grace Periods (gTLDs)

| Period | Duration | What Happens |
|--------|----------|-------------|
| **Add Grace Period** | 5 days after registration | Full refund if deleted |
| **Renew Grace Period** | 5 days after explicit renewal | Renewal can be reversed |
| **Auto-Renew Grace Period** | 0–45 days after auto-renewal | Registrar-specific |
| **Transfer Grace Period** | 5 days after transfer | Transfer can be reversed |
| **Redemption Period** | 30 days after deletion | Domain can be restored ($80–200) |
| **Pending Delete** | 5 days after redemption | Domain being purged, no recovery |

**Note:** ccTLDs have their own lifecycle rules that may differ significantly.
