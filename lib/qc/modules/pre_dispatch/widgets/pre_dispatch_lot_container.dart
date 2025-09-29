import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_trc/qc/qc_common/lot_type_filters/screens/store_out_lot_filter_screen.dart';

import '../providers/pre_dispatch_lot_provider.dart';
import 'index.dart';

class PreDispatchLotContainer extends StatelessWidget {
  const PreDispatchLotContainer({super.key});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Stack(
      children: [
        const PreDispatchLotsWidget(),
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
    var provider = PreDispatchLotProvider.of(context: context, listen: false);
    StoreOutLotFilterScreen.navigate(context, selectedLotType: provider.lotTypeQuery).then((value) {
      if (value != null && value is List<int>) {
        provider.lotTypeQuery = value;
      }
    });
  }
}
