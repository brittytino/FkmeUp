# FkmeUp

Version: `0.1.0+1`

FkmeUp is a **single-user**, gamified productivity execution system built as a dark performance console. It is offline-first, local-first, and optionally syncs to Supabase.

## Product Scope

- Single-user only
- No AI assistant
- No team/collaboration
- No SaaS requirement

## Screenshots

- `docs/screenshots/dashboard.png` (placeholder)
- `docs/screenshots/tasks.png` (placeholder)
- `docs/screenshots/heatmap.png` (placeholder)
- `docs/screenshots/stats.png` (placeholder)
- `docs/screenshots/settings.png` (placeholder)

## Tech Stack

- Flutter (Android, Web, Windows, macOS, Linux)
- Dart 3+
- Riverpod
- GoRouter
- Isar Community (`isar_community`)
- Supabase (optional sync)
- `flutter_dotenv`
- `fl_chart`

## Architecture

- App shell + route modules in `lib/app`
- Feature-first UI modules in `lib/features/*`
- Local/remote/repository data layers in `lib/data/*`
- Sync engine with queue/retry/backoff in `lib/data/sync/sync_engine.dart`
- Consistency engine in `lib/core/services/consistency_engine.dart`
- Typed domain persistence models in `lib/models/*`

See `docs/ARCHITECTURE.md` for details.

## Supabase Setup

1. Create a Supabase project.
2. Execute `supabase/schema.sql` in SQL editor.
3. Keep realtime enabled for `tasks` and `daily_stats`.
4. Set credentials in:
   - `assets/env/.env` (runtime asset)
   - `.env` (developer convenience)

Template:

```env
SUPABASE_URL=https://your-project.supabase.co
SUPABASE_ANON_KEY=your_anon_key
```

## Local Development

```bash
flutter pub get
dart run build_runner build --delete-conflicting-outputs
flutter run
```

## Release Builds

```bash
flutter build apk --release
flutter build web --release
flutter build windows --release
flutter build macos --release
```

## Notes on Build Verification

- Verified in this workspace:
  - `flutter analyze` ✅
  - focused tests (`test/utils/*`) ✅
  - `flutter build apk --release` ✅
  - `flutter build web --release` ✅
- `flutter build windows --release` requires Windows Developer Mode (symlink support).

## Common Build Issues

### Isar code generation missing

Symptoms: `part '*.g.dart' not found`.

Fix:

```bash
dart run build_runner build --delete-conflicting-outputs
```

### Web build fails on Isar generated large integer IDs

Some Flutter/Dart toolchains reject 64-bit schema ID literals in generated Isar files for `dart2js`.

Current workaround in this repo:
- JS-safe IDs are post-processed in generated model files under `lib/models/*.g.dart`.
- If you re-run codegen, re-apply this compatibility patch before `flutter build web --release`.

### Supabase not syncing

Checklist:
- Valid `SUPABASE_URL` and `SUPABASE_ANON_KEY`
- `syncEnabled` turned on in Settings
- Schema applied from `supabase/schema.sql`
- RLS / table permissions allow operations for your key

## Configuration Safety

Settings screen validates:
- Supabase URL format
- anon key presence
- sync enablement fallback (disables sync on invalid config)
- sync test button for runtime connectivity check

## Project Structure

```text
lib/
 ├── app/
 ├── core/
 ├── data/
 │    ├── local/
 │    ├── remote/
 │    ├── repositories/
 │    └── sync/
 ├── features/
 │    ├── dashboard/
 │    ├── tasks/
 │    ├── heatmap/
 │    ├── stats/
 │    └── settings/
 ├── models/
 ├── theme/
 └── utils/
```

## Contributing

See `CONTRIBUTING.md`.

## Changelog

See `CHANGELOG.md`.

## License

MIT (`LICENSE`).
