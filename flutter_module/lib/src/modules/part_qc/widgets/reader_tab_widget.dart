import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/src/common/utils/csh_ml_scanner_util.dart';

import '../l10n.dart';
import '../providers/pq_provider.dart';

class ReaderTabWidget extends StatelessWidget {
  const ReaderTabWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var l10n = L10n(context);
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
                  CshMlScannerUtil().openScanner(
                    context,
                    onScanned: (scannedData, controller) {
                      if (!Validator.isNullOrEmpty(scannedData)) {
                        Navigator.of(context).pop();
                        _getParticularCodeData(context, scannedData.trim());
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
      // PartQcPartStatusScreenArguments arg = PartQcPartStatusScreenArguments(
      //   partDetails: value!.dataList?.first,
      // );
      // Navigator.of(context).pushNamed(PartQcPartStatusScreen.route, arguments: arg);
    }, onError: (error) {
      CshLoading().hideLoading(context);
      CshSnackBar.error(context: context, message: error);
    });
  }
}
