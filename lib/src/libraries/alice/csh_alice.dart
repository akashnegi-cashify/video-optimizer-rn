import 'package:alice/alice.dart';
import 'package:core/core.dart';

import '../../environments/environment_config.dart';
import '../../environments/environments.dart';

class CshAlice {
  static CshAlice? _instance;

  Alice? _alice;

  dynamic get alice {
    return _alice;
  }

  set alice(dynamic? alice) {
    _alice = alice;
  }

  factory CshAlice({bool showNotification = false, bool showInspectorOnShake = false}) {
    _instance ??= CshAlice._internal(showNotification: showNotification, showInspectorOnShake: showInspectorOnShake);
    return _instance!;
  }

  CshAlice._internal({bool showNotification = false, bool showInspectorOnShake = false}) {
    Environment environment = getEnvironment();
    if (!isWeb() && environment.enableAlice!) {
      alice = Alice(showNotification: showNotification, showInspectorOnShake: showInspectorOnShake);
    }
  }

  void showInspector() {
    if (isActive()) {
      alice!.showInspector();
    }
  }

  bool isActive() {
    // return false;
    return alice != null;
  }
}
