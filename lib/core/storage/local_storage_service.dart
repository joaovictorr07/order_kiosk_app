import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageService {
  LocalStorageService._(this._preferences);

  static LocalStorageService? _instance;

  final SharedPreferences _preferences;

  static Future<LocalStorageService> getInstance() async {
    final existingInstance = _instance;
    if (existingInstance != null) {
      return existingInstance;
    }

    final preferences = await SharedPreferences.getInstance();
    final service = LocalStorageService._(preferences);
    _instance = service;
    return service;
  }

  Future<void> setString(String key, String value) async {
    await _preferences.setString(key, value);
  }

  String? getString(String key) {
    return _preferences.getString(key);
  }

  Future<void> setBool(String key, bool value) async {
    await _preferences.setBool(key, value);
  }

  bool? getBool(String key) {
    return _preferences.getBool(key);
  }

  Future<void> remove(String key) async {
    await _preferences.remove(key);
  }

  Future<void> clear() async {
    await _preferences.clear();
  }
}
