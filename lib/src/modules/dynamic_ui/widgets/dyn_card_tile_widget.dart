import 'package:console_flutter_template/src/modules/dynamic_ui/provider/widget_data_provider.dart';
import 'package:console_flutter_template/src/modules/dynamic_ui/widgets/base_dynamic_widget.dart';
import 'package:core_widgets/core_widgets.dart';import 'package:flutter/material.dart';


class DynCardTileWidget extends BaseDynamicWidget {
  final Color? color;
  final ItemWidget? topSuffixWidget;
  final ItemWidget? bottomSuffixWidget;
  final EdgeInsets margin;
  const DynCardTileWidget( {
    super.key,
    required super.widgetKey,
    required super.endPath,
    required super.serviceGroup,
    required super.templateFilters,
    this.topSuffixWidget,
    this.bottomSuffixWidget,
    this.color,
    this.margin=EdgeInsets.zero,
  });

  @override
  Widget buildWidget(BuildContext context) {
    var provider = WidgetDataProvider.of(context);
    var theme = Theme.of(context);
    return CshShimmer(
      show: provider.widgetDataResponse == null,
      child: CardTileWidget(
        margin: margin,
        title: provider.widgetDataResponse?.columns?.elementAt(0).name ?? '',
        value: provider.widgetDataResponse?.data.isNotEmpty==true ?  provider.widgetDataResponse?.data[0].first ?? '' : '',
        color: color ??  theme.primaryColor,
        topSuffixWidget: topSuffixWidget,
        bottomSuffixWidget: bottomSuffixWidget,
      ),
    );
  }
}
