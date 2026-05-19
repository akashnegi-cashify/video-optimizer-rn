import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/src/app_builder/app_headers/qc_general_header/widgets/qc_general_header.dart';
import 'package:flutter_trc/src/common/widgets/trc_scanner_widget.dart';
import 'package:flutter_trc/src/modules/trc_executive/models/tl_list_response.dart';
import 'package:flutter_trc/src/modules/trc_executive/providers/tl_list_provider.dart';
import 'package:flutter_trc/src/modules/trc_executive/providers/trc_executive_store_out_provider.dart';
import 'package:flutter_trc/src/modules/trc_executive/widgets/tl_list_widget.dart';
import 'package:ml_barcode_scanner/widgets/ml_barcode_scanner_widget.dart';
import 'package:provider/provider.dart';

import '../l10n.dart';

class TRCExecutiveStoreOutScreenArg {
  final TlListData tlData;
  final String? lotName;

  TRCExecutiveStoreOutScreenArg(this.tlData, {this.lotName});
}

class TRCExecutiveStoreOutScreen extends StatelessWidget {
  static const String route = "/TRC_store_out_screen";

  static navigate(BuildContext context, TlListData tlData, {String? lotName}) {
    Navigator.pushNamed(context, TRCExecutiveStoreOutScreen.route,
        arguments: TRCExecutiveStoreOutScreenArg(tlData, lotName: lotName));
  }

  const TRCExecutiveStoreOutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var args = ModalRoute.of(context)?.settings.arguments as TRCExecutiveStoreOutScreenArg;
    var l10n = L10n(context, listen: false);
    return Scaffold(
      appBar: QcGeneralHeader(l10n.storeOut),
      body: ChangeNotifierProvider(
        create: (context) => TrcExecutiveStoreOutProvider(args.tlData, lotName: args.lotName),
        child: _StoreOutBody(),
      ),
    );
  }
}

class _StoreOutBody extends StatelessWidget {
  const _StoreOutBody();

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var l10n = L10n(context);
    var provider = TrcExecutiveStoreOutProvider.of(context);
    return Column(
      children: [
        CshCard(
          margin: const EdgeInsets.fromLTRB(Dimens.space_16, Dimens.space_16, Dimens.space_16, 0),
          cardWidth: double.infinity,
          child: Row(
            children: [
              CshTextNew.h4("${l10n.tlName}:-", isPrimary: false),
              SizedBox(width: Dimens.space_16),
              InkWell(
                onTap: () => _showTlPickerDialog(context, provider),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: Dimens.space_16),
                  child: Row(
                    spacing: Dimens.space_12,
                    children: [
                      Text(
                        provider.tlName ?? "",
                        style: theme.primaryTextTheme.headlineMedium?.copyWith(color: theme.primaryColor),
                      ),
                      CshIcon(Icons.edit, padding: EdgeInsets.zero, iconColor: theme.primaryColor)
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        if (provider.isLoadingDevices)
          Padding(
            padding: const EdgeInsets.all(Dimens.space_16),
            child: const Center(child: CircularProgressIndicator()),
          )
        else if (provider.currentDevice != null)
          CshCard(
            margin: const EdgeInsets.fromLTRB(Dimens.space_16, Dimens.space_16, Dimens.space_16, 0),
            padding: const EdgeInsets.fromLTRB(Dimens.space_12, Dimens.space_8, Dimens.space_12, Dimens.space_8),
            cardWidth: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                _row(l10n.device, "${provider.currentDevice!.barcode}  (${provider.currentDevice!.productTitle})"),
                if (provider.currentDevice!.lotItemLocation != null)
                  _row(l10n.location, provider.currentDevice!.lotItemLocation!),
              ],
            ),
          )
        else if (provider.lotName != null)
          Padding(
            padding: const EdgeInsets.all(Dimens.space_16),
            child: Center(
              child: CshTextNew.bodyText1(l10n.allDevicesCompleted, isPrimary: false),
            ),
          ),
        Expanded(
          child: TRCScannerWidget(
            hintText: l10n.scanDeviceBarcode,
            onScanDetected: (String scannedData, MlScannerController? controller, {isManualEntry}) {
              controller?.stop();
              CshLoading().showLoading(context);
              provider.validateAndStoreOut(scannedData).then((value) {
                if (context.mounted) {
                  CshLoading().hideLoading(context);
                  controller?.start();
                  CshSnackBar.success(context: context, message: l10n.storeOutCompleted);
                }
              }, onError: (error) {
                if (context.mounted) {
                  CshLoading().hideLoading(context);
                  controller?.start();
                  final msg =
                      error.toString().contains("does not match") ? l10n.scannedBarcodeDoesNotMatch : error.toString();
                  CshSnackBar.error(context: context, message: msg);
                }
              });
            },
          ),
        ),
      ],
    );
  }

  static Widget _row(String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Flexible(flex: 1, fit: FlexFit.tight, child: CshTextNew.subTitle2("$label:", isPrimary: false)),
        Flexible(flex: 3, fit: FlexFit.tight, child: CshTextNew.h4(value)),
      ],
    );
  }

  static void _showTlPickerDialog(BuildContext context, TrcExecutiveStoreOutProvider storeOutProvider) {
    showCshBottomSheet(
      context: context,
      isScrollControlled: true,
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.9,
        child: ChangeNotifierProvider<TlListProvider>(
          create: (_) => TlListProvider(),
          child: TlListWidget(
            onTlSelected: (tl) {
              storeOutProvider.selectTl(tl);
              Navigator.pop(context);
            },
          ),
        ),
      ),
    );
  }
}
