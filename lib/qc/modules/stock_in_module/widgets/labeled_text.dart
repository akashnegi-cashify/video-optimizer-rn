import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';

class LabeledText extends StatelessWidget {
  final String label;
  final String? value;

  const LabeledText({
    super.key,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    if(isEmpty(value)) return const SizedBox.shrink();
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: Dimens.space_16, vertical: Dimens.space_8),
      child: Row(
        children: [
          Expanded(child: CshTextNew.h3(label)),
          Expanded(child: CshTextNew.h3(value ?? '')),
        ],
      ),
    );
  }
}
