import 'package:core/core.dart';
import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/src/common/utils/time_utils.dart';
import 'package:flutter_trc/src/common/widgets/title_value_row_widget.dart';
import 'package:flutter_trc/src/modules/engineer/l10n.dart';
import 'package:flutter_trc/src/modules/engineer/resources/engineer_api_service.dart';
import 'package:flutter_trc/src/modules/engineer/view_reports/common/date_range_picker_dropdown_widget.dart';

import '../../common/report_pie_chart_widget.dart';
import '../model/engineer_device_report_response.dart';
import 'device_lead_engineer_widget.dart';

class ViewReportDeviceWidget extends StatefulWidget {
  const ViewReportDeviceWidget({Key? key}) : super(key: key);

  @override
  State<ViewReportDeviceWidget> createState() => _ViewReportDeviceWidgetState();
}

class _ViewReportDeviceWidgetState extends State<ViewReportDeviceWidget> with AutomaticKeepAliveClientMixin {
  late Stream<EngineerDeviceReportResponse?> dataStream;

  late L10n l10n;
  late DateDropDownData dropDownData;

  @override
  void didChangeDependencies() {
    l10n = L10n(context);
    dropDownData = DateDropDownData(3);
    DateTimeRange selectedItemDateRange = dropDownData.getDropDownItems(l10n)[dropDownData.selectedItemIndex].extraData;
    dataStream = EngineerAPIService.engineerDeviceReport(
        selectedItemDateRange.start.formatToSimpleDate(), selectedItemDateRange.end.formatToSimpleDate());
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return StreamBuilder<EngineerDeviceReportResponse?>(
      builder: (context, asyncSnapshot) {
        // handling loading and error states
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
          EngineerDeviceReportResponse response = asyncSnapshot.data!;

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
                    TitleValueRowWidget(
                        title: l10n.efficiency.toString(), value: "${response.data?.efficiency?.toInt() ?? 0} %"),
                    TitleValueRowWidget(
                        title: l10n.avgRepairTime,
                        value: response.data?.avgRepairTime?.formatInReadableTimeDiff() ?? "-"),
                  ],
                )),
                const SizedBox(
                  height: Dimens.space_16,
                ),
                ReportPieChartWidget(
                  data: [
                    SectionData(
                        Colors.lightBlue, response.data?.totalAssignDevice?.toDouble(), l10n.totalAssignedDevices),
                    SectionData(Colors.lightGreen, response.data?.markedOkDevice?.toDouble(), l10n.markedOk),
                    SectionData(Colors.grey, response.data?.markedOkPassDevice?.toDouble(), l10n.markedOkPass),
                    SectionData(
                        Colors.deepOrangeAccent, response.data?.markedOkFailDevice?.toDouble(), l10n.markedOkFail),
                  ],
                ),
                const SizedBox(
                  height: Dimens.space_16,
                ),
                const DeviceLeadEngineerWidget(),
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
      dataStream = EngineerAPIService.engineerDeviceReport(startDate, endDate);
    });
  }

  @override
  bool get wantKeepAlive => true;
}
