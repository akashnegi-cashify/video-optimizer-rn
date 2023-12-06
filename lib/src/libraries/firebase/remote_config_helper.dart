import 'dart:async';

import 'package:core/core.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter_trc/src/utils/connectivity_util.dart';

class AppRemoteConfig {
  static const KEY_IS_CAPTURE_MEDIA_MANDATORY_IN_QC = "key_is_capture_media_mandatory_in_qc";
  static const KEY_IS_CAPTURE_MEDIA_MANDATORY_IN_TRC = "key_is_capture_media_mandatory_in_trc";
  static const KEY_IS_FORCE_SERVER_RULE_EXECUTOR = "key_is_force_server_rule_executor";
  static const KEY_IS_ENABLE_RULE_EXE_TEST_MODE = "key_is_enable_rule_exe_test_mode";
  static const KEY_VIDEO_RECORD_DURATION_IN_SEC = "key_video_record_duration_in_sec";
  static const KEY_APP_SUPPORTED_VERSIONS = "key_app_supported_versions";

  static const Map<String, dynamic> DEFAULT_CONFIG = {
    KEY_IS_CAPTURE_MEDIA_MANDATORY_IN_QC: false,
    KEY_IS_CAPTURE_MEDIA_MANDATORY_IN_TRC: false,
    KEY_IS_FORCE_SERVER_RULE_EXECUTOR: true,
    KEY_IS_ENABLE_RULE_EXE_TEST_MODE: true,
    KEY_VIDEO_RECORD_DURATION_IN_SEC: 600,
    KEY_APP_SUPPORTED_VERSIONS: '{"dt":[{"version":"2.2.0","isMajor":true,"apkUrl":"https://s3.ap-south-1.amazonaws.com/app.cashify.in/flutter-builds/flutter_trc/prod/prod/prod/36/Release/app-prod-release.apk"}]}',
  };
}

class RemoteConfigHelper {
  static final RemoteConfigHelper _instance = RemoteConfigHelper._internal();

  factory RemoteConfigHelper() {
    return _instance;
  }

  RemoteConfigHelper._internal();

  FirebaseRemoteConfig? _remoteConfig;

  Future<FirebaseRemoteConfig?> initialize({bool withFetch = true}) async {
    _remoteConfig = FirebaseRemoteConfig.instance;
    await _remoteConfig!.setConfigSettings(RemoteConfigSettings(
      fetchTimeout: const Duration(seconds: 1),
      minimumFetchInterval: Duration.zero,
    ));
    await _remoteConfig!.setDefaults(AppRemoteConfig.DEFAULT_CONFIG);

    if (withFetch) {
      await fetchAndActivate();
    }
    Logger.log('Remote config initialized...');

    return _remoteConfig;
  }

  Future fetchAndActivate() async {
    Completer completer = Completer();
    ConnectivityUtil.checkConnectivity().then((isInternetConnected) async {
      if (isInternetConnected) {
        try {
          var value = await _remoteConfig!.fetchAndActivate();
          Logger.debug('mydebug------RemoteConfigHelper.fetchAndActivate', ["success----$value"]);
        } catch (e) {
          Logger.debug('mydebug------RemoteConfigHelper.fetchAndActivate', ["error---$e"]);
        } finally {
          completer.complete(true);
        }
      } else {
        completer.complete(true);
      }
    });
    return completer.future;
  }

  String getString(String key) {
    return _remoteConfig!.getString(key);
  }

  getBoolean(String key) {
    return _remoteConfig!.getBool(key);
  }

  int getInt(String key) {
    return _remoteConfig!.getInt(key).toInt();
  }

  double getDouble(String key) {
    return _remoteConfig!.getDouble(key);
  }
}
