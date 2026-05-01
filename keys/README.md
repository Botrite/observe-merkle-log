# Lattiq signing keys

This directory contains the ed25519 public keys used to verify Lattiq Observe
artifacts.

## Active keys

| key_id | algorithm | purpose | valid_from | valid_until |
|---|---|---|---|---|
| `lattiq-1` | ed25519 | observe-receipt-signing | 2026-04-26T00:00:00Z | (active) |
| `lattiq-merkle-1` | ed25519 | observe-merkle-log-signing | 2026-04-30T02:28:27Z | (active) |

Each key is a separate trust root with an independent rotation schedule.
Compromise of one does NOT compromise the other (Sigstore Rekor/Fulcio pattern;
NIST SP 800-53 AC-5).

## Key rotation log

(Populated as keys rotate. Each rotation event is a separate commit; the old
key remains here as a JSON file with `valid_until` set to the rotation timestamp.)
