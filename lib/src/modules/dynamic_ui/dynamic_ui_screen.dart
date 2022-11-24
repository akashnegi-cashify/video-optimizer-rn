import 'package:components/components.dart';
import 'package:core_widgets/core_widgets.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'widgets/dyn_bar_chart.dart';
import 'widgets/dyn_card_tile_widget.dart';
import 'widgets/dyn_pie_chart.dart';
import 'widgets/dynamic_ui_widget.dart';

class DynamicUIScreen extends StatelessWidget {
  static const String route = '/DynamicUi';
  static const title = 'Dynamic Ui';

  const DynamicUIScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);

    return CshScaffold(
      headerConfig: HeaderConfig(headerTitle: 'Status', actions: null, iconWidget: null),
      middleSection: Container(
        color: theme.backgroundColor,
        padding: const EdgeInsets.symmetric(horizontal: Dimens.space_2, vertical: Dimens.space_10),
        child: SingleChildScrollView(
          child: DynamicUiWidget(
            serviceGroup: ServiceGroups.reportdashboard,
            endPath: '/v1/dashboard',
            id: 5,
            colSpanDivider: 6,
            itemBuilder: buildChildWidget,
          ),
        ),
      ),
    );
  }

  Widget? buildChildWidget(int index, BuildContext context, String? uiKey, String? widgetKey) {
    Logger.debug('DynamicUiWidget.buildChildWidget', [uiKey, widgetKey]);
    if (uiKey == null || widgetKey == null) return null;

    switch (uiKey) {
      case 'card':
      case 'smallCard':
        return DynCardTileWidget(
          serviceGroup: ServiceGroups.reportdashboard,
          endPath: '/v1/widget',
          templateFilters: [],
          widgetKey: widgetKey,
          color: getColor(index, context),
          margin: const EdgeInsets.only(
              bottom: Dimens.space_2, top: Dimens.space_2, left: Dimens.space_6, right: Dimens.space_6),
          bottomSuffixWidget: (color) {
            return CshIcon(
              FeatherIcons.arrowRight,
              iconColor: color,
              iconSize: MobileIconSize.large,
            );
          },
        );

      case 'compositeBarGraph':
        return Padding(
          padding: const EdgeInsets.only(
              top: Dimens.space_2, bottom: Dimens.space_20, left: Dimens.space_6, right: Dimens.space_6),
          child: DynBarChart(
            serviceGroup: ServiceGroups.reportdashboard,
            endPath: '/v1/widget',
            templateFilters: [],
            widgetKey: widgetKey,
          ),
        );

      case 'pieChart':
        return DynPieChart(
          serviceGroup: ServiceGroups.reportdashboard,
          endPath: '/v1/widget',
          templateFilters: [],
          widgetKey: widgetKey,
        );
    }
    return null;
  }

  Color getColor(int index, BuildContext context) {
    Color color;
    var theme = Theme.of(context);
    var customColor = theme.extension<CustomColors>() as CustomColors;
    int idx = index % 5;
    switch (idx) {
      case 0:
        color = customColor.successColor;
        break;
      case 1:
        color = customColor.warnColor;
        break;
      case 2:
        color = theme.primaryColor;
        break;
      case 3:
        color = theme.errorColor;
        break;
      default:
        color = theme.colorScheme.secondary;
        break;
    }

    return color;
  }
}
