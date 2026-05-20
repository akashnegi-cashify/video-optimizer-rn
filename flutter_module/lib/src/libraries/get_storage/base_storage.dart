import 'package:flutter_trc/src/libraries/get_storage/storage_type.dart';
import 'package:lego_storage/lego_storage.dart';

abstract class BaseStorage {
  final StorageType _storageType;
  late final MmkvEngine _engine;

  BaseStorage(this._storageType) {
    _engine = MmkvEngine(mmapID: _storageType.value);
  }

  Future<bool> init() async => true;

  Future<void> clear() async => _engine.clear();

  Future<void> remove(String key) async => _engine.removeItem(key);

  int? getInt(String key) {
    final raw = _engine.getItem(key);
    if (raw == null) return null;
    return int.tryParse(raw);
  }

  String? getString(String key) => _engine.getItem(key);

  bool? getBool(String key) {
    final raw = _engine.getItem(key);
    if (raw == null) return null;
    return raw == 'true';
  }

  Future<void> setString(String key, String value) async => _engine.setItem(key, value);

  Future<void> setInt(String key, int value) async => _engine.setItem(key, value.toString());

  Future<void> setBool(String key, bool value) async => _engine.setItem(key, value.toString());
}
