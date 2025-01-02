import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';

class FilterValueMultiType extends StatelessWidget {
  final String title;
  final bool isSelected;
  final Function(bool? isSelected)? onValueChanged;

  const FilterValueMultiType(this.title, this.isSelected, {super.key, this.onValueChanged});

  @override
  Widget build(BuildContext context) {
    return CshCheckbox(
      title: InkWell(onTap: () => onValueChanged?.call(!isSelected), child: CshTextNew.bodyText2(title)),
      visualDensity: VisualDensity.comfortable,
      isSelected: isSelected,
      onChanged: (value) {
        onValueChanged?.call(value);
      },
    );
  }
}
