import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/src/header/trc_header.dart';
import 'package:flutter_trc/src/modules/engineer/l10n.dart';
import 'package:flutter_trc/src/modules/engineer/my_devices/wip_devices/view_parts/models/replace_part_request.dart';
import 'package:flutter_trc/src/modules/engineer/my_devices/wip_devices/view_parts/providers/self_assign_presenter.dart';

class SelfAssignPartScreen extends StatelessWidget {
  const SelfAssignPartScreen({Key? key}) : super(key: key);
  static const route = "/engineer/replace-part";

  @override
  Widget build(BuildContext context) {
    return const _SelfAssignPartWidget();
  }
}

class _SelfAssignPartWidget extends StatefulWidget {
  const _SelfAssignPartWidget({Key? key}) : super(key: key);

  @override
  State<_SelfAssignPartWidget> createState() => _SelfAssignPartWidgetState();
}

class _SelfAssignPartWidgetState extends State<_SelfAssignPartWidget> with ViewAction {
  late L10n l10n;
  late SelfAssignPresenter _presenter;

  @override
  void initState() {
    _presenter = SelfAssignPresenter(this);
    super.initState();
  }

  @override
  void didChangeDependencies() {
    l10n = L10n(context);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final TextEditingController partBarcodeController = TextEditingController();
    final TextEditingController deviceBarcodeController = TextEditingController();

    String? previousDeviceBarcode = ModalRoute.of(context)?.settings.arguments as String?;

    return Scaffold(
      appBar: TrcHeader(l10n.viewParts),
      body: Padding(
        padding: const EdgeInsets.all(Dimens.space_16),
        child: Column(
          children: [
            Expanded(
              child: Row(
                children: [
                  Expanded(
                      child: CshTextFormField(
                    controller: partBarcodeController,
                    hintText: l10n.enterPartBarcode,
                  )),
                  Padding(
                      padding: const EdgeInsets.symmetric(horizontal: Dimens.space_4), child: CshTextNew.h3(l10n.or)),
                  _ScanButtonWidget(
                    scannerCallback: (String result, {BarcodeScannerController? controller}) {
                      Navigator.pop(context);
                      partBarcodeController.text = result;
                    },
                  ),
                ],
              ),
            ),
            const Divider(
              thickness: Dimens.space_2,
            ),
            // Container(height: Dimens.space_4, color: Theme.of(context).dividerColor),
            Expanded(
              child: Row(
                children: [
                  Expanded(
                      child: CshTextFormField(
                    controller: deviceBarcodeController,
                    hintText: l10n.enterDeviceBarcode,
                  )),
                  Padding(
                      padding: const EdgeInsets.symmetric(horizontal: Dimens.space_4), child: CshTextNew.h3(l10n.or)),
                  _ScanButtonWidget(
                    scannerCallback: (String result, {BarcodeScannerController? controller}) {
                      Navigator.pop(context);
                      deviceBarcodeController.text = result;
                    },
                  ),
                ],
              ),
            ),
            CshMediumButton(
              text: l10n.submit,
              onPressed: () {
                if (partBarcodeController.text.isEmpty) {
                  CshSnackBar.error(context: context, message: l10n.pleaseEnterPartBarcodeToProceed);
                  return;
                }
                if (deviceBarcodeController.text.isEmpty) {
                  CshSnackBar.error(context: context, message: l10n.pleaseEnterDeviceBarcodeToProceed);
                  return;
                }
                ReplacePartRequest data =
                    ReplacePartRequest(partBarcodeController.text, previousDeviceBarcode, deviceBarcodeController.text);
                _presenter.replacePart(data, l10n);
              },
            )
          ],
        ),
      ),
    );
  }

  @override
  onError(String errorMessage) {
    CshSnackBar.error(context: context, message: errorMessage);
  }

  @override
  onReplacePartSuccess() {
    CshSnackBar.success(context: context, message: l10n.partAssignedSuccessfully);
    Navigator.pop(context);
  }
}

mixin ViewAction {
  onReplacePartSuccess();

  onError(String errorMessage);
}

class _ScanButtonWidget extends StatelessWidget {
  final Function(String result, {BarcodeScannerController? controller}) scannerCallback;

  const _ScanButtonWidget({
    required this.scannerCallback,
  });

  @override
  Widget build(BuildContext context) {
    L10n l10n = L10n(context);
    return CshMediumButton(
      text: l10n.scan,
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) {
              return BarCodeScannerWidget(resultCallback: scannerCallback);
            },
          ),
        );
      },
    );
  }
}
