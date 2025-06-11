import 'package:core/core.dart';
import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/src/common/utils/csh_ml_scanner_util.dart';
import 'package:flutter_trc/src/common/widgets/dialog_util.dart';
import 'package:flutter_trc/src/modules/engineer/l10n.dart';
import 'package:flutter_trc/src/modules/engineer/my_devices/wip_devices/models/engineer_part_info.dart';
import 'package:flutter_trc/src/modules/engineer/resources/engineer_api_service.dart';

class ReplaceWithRetrievedPartButtonWidget extends StatelessWidget {
  final EngineerPartInfo partInfo;
  final int deviceId;
  final VoidCallback onRequestCompletion;

  const ReplaceWithRetrievedPartButtonWidget({
    super.key,
    required this.deviceId,
    required this.partInfo,
    required this.onRequestCompletion,
  });

  @override
  Widget build(BuildContext context) {
    L10n l10n = L10n(context);
    return CshBigOutlineButton(text: l10n.replaceThisPart, onPressed: () => _showConfirmationDialog(context, l10n));
  }

  _onProceedToReceive(BuildContext context, L10n l10n) {
    CshMlScannerUtil().openScanner(context, onScanned: (scannedData, controller) {
      Navigator.pop(context); // dismiss the scanner
      _replacePart(context, l10n, scannedData, null, partInfo.prId);
    });
  }

  void _showConfirmationDialog(BuildContext context, L10n l10n) {
    context.showConfirmationDialog(l10n.areYouSureYouWantToReplace, negativeButtonData: (BuildContext innerContext) {
      return ButtonData(() {
        Navigator.pop(context); // dismiss dialog
        _onProceedToReceive(context, l10n);
      }, l10n.confirm);
    }, positiveButtonData: (BuildContext context) {
      return ButtonData(() {
        Navigator.pop(context); // dismiss dialog
      }, l10n.cancel);
    });
  }

  void _replacePart(BuildContext context, L10n l10n, String? partBarcode, int? partId, int? partRequestId) {
    CshLoading().showLoading(context);
    EngineerAPIService.replacePartBarcode(partBarcode, partRequestId, deviceId).listen((event) {
      CshLoading().hideLoading(context);
      if (Validator.isTrue(event?.isSuccess)) {
        onRequestCompletion();
        _showSnackBar(context, l10n.partReplacedSuccessfully);
      } else {
        _showSnackBar(context, event?.errorMsg.toString() ?? l10n.somethingWentWrong, isError: true);
      }
    }, onError: (error, stackTrace) {
      CshLoading().hideLoading(context);
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
      behavior: SnackBarBehavior.floating,
      duration: const Duration(seconds: 3),
      padding: const EdgeInsets.all(Dimens.space_16),
      backgroundColor: backgroundColor,
      dismissDirection: DismissDirection.endToStart,
      margin: EdgeInsets.only(bottom: MediaQuery.sizeOf(context).height - 200),
      content: Text(
        message,
        style: theme.textTheme.titleSmall!.copyWith(color: theme.colorScheme.surface),
      ),
    );
    return ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
