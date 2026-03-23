# DKIM Record Analysis

DKIM public keys are published at `<selector>._domainkey.<domain>` as TXT records.

## Record Format

```
selector1._domainkey.example.com. IN TXT "v=DKIM1; k=rsa; p=MIGf..."
```

## Record Tags

| Tag | Required | Purpose | Values |
|-----|----------|---------|--------|
| `v` | Recommended | Version | `DKIM1` |
| `k` | Optional | Key type | `rsa` (default), `ed25519` |
| `p` | Required | Public key | Base64-encoded key; empty = revoked |
| `t` | Optional | Flags | `y` (testing), `s` (strict alignment) |
| `h` | Optional | Hash algorithms | `sha256` (recommended), `sha1` (deprecated) |
| `s` | Optional | Service type | `*` (all, default), `email` |
| `n` | Optional | Notes | Human-readable comment |

## Common DKIM Selectors by Provider

| Provider | Selector(s) |
|----------|-------------|
| Google Workspace | `google`, `20230601` (rotated) |
| Microsoft 365 | `selector1`, `selector2` |
| Amazon SES | Unique per identity (e.g., `224i4yxa5dv7c2xz...`) |
| Mailchimp | `k1`, `k2`, `k3` |
| SendGrid | `s1`, `s2` |
| Mailgun | `smtp._domainkey`, `mailo._domainkey` |
| ProtonMail | `protonmail`, `protonmail2`, `protonmail3` |
| Fastmail | `fm1`, `fm2`, `fm3` |
| Zoho | `zmail._domainkey` |

## Common Issues

1. **Missing public key** — `NXDOMAIN` at the selector means DKIM verification fails.
2. **Key too short** — RSA keys shorter than 1024 bits are considered weak. 2048-bit is the current best practice.
3. **Revoked key** — An empty `p=` tag means the key has been revoked. Signatures using this selector will fail.
4. **`t=y` still set** — The testing flag indicates the domain is still testing DKIM. Receivers may not enforce failures. Remove after deployment.
5. **Single selector** — Having only one active selector makes key rotation disruptive. Best practice is to publish two selectors and rotate.
