import 'package:core_widgets/core_widgets.dart';
import 'package:flutter_trc/src/libraries/shared_preferences/app_preferences.dart';
import 'package:flutter_trc/src/modules/login/resources/login_types.dart';
import 'package:flutter_trc/src/services/qc_service.dart';
import 'package:flutter_trc/src/services/trc_service.dart';

class QcTrcServiceInitProvider extends CshChangeNotifier {
  late BaseService service;

  QcTrcServiceInitProvider() {
    initService();
  }

  void initService() {
    var isLoginFromQc = isLoginFromQC();
    if (Validator.isTrue(isLoginFromQc)) {
      service = QcService();
    } else {
      service = TrcService();
    }
    onServiceInitialized();
  }

  void onServiceInitialized() {}

  bool? isLoginFromQC() {
    var loginType = AppPreferences.app.getLoginType();
    var loginTypeEnum = LoginTypes.fromValue(loginType ?? "");
    return loginTypeEnum == LoginTypes.qcLogin;
  }
}
