import 'package:core_widgets/core_widgets.dart';
import 'package:flutter_trc/src/libraries/shared_prefrences/app_prefrences.dart';
import 'package:flutter_trc/src/modules/login/resources/login_types.dart';
import 'package:flutter_trc/src/services/qc_service.dart';
import 'package:flutter_trc/src/services/trc_service.dart';

class QcTrcServiceInitProvider extends CshChangeNotifier {
  late BaseService service;

  QcTrcServiceInitProvider() {
    initService();
  }

  Future<void> initService() async {
    var isLoginFromQc = await isLoginFromQC();
    if (Validator.isTrue(isLoginFromQc)) {
      service = QcService();
    } else {
      service = TrcService();
    }
    onServiceInitialized();
  }

  void onServiceInitialized() {}

  Future<bool?> isLoginFromQC() async {
    var loginType = await AppPreferences().getLoginType();
    var loginTypeEnum = LoginTypes.fromValue(loginType ?? "");
    return loginTypeEnum == LoginTypes.qcLogin;
  }
}
