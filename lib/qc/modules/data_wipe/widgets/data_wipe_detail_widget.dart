import 'dart:async';

import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_trc/qc/modules/data_wipe/providers/data_wipe_detail_provider.dart';
import 'package:flutter_trc/qc/modules/data_wipe/screens/data_wipe_detail_screen.dart';
import 'package:flutter_trc/qc/modules/data_wipe/widgets/data_wipe_card_widget.dart';
import 'package:flutter_trc/qc/modules/data_wipe/widgets/data_wipe_status_card.dart';
import 'package:flutter_trc/qc/modules/qc_actions/qc_action_screen.dart';
import 'package:flutter_trc/src/common/utils/csh_ml_scanner_util.dart';

import '../l10n.dart';

class DataWipeDetailWidget extends StatefulWidget {
  const DataWipeDetailWidget({super.key});

  @override
  State<DataWipeDetailWidget> createState() => _DataWipeDetailWidgetState();
}

class _DataWipeDetailWidgetState extends State<DataWipeDetailWidget> {
  @override
  void initState() {
    scheduleMicrotask(() => _getData());
    super.initState();
  }

  _getData() {
    var provider = DataWipeDetailProvider.of(context, listen: false);
    provider.getDeviceWipeStatus(onError: (errorMessage) {
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
    return Padding(
      padding: const EdgeInsets.all(Dimens.space_16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          DataWipeStatusCard(data?.statusCode, data?.status),
          const SizedBox(height: Dimens.space_16),
          DataWipeCardWidget(data?.qrCode, data?.erasureProvider, data?.productName, data?.status, data?.statusCode),
          const Expanded(child: SizedBox.shrink()),
          ((data?.statusCode ?? 0) < 1 && !provider.forceHideInitiateButton)
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

  _onScannedAnotherClicked() {
    CshMlScannerUtil().openScanner(
      context,
      onScanned: (scannedData, controller) {
        Navigator.pop(context); // Close the scanner
        DataWipeDetailScreen.navigateTo(context, scannedData, isReplacement: true);
      },
    );
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
                  Navigator.pushNamedAndRemoveUntil(context, QcActionScreen.route, (route) => false);
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
        ));
  }
}
