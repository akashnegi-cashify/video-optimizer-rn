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
    return CshBigOutlineButton(
      text: l10n.receive,
      onPressed: () {
        _onReceiveButtonClicked(partInfo, context, l10n);
      },
    );
  }

  _onReceiveButtonClicked(EngineerPartInfo partInfo, BuildContext context, L10n l10n) {
    if (partInfo.isBulk ?? false) {
      showConfirmationDialog(context, l10n, partInfo.partBarcode, partInfo.partId, partInfo.prId);
    } else {
      CshMlScannerUtil().openScanner(context, onScanned: (scannedData, controller) {
        Navigator.pop(context); // dismiss the scanner
        showConfirmationDialog(context, l10n, scannedData, null, partInfo.prId);
      });
    }
  }

  void showConfirmationDialog(BuildContext context, L10n l10n, String? partBarcode, int? partId, int? prId) {
    context.showConfirmationDialog(l10n.areYouSureYouWantToReceive, negativeButtonData: (BuildContext innerContext) {
      return ButtonData(() {
        Navigator.pop(context);
         // tODO: need to revert this if statement
        if (!Validator.isTrue(partInfo.isPartRetrievedRequired)) {
          RetrievedPartsDataDetailsScreenArguments args = RetrievedPartsDataDetailsScreenArguments(
            partInfo: partInfo,
            onSuccess: () {
              Navigator.pop(context); // dismiss the retrieved parts details screen
              onRequestCompletion();
            },
            deviceBarcode: partBarcode,
          );
          Navigator.of(context).pushNamed(RetrievedPartsDataDetailsScreen.route, arguments: args);
        } else {
          // _proceedToReceivePart(context, l10n, partBarcode, partId, prId);
        }
      }, l10n.confirm);
    }, positiveButtonData: (BuildContext context) {
      return ButtonData(() {
        Navigator.pop(context);
      }, l10n.cancel);
    });
  }

  // Future<RetrievedPartRequiredResponse> _getRetrievedPartsData(EngineerPartInfo partInfo) {
  //   List<Map<String, dynamic>> dataList = [
  //     {"prn": partInfo.partName, "ccd": partInfo.categoryCode}
  //   ];
  //
  //   var completer = Completer<RetrievedPartRequiredResponse>();
  //   try {
  //     EngineerAPIService.fetchRequiredPartsListingByDID({"pd": dataList}).listen((event) {
  //       completer.complete(event!);
  //     }, onError: (error) {
  //       String errorMessage = ApiErrorHelper.getErrorMessage(error) ?? "Something went wrong";
  //       completer.completeError(errorMessage);
  //     });
  //   } catch (e) {
  //     completer.completeError(e.toString());
  //   }
  //   return completer.future;
  // }

  void _proceedToReceivePart(BuildContext context, L10n l10n, String? partBarcode, int? partId, int? prId) {
    EngineerAPIService.getReceivePartByEngineer(partBarcode, partId, prId).listen((event) {
      CshLoading().hideLoading(context);
      if (event == null) {
        Navigator.pop(context);
        _showSnackBar(context, l10n.somethingWentWrong, isError: true);
        return;
      }

      if (event.isSuccess == true) {
        onRequestCompletion();
        _showSnackBar(context, l10n.deviceReceivedSuccessfully);
      } else {
        Navigator.pop(context);
        _showSnackBar(context, event.errorMsg.toString(), isError: true);
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
