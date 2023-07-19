import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/src/modules/part_qc/screens/pq_status_change_screen.dart';

import '../../../screens/barcode_scanner_screen.dart';
import '../l10n.dart';
import '../providers/pq_provider.dart';

class ReaderTabWidget extends StatelessWidget {
  const ReaderTabWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var l10n = L10n(context);
    var provider = PartQcProvider.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: Dimens.space_30),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: double.infinity,
              child: CshMediumButton(
                text: l10n.scanPartBarcode,
                onPressed: () {
                  Navigator.of(context).pushNamed(
                    BarcodeScanWidget.route,
                    arguments: (String data) {
                      if (!Validator.isNullOrEmpty(data)) {
                        Navigator.of(context).pop();
                        _getParticularCodeData(context, data.trim());
                      }
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  _getParticularCodeData(BuildContext context, String pbr) {
    var provider = PartQcProvider.of(context, listen: false);
    CshLoading().showLoading(context);
    provider.fetchQcPartList(pbr: pbr).then((value) {
      CshLoading().hideLoading(context);
      PartQcPartStatusScreenArguments arg = PartQcPartStatusScreenArguments(
        partDetails: value!.dataList?.first,
      );
      Navigator.of(context).pushNamed(PartQcPartStatusScreen.route, arguments: arg);
    }, onError: (error) {
      CshLoading().hideLoading(context);
      CshSnackBar.error(context: context, message: error);
    });
  }
}
