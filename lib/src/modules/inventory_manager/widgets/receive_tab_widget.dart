import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/src/common/utils/csh_ml_scanner_util.dart';

import '../l10n.dart';
import '../providers/return_page_provider.dart';

class ReceiveTabWidget extends StatelessWidget {
  const ReceiveTabWidget({Key? key}) : super(key: key);

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
                        Navigator.of(context).pop(); // dismiss the scanner
                        _getListingDataFromPbr(context, scannedData.trim(), l10n);
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

  _getListingDataFromPbr(BuildContext context, String pbr, L10n l10n) {
    var provider = ReturnProvider.of(context, listen: false);
    CshLoading().showLoading(context);
    provider.getListReceivePendingPart(pbr).then((value) {
      CshLoading().hideLoading(context);
      if (value) {
        CshSnackBar.success(context: context, message: "Barcode $pbr received successfully!!");
      }
    }, onError: (error) {
      CshLoading().hideLoading(context);
      CshSnackBar.error(context: context, message: error);
    });
  }
}
