import 'dart:async';

import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_trc/qc/modules/data_wipe/dialog/show_imei_status_dialog.dart';
import 'package:flutter_trc/qc/modules/data_wipe/dialog/show_serial_no_status_dialog.dart';
import 'package:flutter_trc/qc/modules/data_wipe/providers/data_wipe_detail_provider.dart';
import 'package:flutter_trc/qc/modules/data_wipe/resources/verification_status_enum.dart';
import 'package:flutter_trc/qc/modules/data_wipe/screens/data_wipe_detail_screen.dart';
import 'package:flutter_trc/qc/modules/data_wipe/widgets/data_wipe_card_widget.dart';
import 'package:flutter_trc/qc/modules/data_wipe/widgets/data_wipe_status_card.dart';
import 'package:flutter_trc/qc/modules/qc_tester/lob_devices/dialogs/show_manul_enter_serial_dialog.dart';
import 'package:flutter_trc/qc/modules/qc_tester/lob_devices/resources/device_category_id_type.dart';
import 'package:flutter_trc/src/common/utils/csh_ml_scanner_util.dart';
import 'package:flutter_trc/src/common/widgets/imei_scanner.dart';
import 'package:imei_serial_reader/imei_serial_reader.dart';

import '../l10n.dart';

class DataWipeDetailWidget extends StatefulWidget {
  const DataWipeDetailWidget({super.key});

  @override
  State<DataWipeDetailWidget> createState() => _DataWipeDetailWidgetState();
}

class _DataWipeDetailWidgetState extends State<DataWipeDetailWidget> {
  int _retryCount = 0;
  bool _isShowManualEnter = false;

  @override
  void initState() {
    scheduleMicrotask(() => _getData());
    super.initState();
  }

  _getData() {
    var provider = DataWipeDetailProvider.of(context, listen: false);
    provider.getDeviceWipeStatus(
        isFirstTime: true,
        onError: (errorMessage) {
          _showErrorDialog(errorMessage);
        });
  }

