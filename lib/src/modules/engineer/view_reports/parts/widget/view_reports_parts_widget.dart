import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/src/common/utils/time_utils.dart';
import 'package:flutter_trc/src/modules/engineer/l10n.dart';
import 'package:flutter_trc/src/modules/engineer/view_reports/common/date_range_picker_dropdown_widget.dart';
import 'package:flutter_trc/src/modules/engineer/view_reports/parts/model/engineer_part_report_response.dart';
import 'package:flutter_trc/src/modules/engineer/view_reports/parts/widget/parts_lead_engineer_widget.dart';

import '../../../../../common/widgets/title_value_row_widget.dart';
import '../../../resources/engineer_api_service.dart';
import '../../common/report_pie_chart_widget.dart';

class ViewReportsPartsWidget extends StatefulWidget {
  const ViewReportsPartsWidget({Key? key}) : super(key: key);

  @override
  State<ViewReportsPartsWidget> createState() => _ViewReportsPartsWidgetState();
}

class _ViewReportsPartsWidgetState extends State<ViewReportsPartsWidget> with AutomaticKeepAliveClientMixin {
  late Stream<EngineerPartReportResponse?> dataStream;

  late DateDropDownData dropDownData;
  late L10n l10n;

  @override
  void didChangeDependencies() {
    l10n = L10n(context);
    dropDownData = DateDropDownData(3);
    DateTimeRange selectedItemDateRange = dropDownData.getDropDownItems(l10n)[dropDownData.selectedItemIndex].extraData;
    dataStream = EngineerAPIService.engineerPartReport(
        selectedItemDateRange.start.formatToSimpleDate(), selectedItemDateRange.end.formatToSimpleDate());
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return StreamBuilder<EngineerPartReportResponse?>(
      builder: (context, asyncSnapshot) {
        // handling error and loading state
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (asyncSnapshot.connectionState == ConnectionState.waiting) {
            CshLoading().showLoading(context);
          } else {
            CshLoading().hideLoading(context);
          }

          // handle errors
          if (asyncSnapshot.data?.errorMsg != null) {
            CshSnackBar.error(context: context, message: asyncSnapshot.data!.errorMsg!);
          }

          if (asyncSnapshot.error != null) {
            CshSnackBar.error(
                context: context,
                message: ApiErrorHelper.getErrorMessage(asyncSnapshot.error) ?? l10n.somethingWentWrong);
          }
        });

        // handle success response
        if (asyncSnapshot.hasData && asyncSnapshot.data != null) {
          EngineerPartReportResponse response = asyncSnapshot.data!;

          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(Dimens.space_16),
              child: Column(mainAxisSize: MainAxisSize.min, children: [
                DateRangePickerDropdownWidget((startDate, endDate) {
                  refreshData(startDate, endDate);
                }, data: dropDownData),
                const SizedBox(
                  height: Dimens.space_16,
                ),
                CshCard(
                    child: Column(
                  children: [
                    TitleValueRowWidget(title: l10n.avgPartCost, value: "₹ ${response.data?.avgPartCost}"),
                    TitleValueRowWidget(
                        title: l10n.avgRepairTime, value: response.data?.avgPartConsumption?.toString() ?? "-"),
                  ],
                )),
                const SizedBox(
                  height: Dimens.space_16,
                ),
                ReportPieChartWidget(
                  data: [
                    SectionData(Colors.lightBlue, response.data?.partsAssign?.toDouble(), l10n.partsAssigned),
                    SectionData(Colors.lightGreen, response.data?.partsConsume?.toDouble(), l10n.partsConsumed),
                    SectionData(Colors.grey, response.data?.partsReturn?.toDouble(), l10n.partsReturned),
                    SectionData(
                        Colors.deepOrangeAccent, response.data?.partsRequested?.toDouble(), l10n.partsRequested),
                  ],
                ),
                const SizedBox(
                  height: Dimens.space_16,
                ),
                const PartsLeadEngineerWidget(),
              ]),
            ),
          );
        } else {
          return const SizedBox.shrink();
        }
      },
      stream: dataStream,
    );
  }

  refreshData(String startDate, String endDate) {
    setState(() {
      dataStream = EngineerAPIService.engineerPartReport(startDate, endDate);
    });
  }

  @override
  bool get wantKeepAlive => true;
}
