import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';

class TitleValueRowWidget extends StatelessWidget {
  final String title;
  final String value;

  const TitleValueRowWidget({Key? key, required this.title, required this.value}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CshTextNew.bodyText1("$title:"),
        const SizedBox(width: Dimens.space_4),
        Expanded(
          child: Text(
            value,
            style: theme.primaryTextTheme.headlineMedium,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        )
      ],
    );
  }
}
