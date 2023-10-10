import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../l10n.dart';
import '../providers/store_in_provider.dart';

class StoreInLocationScanWidget extends StatelessWidget {
  final String? barcode;

  const StoreInLocationScanWidget({super.key, this.barcode});

  @override
  Widget build(BuildContext context) {
    var l10n = L10n(context);
    return ChangeNotifierProvider(
      create: (_) => StoreInProvider(barcode),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
              child: Container(
            color: Colors.orange,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [

              ],
            ),
          )),
          Padding(
            padding: const EdgeInsets.all(Dimens.space_16),
            child: Row(
              children: [
                Expanded(child: CshBigButton(text: l10n.goBack, onPressed: () => _goBack(context))),
                const SizedBox(width: Dimens.space_8),
                Expanded(child: CshBigButton(text: l10n.scanDevice, onPressed: () => _scanDevice(context))),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _goBack(BuildContext context) {}

  void _scanDevice(BuildContext context) {}
}
