import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';

class ChartDescriptionWidget extends StatelessWidget {
  final Color tileColor;
  final String title;
  final String description;
  final int number;

  const ChartDescriptionWidget({
    Key? key,
    required this.title,
    required this.description,
    required this.number,
    required this.tileColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: theme.primaryTextTheme.headline4,
        ),
        const SizedBox(height: Dimens.space_8),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: Dimens.space_30,
              width: Dimens.space_100,
              color: tileColor,
              margin: const EdgeInsets.only(top: Dimens.space_16),
            ),
            const SizedBox(width: Dimens.space_16),
            Expanded(child: Text(description, style: theme.primaryTextTheme.bodyText2)),
            const SizedBox(width: Dimens.space_16),
            Padding(
              padding: const EdgeInsets.only(top: Dimens.space_16),
              child: Text(number.toString(), style: theme.primaryTextTheme.headline2),
            )
          ],
        ),
      ],
    );
  }
}
