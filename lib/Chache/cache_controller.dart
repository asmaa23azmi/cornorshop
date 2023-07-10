import 'package:shared_preferences/shared_preferences.dart';

import '../enums.dart';

class CacheController {
  /// Singleton
  CacheController._private();

  static CacheController cacheController = CacheController._private();

  factory CacheController() => cacheController;

  /// Cache(Shared Preferences)
  late SharedPreferences cache;

  Future<void> initCache() async {
    cache = await SharedPreferences.getInstance();
  }

  /// Data
  Future<void> setter(CacheKeys key, dynamic value) async {
    if (value is String) {
      await cache.setString(key.name, value);
    } else if (value is int) {
      await cache.setInt(key.name, value);
    } else if (value is double) {
      await cache.setDouble(key.name, value);
    } else if (value is bool) {
      await cache.setBool(key.name, value);
    }
  }

  dynamic getter(CacheKeys key) => cache.get(key.name);
}