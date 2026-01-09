import 'package:core_widgets/core_widgets.dart';

class TrcPermissions {
  static Permission engineer = Permission(module: "trc-console", permissions: ["app_engineer"]);
  static Permission inventory = Permission(module: "trc-console", permissions: ["app_inventory"]);
}
