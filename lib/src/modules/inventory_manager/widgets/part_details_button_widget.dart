import 'dart:async';

import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import '../l10n.dart';
import '../resources/part_status_enum.dart';

class _DisableAndVisible {
  bool disable;
  bool isVisible;

  _DisableAndVisible({
    required this.disable,
    required this.isVisible,
  });
}


// mixin PartDetailButtonListener {
//   void assignBtnOnPressed();
//   void deadPartOnPressed();
//   void alternatePartBtnOnPressed();
//   void goBackBtnOnPressed();
//   void cancelBtnOnPressed();
// }

class PartDetailsButtonWidget extends StatefulWidget {
  final int statusCode;
  final Function()? cancelBtnOnPressed,
      assignBtnOnPressed,
      deadPartOnPressed,
      alternatePartBtnOnPressed,
      goBackBtnOnPressed;

  // final PartDetailButtonListener? listener;

  const PartDetailsButtonWidget({
    Key? key,
    required this.statusCode,
    this.alternatePartBtnOnPressed,
    this.deadPartOnPressed,
    this.assignBtnOnPressed,
    this.cancelBtnOnPressed,
    this.goBackBtnOnPressed,
    // this.listener,
  }) : super(key: key);

  @override
  State<PartDetailsButtonWidget> createState() => _PartDetailsButtonWidgetState();
}

// class _ButtonState {
//   bool? isDisabled;
//   bool? isVisible;
//
//   _ButtonState(this.isDisabled, this.isVisible) {
//     assert();
//   }
// }

class _PartDetailsButtonWidgetState extends State<PartDetailsButtonWidget> {
  _DisableAndVisible? _cancelButtonState;
  _DisableAndVisible? _assignButtonState;
  _DisableAndVisible? _deadButtonState;
  _DisableAndVisible? _alternativeButtonState;
  _DisableAndVisible? _goBackButtonState;

  @override
  void initState() {
    scheduleMicrotask(() {
      _checkStatusAndDisplayButton(widget.statusCode);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var l10n = L10n(context);
    var theme = Theme.of(context);
    return Row(
      children: [
        if (_cancelButtonState?.isVisible ?? false) ...[
          Flexible(
            child: _buttonWidget(
              theme,
              label: l10n.cancel,
              isEnable: _cancelButtonState!.disable,
              onPressed: widget.cancelBtnOnPressed ?? () {},
            ),
          ),
          const SizedBox(width: Dimens.space_6),
        ],
        if (_assignButtonState?.isVisible ?? false) ...[
          Flexible(
            child: _buttonWidget(
              theme,
              label: l10n.assign,
              isEnable: _assignButtonState!.disable,
              onPressed: widget.assignBtnOnPressed ?? () {},
            ),
          ),
          const SizedBox(width: Dimens.space_6),
        ],
        if (_deadButtonState?.isVisible ?? false) ...[
          Flexible(
            child: _buttonWidget(
              theme,
              label: l10n.deadPart,
              isEnable: _deadButtonState!.disable,
              onPressed: widget.deadPartOnPressed ?? () {},
            ),
          ),
          const SizedBox(width: Dimens.space_6),
        ],
        if (_alternativeButtonState?.isVisible ?? false) ...[
          Flexible(
            child: _buttonWidget(
              theme,
              label: l10n.alternatePart,
              isEnable: _alternativeButtonState!.disable,
              onPressed: widget.alternatePartBtnOnPressed ?? () {},
            ),
          ),
          const SizedBox(width: Dimens.space_6),
        ],
        if (_goBackButtonState?.isVisible ?? false) ...[
          Flexible(
            child: _buttonWidget(
              theme,
              label: l10n.goBack,
              isEnable: _goBackButtonState!.disable,
              onPressed: () {
                Navigator.of(context).pop(true);
              },
            ),
          ),
          const SizedBox(width: Dimens.space_6),
        ]
      ],
    );
  }

  _checkStatusAndDisplayButton(int statusCode) {
    if (PartStatus.getEnumByValue(statusCode) == PartStatus.OTHER) {
      _cancelButtonState = _DisableAndVisible(disable: false, isVisible: true);
      _assignButtonState = _DisableAndVisible(disable: false, isVisible: true);
      _deadButtonState = _DisableAndVisible(disable: false, isVisible: true);
      _alternativeButtonState = _DisableAndVisible(disable: false, isVisible: true);
      _goBackButtonState = _DisableAndVisible(disable: false, isVisible: false);
    } else if (PartStatus.getEnumByValue(statusCode) == PartStatus.AVAILABLE) {
      _cancelButtonState = _DisableAndVisible(disable: true, isVisible: true);
      _assignButtonState = _DisableAndVisible(disable: true, isVisible: true);
      _deadButtonState = _DisableAndVisible(disable: false, isVisible: false);
      _alternativeButtonState = _DisableAndVisible(disable: false, isVisible: false);
      _goBackButtonState = _DisableAndVisible(disable: false, isVisible: false);
    } else if (PartStatus.getEnumByValue(statusCode) == PartStatus.NOT_AVAILABLE) {
      _cancelButtonState = _DisableAndVisible(disable: true, isVisible: true);
      _assignButtonState = _DisableAndVisible(disable: false, isVisible: false);
      _deadButtonState = _DisableAndVisible(disable: true, isVisible: true);
      _alternativeButtonState = _DisableAndVisible(disable: true, isVisible: true);
      _goBackButtonState = _DisableAndVisible(disable: false, isVisible: false);
    }
    setState(() {});
  }

  _buttonWidget(ThemeData theme, {required String label, required bool isEnable, required Function() onPressed}) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        height: Dimens.space_40,
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(horizontal: Dimens.space_4),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(Dimens.space_4),
          color: isEnable ? theme.primaryColor : theme.shadowColor.withOpacity(0.5),
        ),
        child: Text(
          label,
          textAlign: TextAlign.center,
          style: theme.primaryTextTheme.headline6?.copyWith(color: theme.backgroundColor),
        ),
      ),
    );
  }
}
