import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';

import 'index.dart';

class PreDispatchLotContainer extends StatelessWidget {
  PreDispatchLotContainer({super.key});

  final GlobalKey<PreDispatchLotsWidgetState> key = GlobalKey<PreDispatchLotsWidgetState>();

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Stack(
      children: [
        PreDispatchLotsWidget(key: key),
        Positioned(
          bottom: Dimens.space_16,
          right: Dimens.space_16,
          child: FloatingActionButton(
            onPressed: () => _openFilterScreen(context),
            backgroundColor: theme.primaryColor,
            heroTag: 'filter',
            child: CshIcon(
              FeatherIcons.filter,
              iconColor: theme.colorScheme.surface,
            ),
          ),
        )
      ],
    );
  }

  void _openFilterScreen(BuildContext context) {
    key.currentState?.openFilter();
  }
}
