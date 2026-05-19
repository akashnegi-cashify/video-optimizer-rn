import 'package:core_widgets/core_widgets.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class ReportPieChartWidget extends StatelessWidget {
  final List<SectionData> data;

  const ReportPieChartWidget({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CshCard(
        child: Column(
      children: [
        SizedBox(
          height: 300,
          child: PieChart(PieChartData(
              sections: List.generate(
                  data.length,
                  (index) => PieChartSectionData(
                      value: data[index].value,
                      showTitle: true,
                      color: data[index].color,
                      radius: 100,
                      titleStyle: TextStyle(color: Theme.of(context).colorScheme.background))))),
        ),
        const SizedBox(
          height: Dimens.space_8,
        ),
        ...List.generate(data.length, (index) => _LegendWidget(data: data[index])),
      ],
    ));
  }
}

class SectionData {
  final Color color;
  final double? value;
  final String legendTitle;

  SectionData(this.color, this.value, this.legendTitle);
}

class _LegendWidget extends StatelessWidget {
  final SectionData data;

  const _LegendWidget({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(Dimens.space_4),
      child: Row(
        children: [
          Container(
            height: 24,
            width: 24,
            color: data.color,
          ),
          const SizedBox(
            width: 16,
          ),
          CshTextNew.h4(
            data.legendTitle,
          ),
          const Spacer(),
          CshTextNew.h4(data.value?.toInt().toString() ?? "-")
        ],
      ),
    );
  }
}
