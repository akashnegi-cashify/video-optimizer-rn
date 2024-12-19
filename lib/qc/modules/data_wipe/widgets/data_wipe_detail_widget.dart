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
    provider.getDeviceWipeStatus().then((value) {}, onError: (error) {
      _showErrorDialog(error);
    });
  }

  @override
  Widget build(BuildContext context) {
    var provider = DataWipeDetailProvider.of(context);
    if (provider.isLoading || provider.data == null) {
      return const CshShimmer();
    }

    var data = provider.data;
    return Column(
      children: [
        DataWipeStatusCard(data?.statusCode, data?.status),
        const SizedBox(height: Dimens.space_16),
        DataWipeCardWidget(data?.qrCode, data?.erasureProvider, data?.productName, data?.status, data?.statusCode)
      ],
    );
  }

  _showErrorDialog(String errorMessage) {
    var theme = Theme.of(context);
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
                firstBtnText: "Go Back",
                secondBtnText: "Scan Another",
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
