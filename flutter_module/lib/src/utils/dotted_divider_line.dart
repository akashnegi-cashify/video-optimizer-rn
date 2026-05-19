import 'package:flutter/material.dart';

class DottedLineDivider extends StatelessWidget {
  final double height;
  final double dashWidth;
  final double dashHeight;
  final Color? color;
  final double width;
  final bool isHorizontalAxis;

  const DottedLineDivider(
      {this.height = 1,
      this.color,
      this.dashWidth = 10.0,
      this.isHorizontalAxis = true,
      this.width = 1,
      this.dashHeight = 10.0});

  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);

    if (isHorizontalAxis) {
      return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          final boxWidth = constraints.constrainWidth();
          final dashHeight = height;
          final dashCount = (boxWidth / (2 * dashWidth)).floor();
          return Flex(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            direction: Axis.horizontal,
            children: List.generate(
              dashCount,
              (_) {
                return SizedBox(
                  width: dashWidth,
                  height: dashHeight,
                  child: DecoratedBox(
                    decoration: BoxDecoration(color: color ?? themeData.dividerColor),
                  ),
                );
              },
            ),
          );
        },
      );
    }

    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final boxHeight = constraints.constrainHeight();
        final dashWidth = width;
        final dashCount = (boxHeight / (2 * dashHeight)).floor();
        return Flex(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          direction: Axis.vertical,
          children: List.generate(
            dashCount,
            (_) {
              return SizedBox(
                width: dashWidth,
                height: dashHeight,
                child: DecoratedBox(
                  decoration: BoxDecoration(color: color ?? themeData.dividerColor),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
