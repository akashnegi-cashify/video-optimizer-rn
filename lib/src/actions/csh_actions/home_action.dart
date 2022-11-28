import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';

import '../../screens/home_screen.dart';

class HomeAction extends AbstractAction {
  String? telephone;

  HomeAction(super.extraData, super.callback) {
    parseData(extraData);
  }

  @override
  execute([ContextFunction? requireContext]) {
    mayBe(() => Navigator.of(requireContext!()!).pushNamed(HomeScreen.route));
  }

  getContext([ContextFunction? requireContext]) {
    return requireContext != null ? requireContext() : null;
  }

  @override
  bool isValid() {
    return true;
  }

  @override
  parseData(Map<String?, dynamic>? data) {
    if (data == null) {
      return;
    }
  }
}
