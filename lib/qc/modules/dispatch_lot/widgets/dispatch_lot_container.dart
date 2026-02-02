import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_trc/qc/qc_common/lot_type_filters/screens/store_out_lot_filter_screen.dart';
import 'package:provider/provider.dart';

import '../providers/dispatch_lot_provider.dart';
import 'index.dart';

class DispatchLotContainer extends StatelessWidget {
  DispatchLotContainer({super.key});
  final GlobalKey<DispatchLotsWidgetState> globalKey = GlobalKey<DispatchLotsWidgetState>();

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(
          child: Stack(
            children: [
              DispatchLotsWidget(key: globalKey),
              Positioned(
                  bottom: 0,
                  right: 0,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: Dimens.space_20, vertical: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        FloatingActionButton(
                          onPressed: () => _openFilterScreen(context),
                          backgroundColor: theme.primaryColor,
                          heroTag: 'filter',
                          child: CshIcon(
                            FeatherIcons.filter,
                            iconColor: theme.colorScheme.background,
                          ),
                        ),

                      ],
                    ),
                  ))
            ],
          ),
        ),
      ],
    );
  }

  void _openFilterScreen(BuildContext context) {
    globalKey.currentState?.openFilter();
  }
}
