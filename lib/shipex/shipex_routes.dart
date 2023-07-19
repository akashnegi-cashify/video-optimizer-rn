import 'package:flutter/material.dart';
import 'package:flutter_trc/shipex/shipex_home/screens/shipex_home_screen.dart';

class ShipexRoutes {
  static Map<String, WidgetBuilder> getRoutes() {
    return {
      ShipexHomeScreen.route: (_) => const ShipexHomeScreen(),
    };
  }
}
