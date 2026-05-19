import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/src/modules/engineer/l10n.dart';
import 'package:flutter_trc/src/modules/engineer/view_reports/parts/model/lead_engineer_part_report_response.dart';

import '../../../resources/engineer_api_service.dart';

class PartsLeadEngineerWidget extends StatefulWidget {
  const PartsLeadEngineerWidget({Key? key}) : super(key: key);

  @override
  State<PartsLeadEngineerWidget> createState() => _PartsLeadEngineerWidgetState();
}

class _PartsLeadEngineerWidgetState extends State<PartsLeadEngineerWidget> {
  @override
  Widget build(BuildContext context) {
    L10n l10n = L10n(context);
    return StreamBuilder<LeadEngineerPartReportResponse?>(
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
                if (snapshot.data!.data?.leadEngineerPartCost != null)
                  _LeadPartsItemWidget(
                      title: l10n.avgPartCost,
                      engineerName: snapshot.data!.data?.leadEngineerPartCost!.engineerName ?? "-",
                      value: "₹ ${snapshot.data!.data?.leadEngineerPartCost!.partCost ?? "-"}"),
                if (snapshot.data!.data?.leadEngineerPartConsumption != null)
                  _LeadPartsItemWidget(
                    title: l10n.avgRepairTime,
                    engineerName: snapshot.data!.data?.leadEngineerPartConsumption!.engineerName ?? "-",
                    value: "${(snapshot.data!.data?.leadEngineerPartConsumption!.partConsumption ?? 0) / 1000}",
                  ),
              ],
            ),
          );
        } else {
          return const SizedBox.shrink();
        }
      },
      stream: EngineerAPIService.leadEngineerPartReport(),
    );
  }
}

class _LeadPartsItemWidget extends StatelessWidget {
  const _LeadPartsItemWidget({Key? key, required this.title, required this.engineerName, required this.value})
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
