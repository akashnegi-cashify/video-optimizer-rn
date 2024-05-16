import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/src/common/utils/csh_ml_scanner_util.dart';
import 'package:flutter_trc/src/modules/engineer/retreived_parts/widgets/retrieved_part_details_item_widget.dart';

import '../l10n.dart';
import '../providers/retrieved_part_data_provider.dart';

class RetrievedPartsDataDetailsWidget extends StatefulWidget {
  const RetrievedPartsDataDetailsWidget({super.key});

  @override
  State<RetrievedPartsDataDetailsWidget> createState() => _RetrievedPartsDataDetailsWidgetState();
}

class _RetrievedPartsDataDetailsWidgetState extends State<RetrievedPartsDataDetailsWidget> {
  @override
  Widget build(BuildContext context) {
    var l10n = L10n(context);
    var provider = RetrievedPartsDataProviders.of(context);
    var partInfo = provider.partInfo;
    return Column(
      children: [
        Expanded(child: RetrievedPartDetailsItemWidget(itemModel: partInfo)),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: Dimens.space_16),
          child: SizedBox(
            width: double.infinity,
            child: CshMediumButton(
              text: l10n.submit,
              onPressed: () {
                if (!provider.isMandatoryFieldsSubmitted()) {
                  CshSnackBar.error(
                    context: context,
                    message: l10n.completeRequiredFieldToSubmit,
                    duration: SnackBarDuration.SHORT,
                    snackBarPosition: SnackBarPosition.TOP,
                  );
                  return;
                }
                _onProceedToReceive(l10n);
              },
            ),
          ),
        )
      ],
    );
  }

  _onProceedToReceive(L10n l10n) {
    var provider = RetrievedPartsDataProviders.of(context, listen: false);
    if (Validator.isTrue(provider.partInfo?.isBulk)) {
      _updatePartsData();
    } else {
      CshMlScannerUtil().openScanner(context, onScanned: (scannedData, controller) {
        Navigator.pop(context); // dismiss the scanner
        _updatePartsData(partBarcode: scannedData);
      });
    }
  }

  _updatePartsData({String? partBarcode}) {
    var provider = RetrievedPartsDataProviders.of(context, listen: false);
    CshLoading().showLoading(context);
    provider.updateRetrievedPartWithDeviceReceive(partBarcode).then((value) {
      CshLoading().hideLoading(context);
      provider.onSuccess?.call();
    }, onError: (error) {
      CshLoading().hideLoading(context);
      CshSnackBar.error(context: context, message: error);
    });
  }
}
