import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';

/// zeplin screen :- PS_Modules_04
/// zeplin link :- https://zpl.io/L4kMJDY

class MyCounterButton extends StatefulWidget {
  final VoidCallback? onIncrementClick;
  final VoidCallback? onDecrementClick;
  final bool isAllowedBelowZero;
  final int counter;
  final bool isDismissed;
  final int? maxCount;

  const MyCounterButton(
      {Key? key,
      this.onIncrementClick,
      this.onDecrementClick,
      this.isAllowedBelowZero = false,
      this.isDismissed = false,
      this.maxCount,
      this.counter = 0})
      : super(key: key);

  @override
  _MyCounterButtonState createState() => _MyCounterButtonState();
}

class _MyCounterButtonState extends State<MyCounterButton> {
  late int _counter;

  final double _minButtonHeight = 32;
  final double _maxButtonHeight = 38;

  final double _minButtonWidth = 75;
  final double _maxButtonWidth = 100;

  @override
  void initState() {
    super.initState();
    _counter = widget.counter;
  }

  void increment() {
    if (_isMaxCountReached()) return;
    setState(() {
      _counter = _counter + 1;
    });
    if (widget.onIncrementClick != null) {
      widget.onIncrementClick!();
    }
  }

  void decrement() {
    setState(() {
      _counter = _counter - 1;
    });
    if (widget.onDecrementClick != null) {
      widget.onDecrementClick!();
    }
  }

  bool _isMaxCountReached() {
    return widget.maxCount != null && _counter == widget.maxCount!;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    CustomColors? customTheme = theme.extension<CustomColors>() as CustomColors;
    double width = ScreenUtil.getScaleFactor(_maxButtonWidth, _minButtonWidth, ScreenUtil.getScreenWidth());
    double height = ScreenUtil.getScaleFactor(_maxButtonHeight, _minButtonHeight, ScreenUtil.getScreenWidth());

    var removeIcon = Container(
        height: height,
        decoration: BoxDecoration(
            color: theme.primaryColor,
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(CshRadius.rad4.value), topLeft: Radius.circular(CshRadius.rad4.value))),
        child: CshIcon.assets(
          packageIcon('ic_remove.png'),
          iconSize: MobileIconSize.small,
          padding: EdgeInsets.zero,
          onClick: () {
            decrement();
          },
        ));

    var addIcon = Container(
      decoration: BoxDecoration(
        color: theme.primaryColor,
        borderRadius: BorderRadius.only(
          bottomRight: Radius.circular(CshRadius.rad4.value),
          topRight: Radius.circular(CshRadius.rad4.value),
        ),
      ),
      height: height,
      child: CshIcon.assets(
        packageIcon('ic_add.png'),
        iconSize: MobileIconSize.small,
        padding: EdgeInsets.zero,
        onClick: () {
          increment();
        },
      ),
    );

    var counterText = Container(
      padding: EdgeInsets.symmetric(horizontal: Dimens.space_4.px),
      height: height,
      alignment: Alignment.center,
      child: CshText.multiline(
        '$_counter',
        style: theme.primaryTextTheme.headlineSmall?.copyWith(
          color: theme.primaryColor,
        ),
        maxLines: 1,
      ),
    );

    var addText = InkWell(
      borderRadius: BorderRadius.circular(CshRadius.rad4.value),
      onTap: widget.isDismissed
          ? null
          : () {
              increment();
            },
      child: Container(
          padding: EdgeInsets.symmetric(horizontal: Dimens.space_4.px),
          height: height,
          alignment: Alignment.center,
          child: CshText.multiline(
            'Add',
            style: theme.primaryTextTheme.headlineSmall?.copyWith(
              color: widget.isDismissed ? customTheme.inputStrokeColor : theme.primaryColor,
            ),
            maxLines: 1,
          )),
    );

    return Container(
      foregroundDecoration: BoxDecoration(
          border: Border.all(color: widget.isDismissed ? customTheme.inputStrokeColor : theme.primaryColor),
          borderRadius: BorderRadius.circular(CshRadius.rad4.value)),
      constraints: BoxConstraints(maxHeight: height, maxWidth: width),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(CshRadius.rad4.value),
        child: Row(
          children: widget.isDismissed
              ? [Expanded(child: addText)]
              : [
                  if (widget.isAllowedBelowZero || _counter > 0) ...[
                    Expanded(child: removeIcon),
                    Expanded(flex: 2, child: counterText),
                    Expanded(child: addIcon)
                  ] else ...[
                    Expanded(child: addText)
                  ]
                ],
        ),
      ),
    );
  }
}
