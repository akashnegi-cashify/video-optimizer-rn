import 'package:flutter/cupertino.dart';

mixin UrgentRequest {
  bool _isUrgent = false;

  bool get isUrgent => _isUrgent;

  set isUrgent(bool value) {
    _isUrgent = value;
  }
}
