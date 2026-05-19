import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';

class OptionWidget extends StatefulWidget {
  final String keyValue;
  final String groupValue;
  final Function(String) onValueChanged;
  final String optionData;

  const OptionWidget({
    Key? key,
    required this.keyValue,
    required this.groupValue,
    required this.onValueChanged,
    required this.optionData,
  }) : super(key: key);

  @override
  State<OptionWidget> createState() => _OptionWidgetState();
}

class _OptionWidgetState extends State<OptionWidget> {
  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Row(
      children: [
        CshRadio<String>(
          value: widget.keyValue,
          groupValue: widget.groupValue,
          onChanged: (data) {
            if (!Validator.isNullOrEmpty(data)) {
              widget.onValueChanged(data!);
            }
          },
        ),
        Expanded(
          child: Text(
            widget.optionData,
            style: theme.primaryTextTheme.displaySmall,
          ),
        )
      ],
    );
  }
}