  @override
  Widget build(BuildContext context) {
    var provider = DataWipeDetailProvider.of(context);
    var l10n = L10n(context);
    if (provider.isLoading || provider.data == null) {
      return const CshShimmer();
    }

    var data = provider.data;

    var readerType =
        data?.categoryKey == DeviceCategoryIdType.laptop.value ? ReaderType.serialNumberReader : ReaderType.imeiReader;
    return RefreshIndicator(
      onRefresh: () {
        return Future.value(provider.getDeviceWipeStatus());
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(Dimens.space_16),
              children: [
                DataWipeStatusCard(data?.statusCode, data?.status),
                const SizedBox(height: Dimens.space_16),
                DataWipeCardWidget(
                  data?.qrCode,
                  data?.erasureProvider,
                  data?.productName,
                  data?.status,
                  data?.statusCode,
                  data?.errorMessage,
                ),
              ],
            ),
          ),
          if (provider.bottomButtonState == BottomButtonState.validation && !provider.isImeiSerialAlreadyUpdated)
            Padding(
              padding: const EdgeInsets.all(Dimens.space_16),
              child: CshBigButton(
                text: readerType == ReaderType.serialNumberReader ? l10n.updateSerial : l10n.updateImei,
                onPressed: () {
                  _onValidateImeiClicked(readerType);
                },
              ),
            ),
          if (provider.bottomButtonState != BottomButtonState.validation)
            (provider.bottomButtonState == BottomButtonState.initDataWipe && !provider.forceHideInitiateButton)
                ? Padding(
                    padding: const EdgeInsets.all(Dimens.space_16),
                    child: CshBigButton(
                      text: l10n.initiateDataWipe,
                      onPressed: () {
                        _initiateDataWipe();
                      },
                    ),
                  )
                : Padding(
                    padding: const EdgeInsets.all(Dimens.space_16),
                    child: CshBigButton(
                      text: l10n.scanAnother,
                      onPressed: () {
                        _onScannedAnotherClicked();
                      },
                    ),
                  )
        ],
      ),
    );
  }

  _onValidateImeiClicked(ReaderType readerType) {
    var isBusy = false;
    Navigator.push(context, MaterialPageRoute(
      builder: (_) {
        return ImeiScanner(
          config: ParserConfig(readerType: readerType),
          onProceed: (List<String>? scannedList) {
            if (!isBusy) {
              isBusy = true;
              Navigator.pop(context); // close Imei Scanner
              _onValuesScanned(readerType, scannedList);
            }
          },
          onTimeOut: () {
            Navigator.pop(context); // close Imei Scanner
            _onScanningTimeout(readerType);
          },
        );
      },
    ));
  }

  _onValuesScanned(ReaderType readerType, List<String>? scannedList) {
    var provider = DataWipeDetailProvider.of(context, listen: false);
    if (readerType == ReaderType.imeiReader) {
      showImeiStatusDialog(
        context,
        _isImeiMatched(scannedList, provider.data?.imei1, provider.data?.imei2)
            ? VerificationStatusEnum.matched
            : VerificationStatusEnum.misMatched,
        scannedImeiNos: scannedList,
        systemImeiNos: [
          if (!Validator.isNullOrEmpty(provider.data?.imei1)) provider.data!.imei1!,
          if (!Validator.isNullOrEmpty(provider.data?.imei2)) provider.data!.imei2!,
        ],
        onProceedToDataWipe: () {
          Navigator.pop(context); // close Imei Status Dialog
          provider.bottomButtonState = BottomButtonState.initDataWipe;
        },
        onRetry: () {
          Navigator.pop(context); // close Imei Status Dialog
          _onValidateImeiClicked(readerType);
        },
        onReport: () {
          Navigator.pop(context); // close Imei Status Dialog
          _reportMisMatched(imei1: scannedList?.first, imei2: scannedList?.last);
        },
      );
    } else {
      showSerialNoStatusDialog(
        context,
        _isSerialNoMatched(scannedList, provider.data?.serialNo)
            ? VerificationStatusEnum.matched
            : VerificationStatusEnum.misMatched,
        scannedSerialNo: scannedList?.first,
        systemSerialNo: provider.data?.serialNo,
        onProceedToDataWipe: () {
          Navigator.pop(context); // close serial Status Dialog
          provider.bottomButtonState = BottomButtonState.initDataWipe;
        },
        onRetry: () {
          Navigator.pop(context); // close serial Status Dialog
          _onValidateImeiClicked(readerType);
        },
        onReport: () {
          Navigator.pop(context); // close Serial No Status Dialog
          _reportMisMatched(serialNo: scannedList?.first);
        },
      );
    }
  }

  _onScannedAnotherClicked() {
    CshMlScannerUtil().openScanner(
      context,
      onScanned: (scannedData, controller) {
        Navigator.pop(context); // Close the scanner
        DataWipeDetailScreen.navigateTo(context, scannedData, isReplacement: true);
      },
    );
  }

  _reportMisMatched({String? imei1, String? imei2, String? serialNo}) {
    var provider = DataWipeDetailProvider.of(context, listen: false);
    CshLoading().showLoading(context);
    provider.reportMisMatch(imei1: imei1, imei2: imei2, serialNo: serialNo).then((value) {
      CshLoading().hideLoading(context);
    }, onError: (error) {
      CshLoading().hideLoading(context);
      CshSnackBar.error(context: context, message: error.toString());
    });
  }

  _initiateDataWipe() {
    var provider = DataWipeDetailProvider.of(context, listen: false);
    CshLoading().showLoading(context);
    provider.initiateDataWipe().then((_) {
      CshLoading().hideLoading(context);
      CshSnackBar.success(context: context, message: "Data Eraser Initiated");
    }, onError: (error) {
      CshLoading().hideLoading(context);
      CshSnackBar.error(context: context, message: error.toString());
    });
  }

  _showErrorDialog(String errorMessage) {
    var theme = Theme.of(context);
    var l10n = L10n(context, listen: false);
    showCshBottomSheet(
        context: context,
        isDismissible: false,
        child: PopScope(
          canPop: false,
          child: Padding(
            padding: const EdgeInsets.all(Dimens.space_16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CshIcon(FeatherIcons.alertTriangle, iconColor: theme.colorScheme.error),
                const SizedBox(height: Dimens.space_16),
                Text(errorMessage, style: theme.primaryTextTheme.labelSmall),
                const SizedBox(height: Dimens.space_26),
                ComboButton(
                  firstBtnText: l10n.goBack,
                  secondBtnText: l10n.scanAnother,
                  isFirstPrimary: false,
                  firstBtnClick: () {
                    Navigator.pop(context); // Close this dialog
                    Navigator.pop(context); // close this screen
                  },
                  secondBtnClick: () {
                    CshMlScannerUtil().openScanner(
                      context,
                      onScanned: (scannedData, controller) {
                        Navigator.pop(context); // Close the scanner
                        DataWipeDetailScreen.navigateTo(context, scannedData, isReplacement: true);
                      },
                    );
                  },
                )
              ],
            ),
          ),
        ));
  }

  _onScanningTimeout(ReaderType readerType) {
    ++_retryCount;
    if (_retryCount >= 2) {
      _isShowManualEnter = true;
    } else {
      _isShowManualEnter = false;
    }
    var theme = Theme.of(context);
    showCshBottomSheet(
      context: context,
      child: Padding(
        padding: EdgeInsets.all(Dimens.space_24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            CshIcon(
              FeatherIcons.alertTriangle,
              iconColor: Theme.of(context).colorScheme.error,
              padding: EdgeInsets.zero,
              iconSize: MobileIconSize.large,
            ),
            const SizedBox(height: Dimens.space_16),
            Text(
              "Unable to scan",
              textAlign: TextAlign.center,
              style: theme.primaryTextTheme.displaySmall?.copyWith(color: theme.colorScheme.error),
            ),
            const SizedBox(height: Dimens.space_26),
            CshBigButton(
              text: "Retry",
              onPressed: () {
                Navigator.pop(context); // Close this dialog
                _onValidateImeiClicked(readerType);
              },
            ),
            const SizedBox(height: Dimens.space_16),
            if (_isShowManualEnter)
              CshBigButton(
                text: "Enter Manually",
                onPressed: () {
                  Navigator.pop(context); // Close this dialog
                  showManualEnterSerialNo(
                    context,
                    title: readerType == ReaderType.imeiReader ? "Enter Imei" : "Enter Serial no",
                    hintText: readerType == ReaderType.imeiReader ? "Enter Imei" : "Enter Serial no",
                    onSerialNoEntered: (serialNo) {
                      Navigator.pop(context); // Close this dialog
                      _onValuesScanned(readerType, [serialNo]);
                    },
                  );
                },
              ),
          ],
        ),
      ),
    );
  }

  bool _isImeiMatched(List<String>? scannedList, String? imei1, String? imei2) {
    if (Validator.isListNullOrEmpty(scannedList)) {
      return false;
    }

    if (Validator.isNullOrEmpty(imei1) && Validator.isNullOrEmpty(imei2)) {
      return false;
    }

    if (scannedList!.contains(imei1) || scannedList.contains(imei2)) {
      return true;
    } else {
      return false;
    }
  }

  bool _isSerialNoMatched(List<String>? scannedList, String? serialNo) {
    if (Validator.isListNullOrEmpty(scannedList)) {
      return false;
    }

    if (Validator.isNullOrEmpty(serialNo)) {
      return false;
    }

    if (scannedList!.first.toLowerCase() == serialNo!.toLowerCase()) {
      return true;
    } else {
      return false;
    }
  }
}
