import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';

class LabeledText extends StatelessWidget {
  final String label;
  final String? value;
  final TextStyle? labelTextStyle;
  final TextStyle? valueTextStyle;

  const LabeledText({
    super.key,
    required this.label,
    required this.value,
    this.labelTextStyle,
    this.valueTextStyle,
  });

  @override
  Widget build(BuildContext context) {
    if (isEmpty(value)) return const SizedBox.shrink();
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: Dimens.space_16, vertical: Dimens.space_8),
      child: Row(
        children: [
          Expanded(child: CshTextNew(label, textStyle: labelTextStyle)),
          Expanded(child: CshTextNew(value ?? '', textStyle: valueTextStyle)),
        ],
      ),
    );
  }
}
