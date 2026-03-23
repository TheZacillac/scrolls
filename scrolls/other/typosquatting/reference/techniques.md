# Typosquatting Generation Techniques

## 1. Character Omission

Remove one character at a time from the domain label.

```
example.com → exampl.com, exmple.com, exaple.com, examle.com, exampe.com
```

Domains generated: `len(label) - 1` per omission position.

## 2. Character Swap (Adjacent Transposition)

Swap each pair of adjacent characters.

```
example.com → xeample.com, eaxmple.com, exmaple.com, exapmle.com, examlpe.com, exampel.com
```

## 3. Character Duplication

Double each character in the label.

```
example.com → eexample.com, exxample.com, exaample.com, exammple.com, exampple.com, examplle.com, examplee.com
```

## 4. Character Replacement (Keyboard Adjacency)

Replace each character with its keyboard neighbors.

QWERTY adjacency map (subset):
```
a → [q, w, s, z]      n → [b, h, j, m]
e → [w, r, d, s]      o → [i, p, l, k]
i → [u, o, k, j]      r → [e, t, d, f]
l → [k, o, p]         s → [a, w, d, z, x]
m → [n, j, k]         t → [r, y, f, g]
```

## 5. Character Insertion

Insert every possible character (a–z, 0–9) at every position. Generates many candidates.

## 6. Homoglyph Substitution

Replace characters with visually similar characters from Latin, Cyrillic, Greek, and other scripts.

| Original | Homoglyphs |
|----------|-----------|
| `a` | `а` (Cyrillic), `ɑ`, `à`, `á`, `â`, `ã`, `ä` |
| `c` | `с` (Cyrillic), `ϲ` (Greek), `ċ`, `ç` |
| `d` | `ԁ` (Cyrillic), `ɗ` |
| `e` | `е` (Cyrillic), `ė`, `é`, `è`, `ê`, `ë` |
| `g` | `ɡ`, `ġ` |
| `h` | `һ` (Cyrillic), `ħ` |
| `i` | `і` (Cyrillic), `í`, `ì`, `î`, `ï`, `ı` (dotless) |
| `j` | `ј` (Cyrillic) |
| `k` | `κ` (Greek), `к` (Cyrillic) |
| `l` | `ⅼ` (Roman numeral), `1`, `ӏ` (Cyrillic), `ĺ` |
| `m` | `м` (Cyrillic), `ṁ` |
| `n` | `ո` (Armenian), `ñ` |
| `o` | `о` (Cyrillic), `ο` (Greek), `0`, `ø`, `ö` |
| `p` | `р` (Cyrillic), `ρ` (Greek) |
| `q` | `ԛ` (Cyrillic) |
| `r` | `г` (Cyrillic), `ŗ` |
| `s` | `ѕ` (Cyrillic), `ś`, `ş` |
| `t` | `τ` (Greek), `ţ` |
| `u` | `υ` (Greek), `ú`, `ù`, `ü` |
| `v` | `ν` (Greek), `ⅴ` (Roman numeral) |
| `w` | `ω` (Greek), `ẃ`, `ẁ` |
| `x` | `х` (Cyrillic), `×` (multiplication sign) |
| `y` | `у` (Cyrillic), `ý`, `ÿ` |
| `z` | `ż`, `ź` |

**Note:** Many homoglyphs require IDN (Internationalized Domain Name) support via Punycode. Some registries restrict mixed-script registrations.

## 7. Bitsquatting

Single-bit errors in memory cause one character to flip to another. Target characters differ by one bit in ASCII.

| Original | Bitsquat variants |
|----------|------------------|
| `a` (0x61) | `c`, `e`, `i`, `q` |
| `e` (0x65) | `a`, `c`, `g`, `m`, `u` |
| `g` (0x67) | `c`, `e`, `f`, `o`, `w` |
| `l` (0x6C) | `d`, `h`, `m`, `n` |
| `m` (0x6D) | `e`, `i`, `l`, `o` |
| `o` (0x6F) | `g`, `k`, `m`, `n`, `w` |

## 8. TLD Swaps

Register the same label under different TLDs.

```
example.com → example.net, example.org, example.co, example.io, example.info,
              example.biz, example.xyz, example.app, example.dev, example.co.uk
```

Priority TLDs to check: `.com`, `.net`, `.org`, `.co`, `.io`, `.app`, `.dev`, `.info`, `.biz`, `.xyz`, `.me`, `.us`, `.uk`, `.co.uk`, `.de`, `.eu`, `.ca`, `.au`, `.com.au`

## 9. Dot Manipulation

```
example.com → ex.ample.com, exa.mple.com, exam.ple.com
example.com → examplecom.com (dot removal)
example.com → example.com.evil.com (subdomain of attacker)
```

## 10. Hyphen Manipulation

```
example.com → ex-ample.com, exam-ple.com
my-example.com → myexample.com, my--example.com
```

## 11. Singular/Plural & Common Misspellings

```
example.com → examples.com
google.com → gogle.com, googel.com, gooogle.com
amazon.com → amozon.com, amazn.com
```

## 12. Prefix/Suffix Additions

Common prefixes and suffixes attackers use:

```
example.com → myexample.com, theexample.com, getexample.com
example.com → example-login.com, example-secure.com, example-support.com
example.com → exampleonline.com, exampleapp.com, examplehq.com
```
