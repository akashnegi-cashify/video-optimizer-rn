import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/src/app_builder/app_headers/qc_general_header/widgets/qc_general_header.dart';
import 'package:flutter_trc/src/common/widgets/trc_scanner_widget.dart';
import 'package:flutter_trc/src/modules/trc_executive/models/tl_list_response.dart';
import 'package:flutter_trc/src/modules/trc_executive/providers/trc_executive_store_out_provider.dart';
import 'package:ml_barcode_scanner/widgets/ml_barcode_scanner_widget.dart';
import 'package:provider/provider.dart';

import '../l10n.dart';

class TRCExecutiveStoreOutScreenArg {
  final TlListData tlData;

  TRCExecutiveStoreOutScreenArg(this.tlData);
}

class TRCExecutiveStoreOutScreen extends StatelessWidget {
  static const String route = "/TRC_store_out_screen";

  static navigate(BuildContext context, TlListData tlData) {
    Navigator.pushNamed(context, TRCExecutiveStoreOutScreen.route, arguments: TRCExecutiveStoreOutScreenArg(tlData));
  }

  const TRCExecutiveStoreOutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var args = ModalRoute.of(context)?.settings.arguments as TRCExecutiveStoreOutScreenArg;
    return Scaffold(
      appBar: QcGeneralHeader("Store Out"),
      body: ChangeNotifierProvider(
        create: (context) => TrcExecutiveStoreOutProvider(args.tlData),
        child: _StoreOutBody(),
      ),
    );
  }
}

class _StoreOutBody extends StatelessWidget {
  const _StoreOutBody({super.key});

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
                onTap: () => Navigator.pop(context),
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
        Expanded(
          child: TRCScannerWidget(
            hintText: l10n.scanDeviceBarcode,
            onScanDetected: (String scannedData, MlScannerController? controller, {isManualEntry}) {
              controller?.stop();
              CshLoading().showLoading(context);
              provider.storeOut(scannedData).then((value) {
                if (context.mounted) {
                  CshLoading().hideLoading(context);
                  controller?.start();
                  CshSnackBar.success(context: context, message: "Store out completed");
                }
              }, onError: (error) {
                if (context.mounted) {
                  CshLoading().hideLoading(context);
                  controller?.start();
                  CshSnackBar.error(context: context, message: error.toString());
                }
              });
            },
          ),
        ),
      ],
    );
  }
}
