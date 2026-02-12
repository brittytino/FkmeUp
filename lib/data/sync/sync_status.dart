enum SyncPhase { idle, syncing, success, failed }

class SyncStatus {
  const SyncStatus({
    required this.phase,
    required this.pendingItems,
    this.lastError,
  });

  final SyncPhase phase;
  final int pendingItems;
  final String? lastError;

  static const SyncStatus idle = SyncStatus(phase: SyncPhase.idle, pendingItems: 0);
}
