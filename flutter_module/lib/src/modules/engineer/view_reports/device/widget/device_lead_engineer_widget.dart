import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/src/modules/engineer/l10n.dart';

import '../../../resources/engineer_api_service.dart';
import '../model/lead_engineer_device_report_response.dart';

class DeviceLeadEngineerWidget extends StatelessWidget {
  const DeviceLeadEngineerWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    L10n l10n = L10n(context);
    return StreamBuilder<LeadEngineerDeviceReportResponse?>(
      builder: (context, snapshot) {
        if (snapshot.hasData && snapshot.data != null) {
          return CshCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CshTextNew.h2(l10n.leadingEngineers),
                const SizedBox(
                  height: Dimens.space_4,
                ),
                if (snapshot.data!.data?.leadEngineerEfficiency != null)
                  _LeadEngineerItemWidget(
                      title: l10n.efficiency,
                      engineerName: snapshot.data!.data?.leadEngineerEfficiency!.engineerName ?? "-",
                      value: "${snapshot.data!.data?.leadEngineerEfficiency!.efficieny ?? "-"}"),
                if (snapshot.data!.data?.leadEngineerAvgRepairTime != null)
                  _LeadEngineerItemWidget(
                    title: l10n.avgRepairTime,
                    engineerName: snapshot.data!.data?.leadEngineerAvgRepairTime!.engineerName ?? "-",
                    value: "${(snapshot.data!.data?.leadEngineerAvgRepairTime!.repairTime ?? 0) / 1000} Seconds",
                  ),
                if (snapshot.data!.data?.leadEngineerVolume != null)
                  _LeadEngineerItemWidget(
                    title: l10n.volume,
                    engineerName: snapshot.data!.data?.leadEngineerVolume!.engineerName ?? "-",
                    value: "${(snapshot.data!.data?.leadEngineerVolume!.volume) ?? "-"}",
                  ),
              ],
            ),
          );
        } else {
          return const SizedBox.shrink();
        }
      },
      stream: EngineerAPIService.leadEngineerDeviceReport(),
    );
  }
}

class _LeadEngineerItemWidget extends StatelessWidget {
  const _LeadEngineerItemWidget({Key? key, required this.title, required this.engineerName, required this.value})
      : super(key: key);

  final String title;
  final String engineerName;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(Dimens.space_2),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CshTextNew.h6(title),
          CshTextNew.h5(engineerName),
          CshTextNew.h5(value),
        ],
      ),
    );
  }
}
