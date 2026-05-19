import 'package:flutter_trc/shipex/shipex_service.dart';
import 'package:flutter_trc/src/services/qc_service.dart';
import 'package:flutter_trc/src/services/rms_service.dart';
import 'package:flutter_trc/src/services/trc_service.dart';

enum LoginTypes {
  trcLogin("TRC"),
  qcLogin("QC"),
  shipexLogin("Shipex"),
  rmsLogin("RMS");

  final String value;

  const LoginTypes(this.value);

  static LoginTypes fromValue(String value) {
    LoginTypes loginTypes =
        LoginTypes.values.firstWhere((element) => element.value == value, orElse: () => LoginTypes.qcLogin);
    return loginTypes;
  }

  getServiceName() {
    switch (this) {
      case LoginTypes.trcLogin:
        return "trc-console";
      case LoginTypes.qcLogin:
        return QcService().getServiceGroup().value;
      case LoginTypes.shipexLogin:
        return ShipexService().getServiceGroup().value;
      case LoginTypes.rmsLogin:
        return RmsService().getServiceGroup().value;
    }
  }
}
