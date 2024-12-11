import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';

import '../../common_models/elss_option_response.dart';
import '../l10n.dart';

enum SelectionType { rubbingApplicable, pnaApplicable, glassChangeApplicable }

class PartSelectionOptionWidget extends StatefulWidget {
  final OptionResponse dataModel;
  final int keyValue;
  final int groupValueKey;
  final Function(int) onGroupValueChanged;

  final Function(int, bool, bool, bool) onApplicableReasonCallback;

  const PartSelectionOptionWidget({
    Key? key,
    required this.onGroupValueChanged,
    required this.keyValue,
    required this.groupValueKey,
    required this.dataModel,
    required this.onApplicableReasonCallback,
  }) : super(key: key);

  @override
  State<PartSelectionOptionWidget> createState() => _PartSelectionOptionWidgetState();
}

class _PartSelectionOptionWidgetState extends State<PartSelectionOptionWidget> {
  SelectionType? _selectedValue;

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var l10n = L10n(context);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: Dimens.space_8, horizontal: Dimens.space_8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CshRadio<int>(
                value: widget.keyValue,
                groupValue: widget.groupValueKey,
                onChanged: (data) {
                  if (data != null) {
                    widget.onGroupValueChanged(data);
                  }
                },
              ),
              Text(widget.dataModel.optionName ?? "", style: theme.primaryTextTheme.headlineMedium)
            ],
          ),
          if (widget.keyValue == widget.groupValueKey && (widget.dataModel.isApplicableReasonRequired ?? false))
            AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              curve: Curves.easeIn,
              margin: const EdgeInsets.only(left: Dimens.space_16),
              child: Column(
                children: [
                  CshRadio(
                    groupValue: _selectedValue,
                    value: SelectionType.rubbingApplicable,
                    title: Text(l10n.rubbingApplicable, style: theme.primaryTextTheme.headlineSmall),
                    onChanged: (data) {
                      setValue(data);
                      widget.onApplicableReasonCallback(widget.keyValue, false, false, true);
                    },
                  ),
                  CshRadio(
                    groupValue: _selectedValue,
                    title: Text(l10n.pnaApplicable, style: theme.primaryTextTheme.headlineSmall),
                    value: SelectionType.pnaApplicable,
                    onChanged: (data) {
                      setValue(data);
                      widget.onApplicableReasonCallback(widget.keyValue, false, true, false);
                    },
                  ),
                  CshRadio(
                    groupValue: _selectedValue,
                    value: SelectionType.glassChangeApplicable,
                    title: Text(l10n.glassChangeApplicable, style: theme.primaryTextTheme.headlineSmall),
                    onChanged: (data) {
                      setValue(data);
                      widget.onApplicableReasonCallback(widget.keyValue, true, false, false);
                    },
                  ),
                ],
              ),
            )
        ],
      ),
    );
  }

  setValue(SelectionType? type) {
    setState(() {
      _selectedValue = type;
    });
  }
}
