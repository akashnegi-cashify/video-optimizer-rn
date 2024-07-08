import 'package:flutter/material.dart';
import 'package:flutter_trc/rms/modules/home/components/rms_home_component.dart';

class RmsComponentRegistry {
  static Widget? getRegisteredComponent(String? componentKey, Map<String, dynamic>? jsonConfig) {
    switch (componentKey) {
      case RmsHomeComponent.COMP_KEY:
        return RmsHomeComponent(jsonConfig);
      default:
        null;
    }
    return null;
  }
}
