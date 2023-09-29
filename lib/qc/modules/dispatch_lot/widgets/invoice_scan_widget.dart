import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:ml_barcode_scanner/widgets/index.dart';
import 'package:provider/provider.dart';
import '../l10n.dart';
import '../providers/dispatch_complete_provider.dart';

class InvoiceScanWidget extends StatelessWidget {
  const InvoiceScanWidget({super.key});

  @override
  Widget build(BuildContext context) {
    var l10n = L10n(context);
    return ChangeNotifierProvider(
      create: (context) => DispatchCompleteProvider(),
      lazy: false,
      builder: (BuildContext insideContext, __) {
        var provider = DispatchCompleteProvider.of(insideContext);
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: MlBarcodeScannerWidget(
                allowDuplicateScan: false,
                onScannerDetected: (String value, MlScannerController controller) {
                  if (value.isNotEmpty) {
                    provider.textEditingController.text = value.trim();
                    _navigateTo(insideContext);
                  }
                },
              ),
            ),
            const SizedBox(width: Dimens.space_8),
            Padding(
              padding: const EdgeInsets.all(Dimens.space_16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  CshTextFormField(labelText: l10n.enterHere, controller: provider.textEditingController),
                  const SizedBox(width: Dimens.space_8),
                  ValueListenableBuilder(
                    valueListenable: provider.textEditingController,
                    builder: (BuildContext context, value, Widget? child) {
                      return CshBigButton(
                        text: l10n.submit,
                        onPressed: value.text.isNotEmpty ? () => _navigateTo(insideContext) : null,
                      );
                    },
                  ),
                ],
              ),
            )
          ],
        );
      },
    );
  }

  void _navigateTo(BuildContext context) {
    var provider = DispatchCompleteProvider.of(context, listen: false);
    Navigator.pop(context,provider.textEditingController.text);

  }

}
