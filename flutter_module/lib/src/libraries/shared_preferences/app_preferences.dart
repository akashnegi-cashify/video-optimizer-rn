import 'package:components/auth/handler/auth_handler.dart';
import 'package:flutter_trc/src/libraries/get_storage/app_storage.dart';
import 'package:flutter_trc/src/libraries/get_storage/qc_storage.dart';
import 'package:flutter_trc/src/libraries/get_storage/rms_storage.dart';
import 'package:flutter_trc/src/libraries/get_storage/trc_storage.dart';
import 'package:mmkv/mmkv.dart';

class AppPreferences {
  static final QcStorage _qcStorage = QcStorage();
  static final AppStorage _appStorage = AppStorage();
  static final RmsStorage _rmsStorage = RmsStorage();
  static final TrcStorage _trcStorage = TrcStorage();

  static QcStorage get qc => _qcStorage;

  static AppStorage get app => _appStorage;

  static RmsStorage get rms => _rmsStorage;

  static TrcStorage get trc => _trcStorage;

  AppPreferences._privateConstructor();

  static final AppPreferences instance = AppPreferences._privateConstructor();

  Future<void> init() async {
    await MMKV.initialize();
    await _qcStorage.init();
    await _appStorage.init();
    await _rmsStorage.init();
    await _trcStorage.init();
  }

  // Note: _appStorage.clear() wipes the entire lego_shared MMKV bucket (including the auth token).
  // If RN later stores other keys in lego_shared, switch to surgical per-key removal.
  Future<void> resetAndClearAll() async {
    _appStorage.clear();
    _rmsStorage.clear();
    _trcStorage.clear();
    await AuthHandler().onSessionExpire();
  }
}
