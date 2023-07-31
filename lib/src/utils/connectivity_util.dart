import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';

class ConnectivityUtil {
  static Future<bool> checkConnectivity() async {
    Completer<bool> completer = Completer();

    Connectivity().checkConnectivity().then((connectivityResult) {
      if (connectivityResult == ConnectivityResult.mobile || connectivityResult == ConnectivityResult.wifi) {
        completer.complete(true);
      } else {
        completer.complete(false);
      }
    }, onError: (error) {
      completer.completeError("Internet Issue");
    });

    return completer.future;
  }
}
