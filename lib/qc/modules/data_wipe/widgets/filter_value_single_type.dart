import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';

class FilterValueSingleType extends StatelessWidget {
  final String title;
  final String value;
  final String groupValue;
  final Function(String? isSelected)? onValueChanged;

  const FilterValueSingleType(this.title, this.value, this.groupValue, {super.key, this.onValueChanged});

  @override
  Widget build(BuildContext context) {
    return CshRadio<String>(
      value: value,
      title: CshTextNew.bodyText2(title),
      groupValue: groupValue,
      onChanged: (value) {
        onValueChanged?.call(value);
      },
    );
  }
}
