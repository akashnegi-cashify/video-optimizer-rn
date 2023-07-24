import 'package:flutter/material.dart';

import 'modules/dispatch/dispatch_screen.dart';
import 'modules/packaging/packaging_process_screen.dart';
import 'modules/packaging/shipex_packing_screen.dart';
import 'modules/shipex_home/screens/shipex_home_screen.dart';

class ShipexRoutes {
  static Map<String, WidgetBuilder> getRoutes() {
    return {
      ShipexHomeScreen.route: (_) => const ShipexHomeScreen(),
      DispatchScreen.route: (_) => const DispatchScreen(),
      ShipexPackingScreen.route: (_) => const ShipexPackingScreen(),
      PackagingProcessScreen.route: (_) => const PackagingProcessScreen(),
    };
  }
}
