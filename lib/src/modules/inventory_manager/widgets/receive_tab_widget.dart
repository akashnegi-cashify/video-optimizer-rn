import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import '../../../screens/barcode_scanner_screen.dart';
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
                  Navigator.of(context).pushNamed(BarcodeScanWidget.route, arguments: (String data) {
                    if (!Validator.isNullOrEmpty(data)) {
                      Navigator.of(context).pop(true);
                      _getListingDataFromPbr(context, data.trim(), l10n);
                    }
                  });
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
