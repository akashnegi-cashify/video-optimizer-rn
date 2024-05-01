import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/src/common/widgets/shimmer_list_widget.dart';
import 'package:flutter_trc/src/modules/engineer/models/device_report_response.dart';
import 'package:flutter_trc/src/modules/engineer/providers/device_report_provider.dart';

class DeviceReportWidget extends StatelessWidget {
  const DeviceReportWidget({super.key});

  @override
  Widget build(BuildContext context) {
    var provider = DeviceReportProvider.of(context);
    return FutureBuilder<DeviceReportData>(
      builder: (_, snapshot) {
        var theme = Theme.of(context);

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const ShimmerListWidget(itemCount: 3);
        }

        if (snapshot.hasError) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              snapshot.error.toString(),
              textAlign: TextAlign.center,
              style: theme.textTheme.bodyLarge!.copyWith(color: theme.colorScheme.error),
            ),
          );
        }

        var data = snapshot.data;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CshCard(
              cardWidth: double.infinity,
              margin: const EdgeInsets.fromLTRB(Dimens.space_16, Dimens.space_16, Dimens.space_16, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CshTextNew.subTitle1("Testing Remarks:"),
                  Container(
                    margin: const EdgeInsets.only(top: Dimens.space_4),
                    width: double.infinity,
                    padding: const EdgeInsets.all(Dimens.space_4),
                    color: Colors.grey.shade200,
                    child: Text(
                      data?.testingRemarks ?? "N/A",
                      maxLines: 3,
                      style: theme.primaryTextTheme.titleSmall,

                    ),
                  )
                ],
              ),
            ),
            Expanded(
                child: ListView.separated(
                    padding: const EdgeInsets.all(Dimens.space_16),
                    itemBuilder: (context, index) {
                      return _DeviceReportItem(data!.deviceReportList![index]);
                    },
                    separatorBuilder: (__, _) => const SizedBox(height: Dimens.space_16),
                    itemCount: data?.deviceReportList?.length ?? 0))
          ],
        );
      },
      future: provider.getDeviceReport(),
    );
  }
}

class _DeviceReportItem extends StatelessWidget {
  final DeviceReport deviceReport;

  const _DeviceReportItem(this.deviceReport, {super.key});

  @override
  Widget build(BuildContext context) {
    return CshCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Flexible(flex: 2, fit: FlexFit.tight, child: CshTextNew.subTitle2("Part Name:", isPrimary: false)),
              Flexible(flex: 3, child: CshTextNew.subTitle1(deviceReport.partName ?? "N/A")),
            ],
          ),
          const SizedBox(height: Dimens.space_8),
          Row(
            children: [
              Flexible(flex: 2, fit: FlexFit.tight, child: CshTextNew.subTitle2("Variation Name:", isPrimary: false)),
              Flexible(flex: 3, child: CshTextNew.subTitle1(deviceReport.variationName ?? "N/A")),
            ],
          ),
          const SizedBox(height: Dimens.space_8),
          Row(
            children: [
              Flexible(flex: 2, fit: FlexFit.tight, child: CshTextNew.subTitle2("Is Fail:", isPrimary: false)),
              Flexible(flex: 3, child: CshTextNew.subTitle1(deviceReport.isFail.toString())),
            ],
          ),
        ],
      ),
    );
  }
}
