import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../l10n.dart';
import '../providers/index.dart';

class AcceptRejectRemarksWidget extends StatelessWidget {
  final VoidCallback? onRepairReject;
  final VoidCallback? onDeadAccept;
  const AcceptRejectRemarksWidget({super.key, this.onRepairReject, this.onDeadAccept});

  @override
  Widget build(BuildContext context) {
    var l10n = L10n(context);
    var provider = DeviceDeadAcceptRejectProvider.of(context);
    var theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: Dimens.space_16, vertical: Dimens.space_4),
      child: CshCard(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            CshTextNew.h3(l10n.remarks),
            const SizedBox(height: Dimens.space_8),
            RadioListWidget(list: provider.remarkList, onItemSelected: provider.onRemarkChange, padding: EdgeInsets.zero),
            Flexible(
              child: Row(
                children: [
                  Expanded(
                    child: Selector<DeviceDeadAcceptRejectProvider, RadioListItem?>(
                      builder: (BuildContext context, value, Widget? child) {
                        return CshBigButton(
                          text: l10n.acceptDead,
                          textStyle: theme.textTheme.headlineSmall,
                          onPressed: value?.isSelected == true ? onDeadAccept : null,
                        );
                      },
                      selector: (context, provider) {
                        return provider.getSelectedRemark();
                      },
                    ),
                  ),
                  const SizedBox(width: Dimens.space_12),
                  Expanded(
                    child: CshBigButton(
                      text: l10n.repairReject,
                      textStyle: theme.textTheme.headlineSmall,
                      onPressed:  onRepairReject,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

}
