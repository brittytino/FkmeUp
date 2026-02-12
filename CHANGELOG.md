# Changelog

All notable changes to this project are documented in this file.

## [Unreleased]

### Added
- Global error boundary, zoned crash protection, and logger service
- Full sync engine support for `tasks`, `daily_stats`, `streaks`, `levels`
- Sync retry queue with exponential backoff and sync status stream
- Consistency engine for XP/level/streak/daily stats updates
- XP gain animation overlay and level-up modal
- Settings validation and sync test action
- Focused utility tests for XP, level, streak, heatmap
- Cross-platform Flutter target scaffolding and production docs

### Changed
- Migrated from `isar` to `isar_community` packages for modern Android toolchain compatibility
- Hardened startup sequence and conditional Supabase init based on settings
- Updated Supabase schema with `updated_at` fields and indexes for conflict resolution

### Fixed
- Isar initialization and provider wiring issues
- Build/runtime nullability and async error handling issues
- Router fallback behavior on invalid routes
