# Domain Transfers

## Inter-Registrar Transfer Policy

### Requirements

| Requirement | Detail |
|------------|--------|
| **Auth code** | Registrant must obtain EPP authorization code from current registrar |
| **Unlock** | `clientTransferProhibited` must be removed |
| **60-day lock** | Cannot transfer within 60 days of initial registration |
| **60-day lock (change)** | Cannot transfer within 60 days of a registrant contact change |
| **Admin email** | Transfer approval/denial sent to registrant email on file |
| **Auto-approve** | If losing registrar doesn't respond within 5 days, transfer auto-approves |

### Transfer Process

1. Registrant unlocks domain at losing registrar
2. Registrant obtains auth/EPP code
3. Registrant initiates transfer at gaining registrar (provides auth code)
4. Gaining registrar sends transfer request to registry
5. Losing registrar notified — has 5 days to approve/deny
6. If no response in 5 days, transfer auto-approves
7. Domain transferred; 1-year renewal added

### Valid Denial Reasons

- Fraud / dispute evidence
- UDRP action in progress
- Court order
- Domain in Redemption or Pending Delete
- Within 60 days of initial registration
- Within 60 days of previous transfer
- Registrant explicitly requested denial
- Nonpayment for a previous registration period
- Domain status prohibits transfer

### Invalid Denial Reasons

Registrars **must not** deny transfers because:
- Domain is about to expire
- Bulk/wholesale pricing disagreements
- Registrant hasn't purchased additional services
- General unwillingness to lose the domain

## Change of Registrant

When the domain registrant (owner) changes:

1. Both old and new registrant must confirm the change
2. 60-day inter-registrar transfer lock applied (unless both opt out)
3. Registrar must verify identity of both parties
4. Applies when modifying: registrant name, organization, or email
