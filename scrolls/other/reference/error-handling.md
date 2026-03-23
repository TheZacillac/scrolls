# Error Handling & Resilience Guide

This guide teaches AI agents how to handle tool failures, partial results, and unexpected responses gracefully. The goal is to always make progress toward the user's objective, even when individual tool calls fail.

---

## Core Principles

1. **Never give up on a single failure.** One failed tool call does not mean the task is impossible. Try alternative approaches.
2. **Report what you found, not what you didn't.** Partial results are valuable. Present what succeeded and note what couldn't be retrieved.
3. **Distinguish between "no data" and "error."** A domain with no MX records is a valid finding. A timeout is an error. Treat them differently.
4. **Degrade gracefully.** If the ideal approach fails, use a simpler one. Some information is better than none.
5. **Be transparent about limitations.** Tell the user when results are incomplete and why.

---

## Seer Tool Error Patterns

### Exit Codes

Seer uses semantic exit codes — a non-zero exit does NOT always mean error:

| Tool | Exit 0 | Exit 1 |
|------|--------|--------|
| `seer avail` | Domain is available | Domain is taken |
| `seer dnssec` | DNSSEC is valid | DNSSEC not enabled/invalid |
| `seer status` | Domain is healthy | Domain has issues |
| `seer compare` | Records match | Records differ |
| All others | Success | Error |

**Key:** For `avail`, `dnssec`, `status`, and `compare`, exit code 1 is a **valid result**, not an error.

### Common Errors and What to Do

| Error | Likely Cause | Recovery Strategy |
|-------|-------------|-------------------|
| **Timeout** | Network issue or slow server | Try again once. If still failing, skip this check and note it as "unavailable." |
| **NXDOMAIN** | Domain doesn't exist in DNS | This IS a finding — the domain has no DNS records. Report it as such. |
| **Connection refused** | WHOIS/RDAP server down | Fall back to alternative: if WHOIS fails, try RDAP (or vice versa). Use `seer lookup` which tries both. |
| **Rate limited** | Too many queries to one server | Reduce concurrency. For bulk ops, use smaller batches. |
| **No records found** | Record type doesn't exist for this domain | This is valid data — e.g., no AAAA means no IPv6. Report the absence. |
| **Parse error** | Malformed server response | Try an alternative source. WHOIS responses vary widely; RDAP is more structured. |
| **Empty WHOIS** | Privacy service or registry restriction | Try RDAP instead (`seer rdap`). Note that data may be redacted under GDPR. |

### Bulk Operation Failures

Bulk operations return per-domain `success` and `error` fields:

```json
{"domain": "example.com", "success": true, "registrar": "..."}
{"domain": "failing.com", "success": false, "error": "timeout"}
```

**Strategy:**
- Process and report all successful results
- Collect failed domains and retry them individually
- If retries also fail, report results for the domains that succeeded and list failures separately

---

## Fallback Chains

When the preferred tool fails, try alternatives in order:

### Domain Registration Data
1. `seer lookup` (tries RDAP + WHOIS concurrently with availability fallback)
2. `seer rdap` (structured JSON, preferred)
3. `seer whois` (raw text, wider coverage)
4. `seer avail` (at minimum, determine if domain is registered)

### DNS Records
1. `seer dig <domain> <type>` (specific record type)
2. `seer dig <domain> ANY` (all records — may be refused by some servers, RFC 8482)
3. `seer prop <domain> <type>` (try multiple global resolvers if primary fails)

### Domain Health
1. `seer status` (comprehensive check)
2. Individual checks: `seer dig` + `seer ssl` + `seer dnssec` (if status fails, try components separately)

### Email Authentication
1. `seer dig <domain> TXT` for SPF
2. `seer dig _dmarc.<domain> TXT` for DMARC
3. Try multiple DKIM selectors — if first selector fails, try others (google, selector1, selector2, default, s1, s2, k1, fm1, protonmail)
4. No DKIM selector found ≠ error — it may use a non-standard selector name

---

## Handling "No Data" vs "Error"

### These are valid findings (not errors):

| Result | Meaning |
|--------|---------|
| No MX records | Domain doesn't receive email (check for null MX) |
| No AAAA records | No IPv6 support |
| No CAA records | No certificate authority restrictions |
| No DMARC record | Email authentication gap (reportable finding) |
| No DNSSEC | Zone is unsigned (reportable finding) |
| WHOIS data redacted | GDPR privacy protection (normal) |
| Domain not registered | Available for registration (valid answer) |
| CNAME target doesn't resolve | Dangling CNAME — this is a security finding |

### These are errors (retry or fall back):

| Result | Action |
|--------|--------|
| Network timeout | Retry once, then note as unavailable |
| Connection refused | Try alternative tool/protocol |
| Rate limited | Wait briefly, reduce batch size |
| Server error (500) | Try alternative source |
| Invalid response / parse failure | Try alternative tool |

---

## Multi-Step Workflow Resilience

When running multi-step workflows (audits, migrations, portfolio checks), failures in one step should not block subsequent steps.

### Example: Zone Health Audit

```
Step 1: SOA record     → ✓ success
Step 2: NS records     → ✓ success
Step 3: MX records     → ✗ timeout
Step 4: TXT records    → ✓ success
Step 5: DNSSEC         → ✓ success
Step 6: CAA records    → ✓ success
```

**Correct behavior:** Complete steps 4–6 despite step 3 failing. Report:
- Results for steps 1, 2, 4, 5, 6
- Note that MX check could not be completed (timeout)
- Offer to retry the MX check

**Wrong behavior:** Stop at step 3 and tell the user the audit failed.

### Example: Portfolio Audit

If 8 of 10 domains succeed in a bulk lookup:
- Present the 8 successful results
- List the 2 failures with error reasons
- Offer to retry the failures individually

---

## Reporting Incomplete Results

When results are partial, use this pattern:

```
## Results

[Present all successful findings normally]

## Incomplete Checks

The following checks could not be completed:
- **MX records for example.com**: timed out (the DNS server did not respond)
- **WHOIS for example.net**: connection refused (WHOIS server may be temporarily unavailable)

These gaps do not affect the other findings. I can retry these checks if you'd like.
```

---

## Confidence Levels

When combining signals from multiple tools, express confidence:

| Confidence | When to Use | Language |
|------------|-------------|----------|
| **High** | Multiple independent signals agree | "The domain is..." |
| **Medium** | Some signals present, some missing | "Based on available data, the domain appears to..." |
| **Low** | Key checks failed, limited data | "With limited data available, it's possible that..." |
| **Inconclusive** | Critical checks failed | "I couldn't determine X because [specific failures]. To answer this, I would need..." |

---

## Retry Guidelines

| Scenario | Retries | Backoff |
|----------|---------|---------|
| Network timeout | 1 retry | Immediate |
| Rate limited | 1–2 retries | 2–5 seconds |
| Server error | 1 retry | Immediate |
| DNS SERVFAIL | 1 retry with different resolver (`seer prop`) | Immediate |
| Parse error | 0 retries — try alternative tool instead | — |
| NXDOMAIN | 0 retries — this is a definitive answer | — |
| Connection refused | 0 retries — try alternative protocol | — |

**Never retry more than twice for the same operation.** If two attempts fail, move on and report the gap.
