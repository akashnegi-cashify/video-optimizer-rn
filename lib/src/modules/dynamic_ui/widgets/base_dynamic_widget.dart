import 'package:components/components.dart';
import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../model/dashboard_widget_detail.dart';
import '../provider/widget_data_provider.dart';

abstract class BaseDynamicWidget extends StatelessWidget {
  final String widgetKey;
  final String endPath;
  final ServiceGroups serviceGroup;
  final List<TemplateFilterList> templateFilters;

  const BaseDynamicWidget({
    Key? key,
    required this.widgetKey,
    required this.endPath,
    required this.serviceGroup,
    required this.templateFilters,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => WidgetDataProvider(
        serviceGroup: serviceGroup,
        endPath: endPath,
        widgetKey: widgetKey,
        templateFilters: templateFilters,
      ),
      child: Builder(
        builder: (BuildContext innerContext) {
          return buildWidget(innerContext);
        },
      ),
    );
  }

  Widget buildWidget(BuildContext context);
}
