import 'package:collection/collection.dart';
import 'package:components/components.dart';
import 'package:console_flutter_template/src/modules/dynamic_ui/widgets/UiUtil.dart';
import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/dynamic_ui_provider.dart';

typedef ItemBuilder = Widget? Function(int index, BuildContext context, String? uiKey, String? widgetKey);

class DynamicUiWidget extends StatelessWidget {
  const DynamicUiWidget({
    Key? key,
    required this.serviceGroup,
    required this.endPath,
    required this.id,
    this.colSpanDivider = 3,
    required this.itemBuilder,
  }) : super(key: key);

  final ServiceGroups serviceGroup;
  final String endPath;
  final int id;
  final ItemBuilder itemBuilder;
  final int colSpanDivider;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => DynamicUIProvider(
        serviceGroup,
        endPath,
        id,
      ),
      child: Builder(
        builder: (BuildContext innerContext) {
          var provider = innerContext.watch<DynamicUIProvider>();

          var children = provider.dashboardWidgetDetailsResponse?.widgetList?.mapIndexed<Widget?>((index, e) {
                if (e.isHidden == false) {
                  var child = itemBuilder(index, innerContext, e.ui?.key, e.key);
                  ColSpan colSpan = UiUtils.calculateColSpan(colSpan: e.ui?.colSpan, divider: colSpanDivider);
                  if (child != null) {
                    return wrapColumn(
                      child,
                      col: colSpan,
                    );
                  }
                }
                return null;
              }).toList() ??
              [];
          return Wrap(children: ArrayUtil.removeNullItems<Widget>(children));
        },
      ),
    );
  }
}
