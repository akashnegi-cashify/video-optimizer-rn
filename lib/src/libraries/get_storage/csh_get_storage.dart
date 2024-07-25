import 'package:get_storage/get_storage.dart';

class CshGetStorageUtil {
  static final CshGetStorageUtil _instance = CshGetStorageUtil._privateConstructor();

  CshGetStorageUtil._privateConstructor();

  factory CshGetStorageUtil() {
    return _instance;
  }

  Future<void> clear() {
    return GetStorage().erase();
  }

  Future<bool> init() {
    return GetStorage.init();
  }

  int? getInt(String key) {
    return GetStorage().read(key);
  }

  String? getString(String key) {
    return GetStorage().read(key);
  }

  bool? getBool(String key) {
    return GetStorage().read(key);
  }

  Future<void> setString(String key, String value) {
    return GetStorage().write(key, value);
  }

  Future<void> setInt(String key, int value) {
    return GetStorage().write(key, value);
  }

  Future<void> setBool(String key, bool value) {
    return GetStorage().write(key, value);
  }
}
