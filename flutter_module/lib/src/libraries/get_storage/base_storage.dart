import 'package:flutter_trc/src/libraries/get_storage/storage_type.dart';
import 'package:get_storage/get_storage.dart';

abstract class BaseStorage {
  final StorageType _storageType;
  late final GetStorage _getStorage;

  BaseStorage(this._storageType) {
    _getStorage = GetStorage(_storageType.value);
  }

  Future<bool> init() {
    return GetStorage.init(_storageType.value);
  }

  Future<void> clear() {
    return _getStorage.erase();
  }

  int? getInt(String key) {
    return _getStorage.read(key);
  }

  String? getString(String key) {
    return _getStorage.read(key);
  }

  bool? getBool(String key) {
    return _getStorage.read(key);
  }

  Future<void> setString(String key, String value) {
    return _getStorage.write(key, value);
  }

  Future<void> setInt(String key, int value) {
    return _getStorage.write(key, value);
  }

  Future<void> setBool(String key, bool value) {
    return _getStorage.write(key, value);
  }
}
