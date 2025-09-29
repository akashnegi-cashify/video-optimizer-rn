import 'dart:math';

import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';

class ShimmerListWidget extends StatelessWidget {
  final int? itemCount;
  final double itemHeight;
  final double itemWidth;
  final EdgeInsets itemPadding;
  final int? height;

  const ShimmerListWidget({
    Key? key,
    this.itemCount,
    this.itemWidth = double.infinity,
    this.itemHeight = Dimens.space_120,
    this.itemPadding = const EdgeInsets.symmetric(vertical: Dimens.space_8, horizontal: Dimens.space_16),
    this.height,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        int maxHeight = height ?? constraints.maxHeight.toInt();

        int maxItems = maxHeight ~/ (itemHeight + itemPadding.top + itemPadding.bottom);

        if (itemCount != null && maxItems < itemCount!) {
          throw Exception("No of items can't fit in the view, try reducing item count!");
        } else {
          return ListView.builder(
              shrinkWrap: true,
              itemBuilder: (context, _) {
                return Align(
                  child: Padding(
                      padding: itemPadding,
                      child: CshShimmer(
                        height: itemHeight,
                        width: itemWidth,
                      )),
                );
              },
              itemCount: min(itemCount ?? maxItems, maxItems));
        }
      },
    );
  }
}
