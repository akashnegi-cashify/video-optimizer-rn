import 'package:core/core.dart';
import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/src/common/utils/csh_ml_scanner_util.dart';
import 'package:flutter_trc/src/common/widgets/dialog_util.dart';
import 'package:flutter_trc/src/modules/engineer/l10n.dart';
import 'package:flutter_trc/src/modules/engineer/my_devices/wip_devices/models/engineer_part_info.dart';
import 'package:flutter_trc/src/modules/engineer/resources/engineer_api_service.dart';
import 'package:flutter_trc/src/modules/engineer/retreived_parts/screens/retrieved_parts_details_data_screen.dart';

class ReceivePartButtonWidget extends StatelessWidget {
  final EngineerPartInfo partInfo;
  final VoidCallback onRequestCompletion;

  const ReceivePartButtonWidget({Key? key, required this.partInfo, required this.onRequestCompletion})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    L10n l10n = L10n(context);
    return CshBigOutlineButton(text: l10n.receive, onPressed: () => _showConfirmationDialog(context, l10n));
  }

  _onProceedToReceive(BuildContext context, L10n l10n) {
    if (partInfo.isBulk ?? false) {
      _updateReceivePart(context, l10n, partInfo.partBarcode, partInfo.partId, partInfo.prId);
    } else {
      CshMlScannerUtil().openScanner(context, onScanned: (scannedData, controller) {
        Navigator.pop(context); // dismiss the scanner
        _updateReceivePart(context, l10n, scannedData, null, partInfo.prId);
      });
    }
  }

  void _showConfirmationDialog(BuildContext context, L10n l10n) {
    context.showConfirmationDialog(l10n.areYouSureYouWantToReceive, negativeButtonData: (BuildContext innerContext) {
      return ButtonData(() {
        Navigator.pop(context); // dismiss dialog
        if ((partInfo.retrievedImageCount ?? 0) > 0) {
          RetrievedPartsDataDetailsScreenArguments args = RetrievedPartsDataDetailsScreenArguments(
            partInfo: partInfo,
            onSuccess: () {
              Navigator.pop(context); // dismiss the retrieved parts details screen
              onRequestCompletion();
            },
          );
          Navigator.of(context).pushNamed(RetrievedPartsDataDetailsScreen.route, arguments: args);
        } else {
          _onProceedToReceive(context, l10n);
        }
      }, l10n.confirm);
    }, positiveButtonData: (BuildContext context) {
      return ButtonData(() {
        Navigator.pop(context); // dismiss dialog
      }, l10n.cancel);
    });
  }

  void _updateReceivePart(BuildContext context, L10n l10n, String? partBarcode, int? partId, int? prId) {
    EngineerAPIService.getReceivePartByEngineer(partBarcode, partId, prId).listen((event) {
      CshLoading().hideLoading(context);
      if (event == null) {
        Navigator.pop(context);
        _showSnackBar(context, l10n.somethingWentWrong, isError: true);
        return;
      }

      if (event.errorMsg != null) {
        Navigator.pop(context);
        _showSnackBar(context, event.errorMsg.toString(), isError: true);
      } else {
        onRequestCompletion();
        _showSnackBar(context, l10n.deviceReceivedSuccessfully);
      }
    }, onError: (error, stackTrace) {
      CshLoading().hideLoading(context);
      Navigator.pop(context);
      _showSnackBar(context, ApiErrorHelper.getErrorMessage(error) ?? l10n.somethingWentWrong, isError: true);
    });
  }

  _showSnackBar(BuildContext context, String message, {bool isError = false}) {
    ThemeData theme = Theme.of(context);
    CustomColors customTheme = theme.extension<CustomColors>() as CustomColors;
    var backgroundColor = customTheme.successColor;
    if (isError) {
      backgroundColor = theme.colorScheme.error;
    }
    SnackBar snackBar = SnackBar(
      behavior: SnackBarBehavior.fixed,
      duration: const Duration(seconds: 3),
      padding: const EdgeInsets.all(Dimens.space_16),
      backgroundColor: backgroundColor,
      dismissDirection: DismissDirection.endToStart,
      content: Text(
        message,
        style: theme.textTheme.titleSmall!.copyWith(color: theme.colorScheme.background),
      ),
    );
    return ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
