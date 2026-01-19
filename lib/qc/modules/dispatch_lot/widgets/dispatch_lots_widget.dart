import 'package:components/list_page/config/list_api_config.dart';
import 'package:components/list_page/controller/csh_list_controller.dart';
import 'package:components/list_page/widgets/csh_api_list.dart';
import 'package:core_widgets/core_widgets.dart' as core;
import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/qc/modules/dispatch_lot/providers/dispatch_lot_provider.dart';
import 'package:flutter_trc/qc/modules/dispatch_lot/widgets/index.dart';
import 'package:flutter_trc/src/services/service_groups.dart';
import 'package:ml_barcode_scanner/widgets/index.dart';

import '../../qc_tester/disputed_image_capture/screens/disputed_image_capture_barcode_scanner_screen.dart';
import '../l10n.dart';
import '../resources/index.dart';

class DispatchLotsWidget extends StatefulWidget {
  const DispatchLotsWidget({super.key});

  @override
  State<DispatchLotsWidget> createState() => _DispatchLotsWidgetState();
}

class _DispatchLotsWidgetState extends State<DispatchLotsWidget> {
  final CshListController _listController = CshListController();

  @override
  void initState() {
    super.initState();
    var provider = DispatchLotProvider.of(context: context, listen: false);
    provider.controller.stream.listen((event) {
      _listController.refresh();
    });
  }

  @override
  Widget build(BuildContext context) {
    var l10n = L10n(context);

    return Column(children: [
      Expanded(
        child: CshApiList<Lot>(
          apiConfig: ListApiConfig(
            apiUrl: "/lot-dispatch/list",
            serviceGroup: TRCServiceGroups.qcConsole,
          ),
          controller: _listController,
          shimmerLoaderWidget: const CshShimmer(height: Dimens.space_60),
          listPadding: const EdgeInsets.all(Dimens.space_16),
          verticalRowSpacing: Dimens.space_16,
          itemFromJson: Lot.fromJson,
          getRowWidget: (item, index) {
            return LotWidget(
              lot: item,
              index: index,
              onItemClick: () => _onItemClick(context, index: index, l10n: l10n),
            );
          },
        ),
      )
    ]);
  }

  void _onItemClick(BuildContext context, {required int index, required L10n l10n}) {
    DisputedImageCaptureBarcodeScannerArguments args = DisputedImageCaptureBarcodeScannerArguments(
        onScanDetected: (String scannedData, MlScannerController? controller, {isManualEntry}) {
          if (scannedData.isNotEmpty) {
            var provider = DispatchLotProvider.of(context: context, listen: false);
            core.CshLoading().showLoading(context);
            provider.initiateDispatchCompletion(scannedData).then((_) {
              if (mounted) {
                core.CshLoading().hideLoading(context);
                Navigator.pop(context); // dismiss scanner screen
                _showAlert(context, l10n);
              }
            }, onError: (error) {
              if (mounted) {
                core.CshLoading().hideLoading(context);
                core.CshSnackBar.error(context: context, message: error);
              }
            });

            // pop scanner screen
          }
        },
        header: l10n.scanInvoice,
        hintText: l10n.enterInvoiceNumber);
    Navigator.of(context).pushNamed(DisputedImageCaptureBarcodeScanner.route, arguments: args);
  }

  void _showAlert(BuildContext context, L10n l10n) {
    var theme = Theme.of(context);
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: core.CshTextNew.h3(l10n.success),
          actions: <Widget>[
            TextButton(
              child: core.CshTextNew(
                l10n.ok,
                textStyle: theme.textTheme.displaySmall?.copyWith(color: theme.primaryColor),
              ),
              onPressed: () {
                Navigator.pop(context);
                _listController.refresh();
              },
            )
          ],
        );
      },
    );
  }
}
