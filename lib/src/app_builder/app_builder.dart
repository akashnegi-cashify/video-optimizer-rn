import 'package:builder_project/builder_project.dart';
import 'package:core/core.dart';
import 'package:core_widgets/core_widgets.dart';
import 'package:csh_annotation/annotation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/qc/qc_component_registry.dart';
import 'package:flutter_trc/trc/trc_component_registry.dart';

import '../common/widgets/not_registred_component_widget.dart';
import 'app_headers/general_app_header/component/general_header_component.dart';
import 'app_headers/qc_general_header/component/qc_general_header_component.dart';

class AppComponentBuilder {
  static void Function(int index)? onClick;

  AppComponentBuilder() {
    ComponentRegistry.registerHeaderBuilder(getHeaderComponent);
    ComponentRegistry.registerComponentBuilder(getComponent);
    ComponentRegistry.registerPagerBottomBar(getBottomBar);
  }

  static Widget getComponent(String? componentKey, Map<String, dynamic>? jsonConfig) {
    Logger.debug('AppComponentBuilder.getComponent', ['$componentKey' '$jsonConfig']);
    if (componentKey == null) {
      return const SizedBox.shrink();
    }
    Widget? componentWidget;
    componentWidget = QcComponentRegistry.getRegisteredComponent(componentKey, jsonConfig);
    if (componentWidget != null) {
      return componentWidget;
    }
    componentWidget = TrcComponentRegistry.getRegisteredComponent(componentKey, jsonConfig);
    if (componentWidget != null) {
      return componentWidget;
    }

    return const NotRegistered();
  }

  static PreferredSizeWidget? getHeaderComponent(String? componentKey, Map<String, dynamic>? jsonConfig) {
    switch (componentKey) {
      case GeneralHeaderComponent.COMP_KEY:
        return GeneralHeaderComponent(jsonConfig);
      case QcGeneralHeaderComponent.COMP_KEY:
        return QcGeneralHeaderComponent(jsonConfig);
      default:
        return null;
    }
  }

  static Widget getBottomBar({
    bool? isFloating,
    required List<BottomBarItemConfig> items,
    void Function(int index)? onClick,
    int selectedIndex = 0,
    String? uniqueKey,
  }) {
    AppComponentBuilder.onClick = onClick;
    return BottomBarWidget(
      items: items
          .map((e) => BottomTabConfig(tabTitle: e.tabTitle, iconPath: e.iconPath, iconType: _mapResType(e.iconType)))
          .toList(),
      selectedIndex: selectedIndex,
      onClick: onClick,
      isFloating: isFloating,
      horizontalAlignment: MainAxisAlignment.spaceAround,
    );
  }

  static TabResourceType? _mapResType(ResourceType? iconType) {
    switch (iconType) {
      case ResourceType.assetImage:
        return TabResourceType.assetImage;
      case ResourceType.networkImage:
        return TabResourceType.networkImage;
      case ResourceType.assetAnimation:
        return TabResourceType.assetAnimation;
      case ResourceType.networkAnimation:
        return TabResourceType.networkAnimation;
      default:
        return null;
    }
  }
}
