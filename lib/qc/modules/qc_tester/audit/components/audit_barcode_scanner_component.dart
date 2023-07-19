import 'package:builder_component/builder_component.dart';
import 'package:core_widgets/core_widgets.dart';
import 'package:csh_annotation/annotation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/qc/resources/qc_common_config.dart';
import 'package:flutter_trc/src/app_builder/app_builder_groups/groups.dart';
import 'package:ml_barcode_scanner/widgets/ml_barcode_scanner_widget.dart';

import '../l10n.dart';
import '../screens/audit_question_screen.dart';

part 'audit_barcode_scanner_component.g.dart';

@CshComponent(
    key: AuditBarcodeScannedComponent.COMP_KEY,
    componentGroup: ComponentGroup.auditBarcodeScannedComponentKey,
    configModel: QcCommonConfigModel)
class AuditBarcodeScannedComponent extends StatelessComponent<QcCommonConfigModel> {
  static const String COMP_KEY = "audit_barcode_scanner_comp";

  const AuditBarcodeScannedComponent(super.jsonConfig, {super.key});

  @override
  Widget buildView(BuildContext context, QcCommonConfigModel? configModel) {
    return const _BarcodeScanner();
    ;
  }

  @override
  Function(Map<String, dynamic> data)? fromConfig() {
    return QcCommonConfigModel.fromConfig;
  }
}

class _BarcodeScanner extends StatefulWidget {
  const _BarcodeScanner({
    Key? key,
  }) : super(key: key);

  @override
  State<_BarcodeScanner> createState() => _BarcodeScannerState();
}

class _BarcodeScannerState extends State<_BarcodeScanner> {
  final TextEditingController _barcodeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var l10n = L10n(context);
    return Column(
      children: [
        Expanded(
          child: MlBarcodeScannerWidget(
            onScannerDetected: (String value, MlScannerController controller) {
              if (!Validator.isNullOrEmpty(value)) {
                AuditQuestionsScreenArguments args = AuditQuestionsScreenArguments(scannedBarcode: value.trim());
                Navigator.of(context).pushReplacementNamed(
                  AuditQuestionsScreen.route,
                  arguments: args,
                );
              }
            },
          ),
        ),
        _enterAuditBarcodeManually(l10n, context),
      ],
    );

    // return Scaffold(
    //   appBar: CshHeader(
    //     l10n.auditBarcodeScanner,
    //     showBackBtn: false,
    //   ),
    //   body: ,
    // );
  }

  Widget _enterAuditBarcodeManually(L10n l10n, BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.symmetric(vertical: Dimens.space_18, horizontal: Dimens.space_8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: CshTextFormField(
              controller: _barcodeController,
              maxLength: 50,
              autofocus: false,
              hintText: l10n.auditBarcode,
              onFieldSubmitted: (data) {
                FocusScope.of(context).unfocus();
              },
            ),
          ),
          const SizedBox(width: Dimens.space_8),
          Padding(
            padding: const EdgeInsets.only(bottom: Dimens.space_12),
            child: CshMediumButton(
              text: l10n.submit,
              onPressed: () {
                FocusScope.of(context).unfocus();
                if (_barcodeController.text.isNotEmpty) {
                  String data = _barcodeController.text.trim();
                  if (!Validator.isNullOrEmpty(data)) {
                    AuditQuestionsScreenArguments args = AuditQuestionsScreenArguments(scannedBarcode: data.trim());
                    Navigator.of(context).pushReplacementNamed(
                      AuditQuestionsScreen.route,
                      arguments: args,
                    );
                  }
                } else {
                  CshSnackBar.error(
                    context: context,
                    message: l10n.pleaseEnterBarcode,
                    snackBarPosition: SnackBarPosition.TOP,
                    duration: SnackBarDuration.MEDIUM,
                  );
                }
              },
            ),
          )
        ],
      ),
    );
  }
}
