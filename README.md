# Lattiq Observe — Daily Merkle Root Transparency Log

This repository publishes the daily Merkle roots of every cryptographically signed
observation receipt issued by [Lattiq Observe](https://botrite.lattiq.ai).

It is the **public, customer-verifiable record** of what we observed and when.

## What's here

- `YYYY/MM/DD/root.txt` — the day's Merkle root (64 hex chars)
- `YYYY/MM/DD/leaf_hashes.txt` — one RFC 6962 leaf hash per line, sorted; each line
  is `sha256(0x00 || canonical_bytes)` for one receipt. Per-receipt content is NOT
  published; customers hold their own canonical receipts and look up their leaf hash here.
- `YYYY/MM/DD/meta.json` — signed metadata: date, leaf count, tree root, prev day's root,
  source format, dogfood-catalog snapshot SHA256, and per-reason exclusion counts.
- `YYYY/MM/DD/meta.json.sig` — base64 ed25519 signature over canonical-JSON `meta.json`
- `YYYY/MM/DD/ots/root.txt.ots` — OpenTimestamps proof anchoring the root in Bitcoin
- `keys/` — the ed25519 public keys used to verify receipts and merkle metadata

## Verify a receipt offline

```bash
# Clone this repo (one-time):
git clone https://github.com/Botrite/observe-merkle-log
cd observe-merkle-log

# Verify your receipt against a specific day:
lattiq-verify --receipt /path/to/your/receipt.json \
              --against-merkle 2026-04-29 \
              --merkle-mirror .
```

You should see `MERKLE INCLUSION VALID — leaf <N> of <total> on 2026-04-29`.

## Walk the chain

Verify that every daily root from one date to another is signed and chains
correctly:

```bash
lattiq-verify --merkle-chain 2026-04-29..2026-05-05 --merkle-mirror .
```

## Verify the OpenTimestamps anchor

Each daily root is anchored to the Bitcoin blockchain via OpenTimestamps. To
verify the timestamp:

```bash
ots verify 2026/04/29/ots/root.txt.ots
```

## What this proves

- A receipt's existence in our published log on a specific UTC day (inclusion proof).
- The order of days (chain link).
- The cumulative count of receipts since launch (advisory — full truncation detection requires walking the chain end-to-end).
- The Bitcoin block-confirmed time at which a daily root was anchored (non-antedating).

## What this does NOT prove

- Same-day fabrication before the daily checkpoint freeze (the OpenTimestamps anchor proves non-antedating *after* a daily root is anchored, but does NOT prevent fabrication during the in-flight day; closed cleanly by Approach B's append-only log).
- Compromise of our cron host or signing key (separate trust roots — see `keys/`).
- Cross-day cryptographic consistency proofs (a future evolution of this log will add RFC 6962 consistency proofs).

See the 'What this does NOT prove' section above for the honest gap list.

## Operator

Lattiq, LLC (Wyoming) operating subsidiary Botrite Operations, LLC (Maryland).
Contact: contact@botrite.lattiq.ai.
