import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/qc/modules/qc_tester/lob_devices/resources/reasons.dart';

import '../l10n.dart';

void showTimeOutReasonDialog(BuildContext context, List<Reasons> reasons,
    {required Function(Reasons reason) onReasonSelected}) {
  var l10n = L10n(context, listen: false);
  showCshBottomSheet(
    isDismissible: false,
    isScrollControlled: true,
    context: context,
    child: Container(
      constraints: BoxConstraints(maxHeight: MediaQuery.of(context).size.height * 0.6),
      padding: const EdgeInsets.all(Dimens.space_16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          CshTextNew.h3(l10n.unableToScan),
          const SizedBox(height: Dimens.space_16),
          ListView.separated(
              shrinkWrap: true,
              itemBuilder: (context, index) {
                var item = reasons[index];
                return GestureDetector(
                  onTap: () => onReasonSelected(item),
                  child: CshCard(child: CshTextNew.subTitle1(item.name ?? "NA")),
                );
              },
              separatorBuilder: (context, index) {
                return const SizedBox(height: Dimens.space_8);
              },
              itemCount: reasons.length),
        ],
      ),
    ),
  );
}
