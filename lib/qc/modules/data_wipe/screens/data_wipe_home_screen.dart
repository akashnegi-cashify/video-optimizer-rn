import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/qc/modules/data_wipe/screens/data_wipe_detail_screen.dart';
import 'package:flutter_trc/qc/modules/data_wipe/screens/data_wipe_list_screen.dart';
import 'package:flutter_trc/src/common/utils/csh_ml_scanner_util.dart';

import '../l10n.dart';

class DataWipeHomeScreen extends StatelessWidget {
  static const String route = "/QC_data_wipe_home_screen";

  const DataWipeHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var l10n = L10n(context);
    return Scaffold(
      appBar: CshHeader(l10n.dataWipe),
      body: Container(
        padding: const EdgeInsets.all(Dimens.space_16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CshBigButton(
              text: l10n.dataWipe,
              onPressed: () {
                CshMlScannerUtil().openScanner(
                  context,
                  onScanned: (scannedData, controller) {
                    Navigator.pop(context); // dismiss scanner screen
                    DataWipeDetailScreen.navigateTo(context, scannedData);
                  },
                );
              },
            ),
            const SizedBox(height: Dimens.space_16),
            CshBigButton(
              text: l10n.dataWipeList,
              onPressed: () {
                Navigator.pushNamed(context, DataWipeListScreen.route);
              },
            ),
          ],
        ),
      ),
    );
  }
}
