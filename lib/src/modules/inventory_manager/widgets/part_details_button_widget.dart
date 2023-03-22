import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import '../l10n.dart';


// mixin PartDetailButtonListener {
//   void assignBtnOnPressed();
//   void deadPartOnPressed();
//   void alternatePartBtnOnPressed();
//   void goBackBtnOnPressed();
//   void cancelBtnOnPressed();
// }

class PartDetailsButtonWidget extends StatefulWidget {
  final bool cancelBtnEnable, assignBtnEnable, deadPartBtnEnable, alternativePartBtnEnable, goBackBtnEnable;
  final bool cancelBtnVisible, assignBtnVisible, deadPartBtnVisible, alternativePartBtnVisible, goBackBtnVisible;
  final Function()? cancelBtnOnPressed,
      assignBtnOnPressed,
      deadPartOnPressed,
      alternatePartBtnOnPressed,
      goBackBtnOnPressed;

  // final PartDetailButtonListener? listener;

  const PartDetailsButtonWidget({
    Key? key,
    required this.alternativePartBtnEnable,
    required this.assignBtnEnable,
    required this.cancelBtnEnable,
    required this.deadPartBtnEnable,
    required this.goBackBtnEnable,
    required this.alternativePartBtnVisible,
    required this.assignBtnVisible,
    required this.cancelBtnVisible,
    required this.deadPartBtnVisible,
    required this.goBackBtnVisible,
    this.alternatePartBtnOnPressed,
    this.assignBtnOnPressed,
    this.cancelBtnOnPressed,
    this.deadPartOnPressed,
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
  @override
  Widget build(BuildContext context) {
    var l10n = L10n(context);
    var theme = Theme.of(context);
    return Row(
      children: [
        if (widget.cancelBtnVisible) ...[
          Flexible(
            child: _buttonWidget(
              theme,
              label: l10n.cancel,
              isEnable: widget.cancelBtnEnable,
              onPressed: widget.cancelBtnOnPressed ?? () {},
            ),
          ),
          const SizedBox(width: Dimens.space_6),
        ],
        if (widget.assignBtnVisible) ...[
          Flexible(
            child: _buttonWidget(
              theme,
              label: l10n.assign,
              isEnable: widget.assignBtnEnable,
              onPressed: widget.assignBtnOnPressed ?? () {},
            ),
          ),
          const SizedBox(width: Dimens.space_6),
        ],
        if (widget.deadPartBtnVisible) ...[
          Flexible(
            child: _buttonWidget(
              theme,
              label: l10n.deadPart,
              isEnable: widget.deadPartBtnEnable,
              onPressed: widget.deadPartOnPressed ?? () {},
            ),
          ),
          const SizedBox(width: Dimens.space_6),
        ],
        if (widget.alternativePartBtnVisible) ...[
          Flexible(
            child: _buttonWidget(
              theme,
              label: l10n.alternatePart,
              isEnable: widget.alternativePartBtnEnable,
              onPressed: widget.alternatePartBtnOnPressed ?? () {},
            ),
          ),
          const SizedBox(width: Dimens.space_6),
        ],
        if (widget.goBackBtnVisible) ...[
          Flexible(
            child: _buttonWidget(
              theme,
              label: l10n.goBack,
              isEnable: widget.goBackBtnEnable,
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
