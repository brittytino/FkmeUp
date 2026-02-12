# FkmeUp Architecture Notes

## Core Principles

- Local-first writes (Isar) before any remote operations
- Optional remote sync (Supabase)
- Non-blocking sync pipeline
- Deterministic consistency updates for XP/level/streak/daily stats
- Feature modularity with clear boundaries

## Runtime Flow

1. `main.dart`
   - installs global error handlers (`FlutterError.onError`, `runZonedGuarded`)
   - loads dotenv
   - opens Isar and reads `SettingsModel`
   - initializes Supabase only if sync is enabled and config exists
2. App bootstraps Riverpod scope + shell router.

## Data Layer

- `TaskLocalDataSource`: task persistence and streams
- `ProgressLocalDataSource`: `daily_stats`, `streaks`, `levels`
- `SyncQueueLocalDataSource`: queued operations with retry metadata
- Remote data sources for tasks and progress tables
- Repositories coordinate local writes and queue entries

## Consistency Engine

Triggered on task completion:
- XP recomputation
- daily stats upsert (UTC day normalization)
- level recomputation using `required_xp = 100 + level * 40`
- streak recomputation with grace-day configuration
- queueing of updated progress rows for sync

## Sync Engine

- Processes queue in background (`kick()`)
- Handles tables: `tasks`, `daily_stats`, `streaks`, `levels`
- Conflict policy:
  - if local `updated_at` newer → push remote
  - if remote newer → overwrite local
- Retries failed items with exponential backoff
- Exposes `SyncStatus` stream for UI indicators

## UI Feedback Loop

- Task completion triggers XP gain overlay animation
- Level-up modal appears on level transitions
- Navigation shell shows live sync state icon
- Dashboard/stats/heatmap recompute from persisted local state

## Testing Focus

- XP formula
- Level progression
- Streak behavior and grace-days
- Heatmap daily aggregation

## Operational Constraints

- For web builds, Isar generated schema IDs are post-processed to JS-safe values in `*.g.dart`.
- Regenerating code requires re-applying this patch before web release build.
