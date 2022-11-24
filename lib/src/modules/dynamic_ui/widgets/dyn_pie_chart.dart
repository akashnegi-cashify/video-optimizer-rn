import 'package:core_widgets/core_widgets.dart';import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../provider/widget_data_provider.dart';
import 'base_dynamic_widget.dart';

class DynPieChart extends BaseDynamicWidget {
  const DynPieChart({
    super.key,
    required super.widgetKey,
    required super.endPath,
    required super.serviceGroup,
    required super.templateFilters,
  });

  @override
  Widget buildWidget(BuildContext context) {
    var provider = WidgetDataProvider.of(context);
    List<String?>? graphSections = List.generate(provider.widgetDataResponse?.columns?.length ?? 0,
        (index) => provider.widgetDataResponse?.columns?.elementAt(index).name ?? "").cast<String?>().toList();

    List<String?>? singleDataSet = provider.widgetDataResponse?.data.first ?? [];
    List<PieChartSectionData>? pieChartSections = [];
    pieChartSections = List.generate(
      graphSections.length,
      (index) => PieChartSectionData(
        value: double.tryParse(singleDataSet[index] ?? "0"),
        radius: 60,
        showTitle: false,
        title: graphSections.elementAt(index) ?? "",
        borderSide: const BorderSide(color: Colors.white, width: 0.5),
        color: colorsList.elementAt(index % colorsList.length),
      ),
    );

    return PieChartWidget(
      centerSpaceRadius: 0.0,
      sectionSpace: 0.5,
      startDegreeOffset: 10.0,
      pieChartSections: pieChartSections,
      graphSections: graphSections,
    );
  }
}
