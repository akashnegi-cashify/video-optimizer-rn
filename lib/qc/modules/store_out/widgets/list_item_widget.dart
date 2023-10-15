import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/src/common/widgets/labeled_text.dart';
import '../l10n.dart';

class ListItemWidget extends StatelessWidget {
  final String? lotName;
  final String? noOfDevices;
  final String? id;
  final String? lotType;

  const ListItemWidget({
    super.key,
    this.lotName,
    this.noOfDevices,
    this.id,
    this.lotType,
  });

  @override
  Widget build(BuildContext context) {
    var l10n = L10n(context);
    var theme = Theme.of(context);
    var labelTextStyle = theme.textTheme.headlineMedium;
    var valueTextStyle = theme.primaryTextTheme.headlineMedium;

    return CshCard(
      padding: EdgeInsets.zero,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          LabeledText(
            label: l10n.lotName,
            value: lotName,
            labelFlex: 2,
            valueFlex: 3,
            labelTextStyle: labelTextStyle,
            valueTextStyle: valueTextStyle,
            crossAxisAlignment: CrossAxisAlignment.start,
            padding: const EdgeInsets.symmetric(horizontal: Dimens.space_12, vertical: Dimens.space_4),

          ),
          LabeledText(label: l10n.noOfDevices, value: noOfDevices,
            labelFlex: 2,
            valueFlex: 3,
            labelTextStyle: labelTextStyle,
            valueTextStyle: valueTextStyle,
            crossAxisAlignment: CrossAxisAlignment.start,
            padding: const EdgeInsets.symmetric(horizontal: Dimens.space_12, vertical: Dimens.space_4),

          ),
          LabeledText(label: l10n.id, value: id,
            labelFlex: 2,
            valueFlex: 3,
            labelTextStyle: labelTextStyle,
            valueTextStyle: valueTextStyle,
            crossAxisAlignment: CrossAxisAlignment.start,
            padding: const EdgeInsets.symmetric(horizontal: Dimens.space_12, vertical: Dimens.space_4),
          ),
          LabeledText(label: l10n.lotType, value: lotType,
            labelFlex: 2,
            valueFlex: 3,
            labelTextStyle: labelTextStyle,
            valueTextStyle: valueTextStyle,
            crossAxisAlignment: CrossAxisAlignment.start,
            padding: const EdgeInsets.symmetric(horizontal: Dimens.space_12, vertical: Dimens.space_4),
          ),
          const SizedBox(height: Dimens.space_4),
        ],
      ),
    );
  }
}
