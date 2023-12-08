import 'package:core/core.dart';
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
      context.showConfirmationDialog(l10n.areYouSureYouWantToReceive, negativeButtonData: (BuildContext innerContext) {
        return ButtonData(() {
          Navigator.pop(context);
          CshLoading().showLoading(context);
          EngineerAPIService.getReceivePartByEngineer(partBarcode, partId, prId).listen((event) {
            CshLoading().hideLoading(context);
            if (event == null) {
              Navigator.pop(context);
              showSnackBar(context, l10n.somethingWentWrong, isError: true);
              return;
            }

            if (event.isSuccess == true) {
              onRequestCompletion();
              showSnackBar(context, l10n.deviceReceivedSuccessfully);
            } else {
              Navigator.pop(context);
              showSnackBar(context, event.errorMsg.toString(), isError: true);
            }
          }, onError: (error, stackTrace) {
            CshLoading().hideLoading(context);
            Navigator.pop(context);
            showSnackBar(context, ApiErrorHelper.getErrorMessage(error) ?? l10n.somethingWentWrong, isError: true);
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
        Navigator.pop(context);
        receiveDevice(barcode, null, partInfo.prId);
      });
    }
  }

  showSnackBar(BuildContext context, String message, {bool isError = false}) {
    ThemeData theme = Theme.of(context);
    CustomColors customTheme = theme.extension<CustomColors>() as CustomColors;
    var backgroundColor = customTheme.successColor;
    if (isError) {
      backgroundColor = theme.errorColor;
    }
    SnackBar snackBar = SnackBar(
      behavior: SnackBarBehavior.fixed,
      duration: const Duration(seconds: 3),
      padding: const EdgeInsets.all(Dimens.space_16),
      backgroundColor: backgroundColor,
      dismissDirection: DismissDirection.endToStart,
      content: Text(
        message,
        style: theme.textTheme.subtitle2!.copyWith(color: theme.backgroundColor),
      ),
    );
    return ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
