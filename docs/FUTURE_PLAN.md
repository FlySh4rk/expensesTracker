# Future Plan

This MVP is offline-only by design. The next milestones are optional and controlled via feature flags.

## 1) Online mode

When the user explicitly enables online services and connectivity is available:

- **Cloud OCR** for receipts to extract amounts, dates, merchants, and items.
- **LLM-based categorization** to propose the best category with high quality.

## 2) Privacy by design

- Send only minimal cleaned text to the AI model (e.g., merchant, totals, key lines).
- Never send full receipt images to the LLM.
- Provide clear user consent and visibility into what is shared.

## 3) Family sync with Supabase

Proposed tables:

- `families`
- `family_members`
- `expenses`
- `expense_events`

RLS approach:

- Each row is scoped to a `family_id`.
- RLS policies ensure members can only read/write their family data.

Offline-first:

- Keep the local Drift DB as source of truth on device.
- Log local events in `expense_events`.
- Sync when online by pushing events and pulling changes.

## 4) Optional end-to-end encryption

- Encrypt payloads in the local event log.
- Use per-family keys to ensure only family members can decrypt.
