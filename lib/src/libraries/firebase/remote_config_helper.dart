import 'dart:async';

import 'package:core/core.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter_trc/src/utils/connectivity_util.dart';

class AppRemoteConfig {
  static const KEY_IS_CAPTURE_MEDIA_MANDATORY_IN_QC = "key_is_capture_media_mandatory_in_qc";

  static const Map<String, dynamic> DEFAULT_CONFIG = {
    KEY_IS_CAPTURE_MEDIA_MANDATORY_IN_QC: false,
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
      await _fetchAndActivate();
    }
    Logger.log('Remote config initialized...');

    return _remoteConfig;
  }

  Future _fetchAndActivate() async {
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
