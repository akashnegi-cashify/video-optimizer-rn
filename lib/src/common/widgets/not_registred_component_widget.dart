import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';

class NotRegistered extends StatelessWidget {
  const NotRegistered({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(Dimens.space_16),
        child: Text(
          "Your Component is not registered yet",
          style: theme.textTheme.subtitle1,
        ),
      ),
    );
  }
}
