import 'package:core_widgets/core_widgets.dart';

class TrcPermissions {
  static Permission engineer = Permission(module: "trc-console", permissions: ["app_engineer"]);
  static Permission inventory = Permission(module: "trc-console", permissions: ["app_inventory"]);
  static Permission executive = Permission(module: "trc-console", permissions: ["app_executive"]);
  static Permission l4Engineer = Permission(module: "trc-console", permissions: ["app_l4_engineer"]);
  static Permission auditor = Permission(module: "trc-console", permissions: ["app_auditor"]);
  static Permission tester = Permission(module: "trc-console", permissions: ["app_tester"]);
  static Permission partQc = Permission(module: "trc-console", permissions: ["app_part_qc"]);
  static Permission storeManager = Permission(module: "trc-console", permissions: ["app_store_manager"]);
  static Permission rider = Permission(module: "trc-console", permissions: ["app_rider"]);
  static Permission rubbing = Permission(module: "trc-console", permissions: ["app_rubbing"]);
  static Permission glassChange = Permission(module: "trc-console", permissions: ["app_glass_change"]);
}
