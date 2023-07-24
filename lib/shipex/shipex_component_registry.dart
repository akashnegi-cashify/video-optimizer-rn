import 'package:flutter/material.dart';

import 'modules/dispatch/components/dispatch_component.dart';
import 'modules/packaging/components/packaging_process_component.dart';
import 'modules/packaging/components/shipex_packing_component.dart';
import 'modules/shipex_home/components/shipex_home_component.dart';

class ShipexComponentRegistry {
  static Widget? getRegisteredComponent(String? componentKey, Map<String, dynamic>? jsonConfig) {
    switch (componentKey) {
      case ShipexHomeComponent.COMP_KEY:
        return ShipexHomeComponent(jsonConfig);
      case DispatchComponent.COMP_KEY:
        return DispatchComponent(jsonConfig);
      case ShipexPackingComponent.COMP_KEY:
        return ShipexPackingComponent(jsonConfig);
      case PackagingProcessComponent.COMP_KEY:
        return PackagingProcessComponent(jsonConfig);
      default:
        null;
    }
  }
}
