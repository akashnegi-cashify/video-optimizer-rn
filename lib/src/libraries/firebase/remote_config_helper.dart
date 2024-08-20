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
  static const KEY_VIDEO_OPTIMIZER_CONFIG = "key_video_optimizer_config";
  static const KEY_VIDEO_OPTIMIZER_CONFIG_D2C = "key_video_optimizer_config_d2c";
  static const KEY_IS_RUN_IMEI_VALIDATOR_FLOW = "key_is_run_imei_validator_flow";
  static const KEY_IMEI_READER_TIMEOUT_SEC = "key_imei_reader_timeout_sec";

  static const Map<String, dynamic> DEFAULT_CONFIG = {
    KEY_IS_CAPTURE_MEDIA_MANDATORY_IN_QC: true,
    KEY_IS_CAPTURE_MEDIA_MANDATORY_IN_TRC: false,
    KEY_IS_FORCE_SERVER_RULE_EXECUTOR: true,
    KEY_IS_ENABLE_RULE_EXE_TEST_MODE: true,
    KEY_VIDEO_RECORD_DURATION_IN_SEC: 1200,
    KEY_IS_RUN_IMEI_VALIDATOR_FLOW: true,
    KEY_IMEI_READER_TIMEOUT_SEC: 5,
    KEY_VIDEO_OPTIMIZER_CONFIG:
        '{"videoCodec":"libx264","videoPreset":"superfast","crf":30,"fontSize":24,"fontColor":"white","borderColor":"black","addTimeStamp":true}',
    KEY_VIDEO_OPTIMIZER_CONFIG_D2C: '{"videoCodec":"libx264","videoPreset":"medium","crf":30,"isRemoveAudio":true}',
    KEY_APP_SUPPORTED_VERSIONS:
        '{"dt":[{"version":"3.3.0","isMajor":false,"apkUrl":"https://s3.ap-south-1.amazonaws.com/app.cashify.in/flutter-builds/flutter_trc/prod/prod/prod/106/Release/app-prod-release.apk"},{"version":"3.3.1","isMajor":false,"apkUrl":"https://s3.ap-south-1.amazonaws.com/app.cashify.in/flutter-builds/flutter_trc/prod/prod/prod/107/Release/app-prod-release.apk"},{"version":"3.3.2","isMajor":true,"apkUrl":"https://s3.ap-south-1.amazonaws.com/app.cashify.in/flutter-builds/flutter_trc/prod/prod/prod/110/Release/app-prod-release.apk"}]}',
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
