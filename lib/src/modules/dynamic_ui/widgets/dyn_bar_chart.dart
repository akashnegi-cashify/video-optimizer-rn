import 'package:console_flutter_template/src/modules/dynamic_ui/widgets/base_dynamic_widget.dart';
import 'package:core_widgets/core_widgets.dart';import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../provider/widget_data_provider.dart';

class DynBarChart extends BaseDynamicWidget {
  const DynBarChart({
    super.key,
    required super.widgetKey,
    required super.endPath,
    required super.serviceGroup,
    required super.templateFilters,
  });

  @override
  Widget buildWidget(BuildContext context) {
    var provider = WidgetDataProvider.of(context);

    List<String?> graphTags = [];
    provider.widgetDataResponse?.data.forEach((element) {
      graphTags.add(element.first);
    });

    List<double?> barGraphPointers = [];
    provider.widgetDataResponse?.data
        .forEach((element) => {barGraphPointers.add(double.tryParse(element.last))});

    double maxValue = 0;
    if (barGraphPointers.isNotEmpty) {
      maxValue = ArrayUtil.removeNullItems<double>(barGraphPointers)
          .reduce((value, element) => value > element ? value : element);
    }

    List<BarChartGroupData> barChartGroupData = List.generate(
      barGraphPointers.length,
          (index) => BarChartGroupData(x: 5 * index, barRods: [
        BarChartRodData(
          toY: barGraphPointers.elementAt(index) ?? 0,
          color: colorsList.elementAt(index % colorsList.length),
          width: Dimens.space_16,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(0),
            topRight: Radius.circular(0),
          ),
        ),
      ], showingTooltipIndicators: [
        0
      ]),
    );

    return CshShimmer(
      show: provider.widgetDataResponse == null,
      child: BarChartWidget(
        graphTags: graphTags,
        xAxisInterval: 10,
        yAxisInterval: 200,
        maxYValue: maxValue,
        barChartGroupData: barChartGroupData,
      ),
    );
  }
}
