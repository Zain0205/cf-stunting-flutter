import 'package:shared_preferences/shared_preferences.dart';
import 'storage_service.dart';

class SharedPreferencesService implements StorageService {
  SharedPreferences? _prefs;
  bool _initialized = false;

  @override
  bool get hasInitialized => _initialized;

  @override
  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
    _initialized = true;
  }

  @override
  Future<void> remove(String key) async {
    if (!_initialized) throw Exception("StorageService is not initialized");
    await _prefs?.remove(key);
  }

  @override
  Future<T?> get<T>(String key) async {
    if (!_initialized) throw Exception("StorageService is not initialized");
    final value = _prefs?.get(key);
    return value as T?;
  }

  @override
  Future<void> set<T>(String key, T value) async {
    if (!_initialized) throw Exception("StorageService is not initialized");

    if (value is int) {
      await _prefs?.setInt(key, value);
    } else if (value is double) {
      await _prefs?.setDouble(key, value);
    } else if (value is bool) {
      await _prefs?.setBool(key, value);
    } else if (value is String) {
      await _prefs?.setString(key, value);
    } else if (value is List<String>) {
      await _prefs?.setStringList(key, value);
    } else {
      throw Exception("Unsupported type for SharedPreferences");
    }
  }

  @override
  Future<void> clear() async {
    if (!_initialized) throw Exception("StorageService is not initialized");
    await _prefs?.clear();
  }

  @override
  Future<bool> has(String key) async {
    if (!_initialized) throw Exception("StorageService is not initialized");
    return _prefs?.containsKey(key) ?? false;
  }
}
