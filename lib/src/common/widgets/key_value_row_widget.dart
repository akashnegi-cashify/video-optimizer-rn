import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';

class KeyValueRowWidget extends StatelessWidget {
  final String title;
  final String value;

  const KeyValueRowWidget({Key? key, required this.title, required this.value}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CshTextNew.bodyText2(title),
        const SizedBox(width: Dimens.space_6),
        Expanded(
          child: Text(
            value,
            style: theme.primaryTextTheme.headline4,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        )
      ],
    );
  }
}
