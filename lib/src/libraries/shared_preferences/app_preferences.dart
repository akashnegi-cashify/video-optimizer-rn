import 'package:components/auth/handler/auth_handler.dart';
import 'package:flutter_trc/src/libraries/get_storage/app_storage.dart';
import 'package:flutter_trc/src/libraries/get_storage/qc_storage.dart';

class AppPreferences {
  static final QcStorage _qcStorage = QcStorage();
  static final AppStorage _appStorage = AppStorage();

  static QcStorage get qc => _qcStorage;

  static AppStorage get app => _appStorage;

  AppPreferences._privateConstructor();

  static final AppPreferences instance = AppPreferences._privateConstructor();

  Future<void> init() async {
    await _qcStorage.init();
    await _appStorage.init();
  }

  Future<void> resetAndClearAll() async {
    _appStorage.clear();
    await AuthHandler().onSessionExpire();
  }
}
