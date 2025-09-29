import 'package:flutter/material.dart';
import 'package:flutter_trc/rms/modules/facility_list/screens/facility_list_screen.dart';
import 'package:flutter_trc/rms/modules/home/screens/rms_home_screen.dart';

class RmsRoutes {
  static Map<String, WidgetBuilder> getRoutes() {
    return {
      RmsHomeScreen.route: (_) => const RmsHomeScreen(),
      FacilityListScreen.route: (_) => const FacilityListScreen(),
    };
  }
}
