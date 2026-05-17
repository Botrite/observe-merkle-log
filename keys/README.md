# Lattiq signing keys

This directory contains the ed25519 public keys used to verify Lattiq Observe
artifacts.

## Active keys

| key_id | algorithm | purpose | valid_from | valid_until |
|---|---|---|---|---|
| `lattiq-1` | ed25519 | observe-receipt-signing | 2026-04-26T00:00:00Z | (active) |
| `lattiq-merkle-2` | ed25519 | observe-merkle-log-signing | 2026-05-16T23:22:02Z | (active) |

Each key is a separate trust root with an independent rotation schedule.
Compromise of one does NOT compromise the other (Sigstore Rekor/Fulcio pattern;
NIST SP 800-53 AC-5).

## Key rotation log

The Day-0 Merkle trust root is `lattiq-merkle-2`. No prior Merkle root has
signed a production daily root — `lattiq-merkle-2` is the first published
key for the Merkle log.
