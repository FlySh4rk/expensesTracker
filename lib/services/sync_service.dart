abstract class SyncService {
  Future<void> pushLocalEvents();
  Future<void> pullRemoteChanges();
}

class StubSyncService implements SyncService {
  const StubSyncService();

  @override
  Future<void> pullRemoteChanges() {
    throw UnimplementedError('Family sync is not enabled in MVP.');
  }

  @override
  Future<void> pushLocalEvents() {
    throw UnimplementedError('Family sync is not enabled in MVP.');
  }
}
