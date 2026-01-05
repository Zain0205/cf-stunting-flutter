abstract class StorageService {
  Future<void> init();
  bool get hasInitialized;

  Future<void> remove(String key);
  Future<T?> get<T>(String key);
  Future<void> set<T>(String key, T value);

  Future<void> clear();
  Future<bool> has(String key);
}
