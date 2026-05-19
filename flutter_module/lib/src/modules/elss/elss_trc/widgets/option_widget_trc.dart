import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';

import '../../common_models/elss_option_response.dart';
import '../l10n.dart';

enum SelectionType { rubbingApplicable, pnaApplicable, glassChangeApplicable, cameraCleaningApplicable }

class PartSelectionOptionWidget extends StatefulWidget {
  final OptionResponse dataModel;
  final int keyValue;
  final int groupValueKey;
  final Function(int) onGroupValueChanged;

  final Function(int, bool, bool, bool, {bool isCc}) onApplicableReasonCallback;

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
  void didUpdateWidget(PartSelectionOptionWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Reset sub-menu selection when switching to a different main option
    if (oldWidget.groupValueKey != widget.groupValueKey) {
      if (widget.keyValue != widget.groupValueKey) {
        setState(() {
          _selectedValue = null;
        });
      }
    }
  }

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
              Expanded(
                child: Text(widget.dataModel.optionName ?? "", style: theme.primaryTextTheme.headlineMedium),
              ),
              // Reset button - only show when option is selected AND has sub-menus
              if (widget.keyValue == widget.groupValueKey && (widget.dataModel.isApplicableReasonRequired ?? false))
                InkWell(
                  onTap: () {
                    // Reset sub-menu selections
                    setState(() {
                      _selectedValue = null;
                    });
                    // Clear applicable reasons in provider
                    widget.onApplicableReasonCallback(widget.keyValue, false, false, false, isCc: false);
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: Dimens.space_8, vertical: Dimens.space_4),
                    child: Text(
                      "Reset",
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: theme.primaryColor,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ),
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
                      widget.onApplicableReasonCallback(widget.keyValue, false, false, true, isCc: false);
                    },
                  ),
                  CshRadio(
                    groupValue: _selectedValue,
                    title: Text(l10n.pnaApplicable, style: theme.primaryTextTheme.headlineSmall),
                    value: SelectionType.pnaApplicable,
                    onChanged: (data) {
                      setValue(data);
                      widget.onApplicableReasonCallback(widget.keyValue, false, true, false, isCc: false);
                    },
                  ),
                  CshRadio(
                    groupValue: _selectedValue,
                    value: SelectionType.glassChangeApplicable,
                    title: Text(l10n.glassChangeApplicable, style: theme.primaryTextTheme.headlineSmall),
                    onChanged: (data) {
                      setValue(data);
                      widget.onApplicableReasonCallback(widget.keyValue, true, false, false, isCc: false);
                    },
                  ),
                  if (widget.dataModel.isCameraCleaningApplicable == true)
                    CshRadio(
                      groupValue: _selectedValue,
                      value: SelectionType.cameraCleaningApplicable,
                      title: Text(l10n.cameraCleaningApplicable, style: theme.primaryTextTheme.headlineSmall),
                      onChanged: (data) {
                        setValue(data);
                        widget.onApplicableReasonCallback(widget.keyValue, false, false, false, isCc: true);
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
