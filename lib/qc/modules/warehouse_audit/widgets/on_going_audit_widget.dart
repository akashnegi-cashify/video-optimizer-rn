import 'package:components/list_page/config/list_api_config.dart';
import 'package:components/list_page/widgets/csh_api_list.dart';
import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/qc/modules/warehouse_audit/resources/ongoing_audit_response.dart';
import 'package:flutter_trc/qc/modules/warehouse_audit/screens/warehouse_audit_perform_screen.dart';
import 'package:flutter_trc/src/services/service_groups.dart';

import '../l10n.dart';

class OnGoingAuditWidget extends StatefulWidget {
  const OnGoingAuditWidget({super.key});

  @override
  State<OnGoingAuditWidget> createState() => _OnGoingAuditWidgetState();
}

class _OnGoingAuditWidgetState extends State<OnGoingAuditWidget> {
  @override
  Widget build(BuildContext context) {
    var l10n = L10n(context);
    return CshApiList<OnGoingAuditData>(
      apiConfig: ListApiConfig(apiUrl: "/warehouse-audit/app/list", serviceGroup: TRCServiceGroups.qcConsole),
      shimmerLoaderWidget: const CshShimmer(height: Dimens.space_60),
      itemFromJson: OnGoingAuditData.fromJson,
      noDataFoundWidget: ({isListEmpty, serverErrorMsg}) {
        return Center(child: CshTextNew.subTitle1(l10n.emptyAuditList));
      },
      getRowWidget: (item, index) {
        return GestureDetector(
          onTap: () => WarehouseAuditPerformScreen.pushNamed(context, item!.auditId!),
          child: _Item(item),
        );
      },
    );
  }
}

class _Item extends StatelessWidget {
  final OnGoingAuditData? item;

  const _Item(this.item, {super.key});

  @override
  Widget build(BuildContext context) {
    var l10n = L10n(context);
    return CshCard(
      child: Column(
        children: [
          _row(l10n.auditId, item?.auditId.toString() ?? ""),
          _row(l10n.facilityName, item?.facilityName ?? ""),
          _row(
            l10n.startTime,
            formatDate(timeStamp: item?.startDate?.toInt(), pattern: DateFormats.dd_MMM_yyyy_HH_mm_ss.value),
          ),
          _row(
            l10n.endTime,
            formatDate(timeStamp: item?.endDate?.toInt(), pattern: DateFormats.dd_MMM_yyyy_HH_mm_ss.value),
          ),
        ],
      ),
    );
  }

  _row(String label, String? value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: Dimens.space_4),
      child: Row(
        children: [
          Flexible(flex: 2, fit: FlexFit.tight, child: CshTextNew.subTitle2(label, isPrimary: false)),
          Flexible(flex: 3, fit: FlexFit.tight, child: CshTextNew.subTitle1(value ?? "")),
        ],
      ),
    );
  }
}
