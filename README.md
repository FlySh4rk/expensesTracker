# Expenses Tracker MVP (Offline-Only)

Ultra-minimal Flutter MVP for personal budgeting. The app is fully offline and local-first, built to be future-proof for online OCR, AI categorization, and family sync (stubs only in MVP).

## Run

```bash
flutter pub get
flutter pub run build_runner build --delete-conflicting-outputs
flutter run
```

## Architecture

Feature-first and clean layering:

```
/lib
  /app (router, theme, DI/providers, feature flags)
  /domain (entities, repositories, usecases)
  /data (drift DB, repositories, mappers)
  /features (dashboard, add_expense, expenses_list, categories, settings, roadmap)
  /services (OCR/AI/sync stubs)
  /utils
```

## Database schema (Drift)

Tables:

- `categories` (id, name, icon_key, is_enabled, sort_order)
- `expenses` (id, amount_cents, currency, occurred_at, category_id, merchant, note, source, created_at, updated_at, deleted_at)
- `expense_events` (id, entity_id, event_type, payload_json, created_at, synced_at)

Indexes:
- `idx_expenses_occurred_at`
- `idx_expenses_category`
- `idx_expenses_deleted`
- `idx_expenses_merchant`
- `idx_events_synced`

## Testing

```bash
flutter test
```

## Roadmap

See [docs/FUTURE_PLAN.md](docs/FUTURE_PLAN.md) for the offline-first + online expansion plan and privacy model.
