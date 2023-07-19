import 'package:flutter/material.dart';
import 'package:flutter_trc/shipex/modules/shipex_home/components/shipex_home_component.dart';

class ShipexComponentRegistry {
  static Widget? getRegisteredComponent(String? componentKey, Map<String, dynamic>? jsonConfig) {
    switch (componentKey) {
      case ShipexHomeComponent.COMP_KEY:
        return ShipexHomeComponent(jsonConfig);
      default:
        null;
    }
  }
}
