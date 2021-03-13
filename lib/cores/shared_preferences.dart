import 'package:shared_preferences/shared_preferences.dart' as sf;

abstract class ISharedPreferences {
  Future<void> initial();

  int? getInt(String key);

  String? getString(String key);

  bool? getBool(String key);

  Future<void> setInt(String key, int value);

  Future<void> setString(String key, String value);

  Future<void> setBool(String key, bool value);

  Future<void> remove(String key);
}

class SharedPreferences implements ISharedPreferences {
  late sf.SharedPreferences client;

  @override
  Future<void> initial() async {
    this.client = await sf.SharedPreferences.getInstance();
  }

  @override
  int? getInt(String key) {
    return this.client.getInt(key);
  }

  @override
  String? getString(String key) {
    return this.client.getString(key);
  }

  @override
  bool? getBool(String key) {
    return this.client.getBool(key);
  }

  @override
  Future<void> setInt(String key, int value) {
    return this.client.setInt(key, value);
  }

  @override
  Future<void> setString(String key, String value) {
    return this.client.setString(key, value);
  }

  @override
  Future<void> setBool(String key, bool value) {
    return this.client.setBool(key, value);
  }

  @override
  Future<void> remove(String key) {
    return this.client.remove(key);
  }
}
