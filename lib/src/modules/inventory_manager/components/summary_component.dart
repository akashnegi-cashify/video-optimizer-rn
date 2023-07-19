import 'package:builder_component/builder_component.dart';
import 'package:core_widgets/core_widgets.dart';
import 'package:csh_annotation/annotation.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/src/app_builder/app_builder_groups/groups.dart';
import 'package:provider/provider.dart';

import '../l10n.dart';
import '../models/summary_comp_config.dart';
import '../providers/summary_screen_provider.dart';
import '../widgets/chart_description_widget.dart';

part 'summary_component.g.dart';

@CshComponent(
    key: SummaryComponent.COMP_KEY, configModel: SummaryCompConfig, componentGroup: ComponentGroup.summaryComponentKey)
class SummaryComponent extends StatelessComponent<SummaryCompConfig> {
  static const String COMP_KEY = "TRC_summary";

  const SummaryComponent(super.jsonConfig, {super.key});

  @override
  Widget buildView(BuildContext context, configModel) {
    var theme = Theme.of(context);

    var l10n = L10n(context);
    return ChangeNotifierProvider<SummaryProvider>(
      create: (_) => SummaryProvider(),
      lazy: false,
      builder: (BuildContext innerContext, __) {
        var provider = SummaryProvider.of(innerContext);
        if (provider.isPiechartDataLoading) {
          return const Scaffold(
            body: Center(
              child: SizedBox(
                height: Dimens.space_30,
                width: Dimens.space_30,
                child: CircularProgressIndicator(),
              ),
            ),
          );
        }
        return Scaffold(
          appBar: CshHeader(
            l10n.summaryScreen,
            showBackBtn: true,
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: Dimens.space_16, vertical: Dimens.space_12),
            child: Column(
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "${l10n.delivery} :",
                    style: theme.primaryTextTheme.headline3?.copyWith(color: theme.primaryColor),
                  ),
                ),
                const SizedBox(height: Dimens.space_16),
                if (provider.partSummaryResponse != null && provider.returnCountResponse != null) ...[
                  PieChartWidget(
                    cardElevation: CardElevation.none,
                    pieChartSections: [
                      PieChartSectionData(
                          value: (provider.partSummaryResponse?.summaryData?.assignedCount != null)
                              ? provider.partSummaryResponse!.summaryData!.assignedCount!.toDouble()
                              : 0,
                          radius: Dimens.space_120,
                          color: theme.primaryColor),
                      PieChartSectionData(
                        value: (provider.partSummaryResponse?.summaryData?.pendingCount != null)
                            ? provider.partSummaryResponse!.summaryData!.pendingCount!.toDouble()
                            : 0,
                        radius: Dimens.space_120,
                        color: theme.primaryColor.withOpacity(0.50),
                      ),
                      PieChartSectionData(
                        value: (provider.returnCountResponse?.data?.pendingReturnCount != null)
                            ? provider.returnCountResponse?.data?.pendingReturnCount!.toDouble()
                            : 0,
                        radius: Dimens.space_120,
                        color: theme.primaryColor.withOpacity(0.25),
                      ),
                    ],
                  ),
                  const SizedBox(height: Dimens.space_20),
                  CshShimmer(
                    show: provider.isNumbersDataLoading,
                    child: ChartDescriptionWidget(
                      title: l10n.assignedForDelivery,
                      description: l10n.aodDesc,
                      number: (provider.partSummaryResponse?.summaryData?.assignedCount != null)
                          ? provider.partSummaryResponse!.summaryData!.assignedCount!
                          : 0,
                      tileColor: theme.primaryColor,
                    ),
                  ),
                  const SizedBox(height: Dimens.space_8),
                  CshShimmer(
                    show: provider.isNumbersDataLoading,
                    child: ChartDescriptionWidget(
                      title: l10n.pendingDelivery,
                      description: l10n.pdDesc,
                      number: (provider.partSummaryResponse?.summaryData?.pendingCount != null)
                          ? provider.partSummaryResponse!.summaryData!.pendingCount!
                          : 0,
                      tileColor: theme.primaryColor.withOpacity(0.50),
                    ),
                  ),
                  const SizedBox(height: Dimens.space_8),
                  CshShimmer(
                    show: provider.isNumbersDataLoading,
                    child: ChartDescriptionWidget(
                      title: l10n.pendingReturn,
                      description: l10n.prDesc,
                      number: (provider.returnCountResponse?.data?.pendingReturnCount != null)
                          ? provider.returnCountResponse!.data!.pendingReturnCount!
                          : 0,
                      tileColor: theme.primaryColor.withOpacity(0.25),
                    ),
                  ),
                ],
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Function(Map<String, dynamic> data)? fromConfig() {
    return SummaryCompConfig.fromConfig;
  }
}
