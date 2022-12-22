import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';

import '../l10n.dart';
import '../models/elss_option_response.dart';

class PartSelectionOptionWidget extends StatefulWidget {
  final OptionResponse dataModel;
  final int keyValue;
  final int groupValueKey;
  final Function(int) onGroupValueChanged;

  final Function(int, bool, bool, bool)? onApplicableReasonCallback;

  const PartSelectionOptionWidget({
    Key? key,
    required this.onGroupValueChanged,
    required this.keyValue,
    required this.groupValueKey,
    required this.dataModel,
    this.onApplicableReasonCallback,
  }) : super(key: key);

  @override
  State<PartSelectionOptionWidget> createState() => _PartSelectionOptionWidgetState();
}

class _PartSelectionOptionWidgetState extends State<PartSelectionOptionWidget> {
  bool _isPna = false, _isGca = false, _isRub = false;

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
              Text(widget.dataModel.optionName ?? "", style: theme.primaryTextTheme.headline4)
            ],
          ),
          if (widget.keyValue == widget.groupValueKey && (widget.dataModel.isApplicableReasonRequired ?? false))
            AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              curve: Curves.easeIn,
              child: Column(
                children: [
                  Row(
                    children: [
                      CshCheckbox(
                        isSelected: _isRub,
                        onChanged: (data) {
                          _isRub = !_isRub;
                          if (widget.onApplicableReasonCallback != null) {
                            widget.onApplicableReasonCallback!(widget.keyValue, _isGca, _isPna, _isRub);
                          }
                        },
                      ),
                      const SizedBox(width: Dimens.space_8),
                      Text(l10n.rubbingApplicable, style: theme.primaryTextTheme.headline5)
                    ],
                  ),
                  Row(
                    children: [
                      CshCheckbox(
                        isSelected: _isPna,
                        onChanged: (data) {
                          _isPna = !_isPna;
                          if (widget.onApplicableReasonCallback != null) {
                            widget.onApplicableReasonCallback!(widget.keyValue, _isGca, _isPna, _isRub);
                          }
                        },
                      ),
                      const SizedBox(width: Dimens.space_8),
                      Text(l10n.pnaApplicable, style: theme.primaryTextTheme.headline5)
                    ],
                  ),
                  Row(
                    children: [
                      CshCheckbox(
                        isSelected: _isGca,
                        onChanged: (data) {
                          _isGca = !_isGca;
                          if (widget.onApplicableReasonCallback != null) {
                            widget.onApplicableReasonCallback!(widget.keyValue, _isGca, _isPna, _isRub);
                          }
                        },
                      ),
                      const SizedBox(width: Dimens.space_8),
                      Text(l10n.glassChangeApplicable, style: theme.primaryTextTheme.headline5)
                    ],
                  ),
                ],
              ),
            )
        ],
      ),
    );
  }
}
