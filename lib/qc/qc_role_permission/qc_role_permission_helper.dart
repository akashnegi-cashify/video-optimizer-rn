import 'package:flutter_trc/src/resources/user_details.dart';

class QcRolePermissionHelper {
  static bool hasPermission(QcRole role) {
    var index = UserDetails().userDetailsData?.listOfRoles?.indexWhere((element) => element == role.value);
    if (index != null && index > -1) {
      return true;
    }
    return false;
  }
}

enum QcRole {
  roleStoreIn("ROLE_STORE_IN"),
  roleStoreOut("ROLE_STORE_OUT"),
  roleDispatch("ROLE_DISPATCH"),
  roleAudit("ROLE_AUDIT"),
  roleProductDiscovery("ROLE_PRODUCT_DISCOVERY"),
  roleStockTransfer("ROLE_STOCK_TRANSFER"),
  roleSemiTesting("ROLE_SEMI_TESTING"),
  roleTesting("ROLE_TESTING"),
  roleCentralisedAudit("ROLE_CENTRALISED_AUDIT"),
  roleManualTesting("ROLE_MANUAL_TESTING"),
  roleLotReQuote("ROLE_LOT_RE_QUOTE"),
  roleDeadDevice("ROLE_DEAD_DEVICE"),
  roleGuard("ROLE_GUARD"),
  qcElss("QC_ELSS"),
  qcVideographer("ROLE_VIDEOGRAPHER"),
  qcSupervision("SUPERVISOR_ROLE");

  final String value;

  const QcRole(this.value);
}
