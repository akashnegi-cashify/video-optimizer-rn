import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';

class LabeledText extends StatelessWidget {
  final String label;
  final String? value;
  final TextStyle? labelTextStyle;
  final TextStyle? valueTextStyle;

  final int? labelFlex;
  final int? valueFlex;

  final CrossAxisAlignment? crossAxisAlignment;
  final EdgeInsets? padding;

  const LabeledText({
    super.key,
    required this.label,
    required this.value,
    this.labelTextStyle,
    this.valueTextStyle,
    this.labelFlex,
    this.valueFlex,
    this.crossAxisAlignment,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    if (isEmpty(value)) return const SizedBox.shrink();
    return Padding(
      padding: padding ?? const EdgeInsets.symmetric(horizontal: Dimens.space_16, vertical: Dimens.space_8),
      child: Row(
        crossAxisAlignment: crossAxisAlignment ?? CrossAxisAlignment.center,
        children: [
          Expanded(flex: labelFlex ?? 1,child: CshTextNew(label, textStyle: labelTextStyle)),
          Expanded(flex: valueFlex ?? 1,child: CshTextNew(value ?? '', textStyle: valueTextStyle)),
        ],
      ),
    );
  }
}
