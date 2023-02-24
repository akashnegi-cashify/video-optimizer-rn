import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/src/common/widgets/dialog_util.dart';
import 'package:flutter_trc/src/modules/engineer/l10n.dart';
import 'package:flutter_trc/src/modules/engineer/my_devices/wip_devices/models/engineer_part_info.dart';
import 'package:flutter_trc/src/modules/engineer/resources/engineer_api_service.dart';

import '../../../../../../screens/barcode_scanner_screen.dart';

class ReceivePartButtonWidget extends StatelessWidget {
  final EngineerPartInfo partInfo;
  final VoidCallback onRequestCompletion;

  const ReceivePartButtonWidget({Key? key, required this.partInfo, required this.onRequestCompletion})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    L10n l10n = L10n(context);
    return CshBigOutlineButton(
      text: l10n.receive,
      onPressed: () {
        displayConfirmationPopup(partInfo, context, l10n);
      },
    );
  }

  displayConfirmationPopup(EngineerPartInfo partInfo, BuildContext context, L10n l10n) {
    void receiveDevice(String? partBarcode, int? partId, int? prId) {
      context.showConfirmationDialog(l10n.areYouSureYouWantToReceive, negativeButtonData: (BuildContext context) {
        return ButtonData(() {
          Navigator.pop(context);
          CshLoading().showLoading(context);
          EngineerAPIService.getReceivePartByEngineer(partBarcode, partId, prId).listen((event) {
            CshLoading().hideLoading(context);
            if (event == null) {
              CshSnackBar.error(context: context, message: l10n.somethingWentWrong);
              return;
            }

            if (event.errorMsg != null) {
              CshSnackBar.error(context: context, message: event.errorMsg!);
              return;
            }

            if (event.isSuccess) {
              onRequestCompletion();
              CshSnackBar.success(context: context, message: l10n.deviceReceivedSuccessfully);
              return;
            } else {
              CshSnackBar.error(context: context, message: l10n.somethingWentWrong);
              return;
            }
          }, onError: (error, stackTrace) {
            CshLoading().hideLoading(context);
            CshSnackBar.error(
                context: context, message: ApiErrorHelper.getErrorMessage(error) ?? l10n.somethingWentWrong);
          });
        }, l10n.confirm);
      }, positiveButtonData: (BuildContext context) {
        return ButtonData(() {
          Navigator.pop(context);
        }, l10n.cancel);
      });
    }

    if (partInfo.isBulk ?? false) {
      receiveDevice(partInfo.partBarcode, partInfo.partId, partInfo.prId);
    } else {
      Navigator.pushNamed(context, BarcodeScanWidget.route, arguments: (String barcode) {
        receiveDevice(barcode, null, partInfo.prId);
      });
    }
  }
}
