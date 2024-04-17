import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/src/modules/retrieved_part_qc/providers/action_provider.dart';

import '../../../common/utils/csh_ml_scanner_util.dart';
import '../l10n.dart';
import 'action_item_widget.dart';

class ActionWidget extends StatefulWidget {
  const ActionWidget({super.key});

  @override
  State<ActionWidget> createState() => _ActionWidgetState();
}

class _ActionWidgetState extends State<ActionWidget> {
  final _barcodeController = TextEditingController();
  final TextInputDebounce _debounce = TextInputDebounce();

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var l10n = L10n(context);
    var provider = ActionProvider.of(context);
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(Dimens.space_16, Dimens.space_16, Dimens.space_16, 0),
          child: CshTextFormField(
            hintText: l10n.searchBarcode,
            hintStyle: theme.textTheme.labelSmall,
            controller: _barcodeController,
            onChanged: (_) {
              _debounce.start(() {
                _onSearch();
              });
            },
            suffixIcon: InkWell(
              child: const Icon(Icons.qr_code_2),
              onTap: () {
                CshMlScannerUtil().openScanner(context, onScanned: (scannedData, controller) {
                  Navigator.pop(context); // close scanner
                  _barcodeController.text = scannedData;
                  _onSearch();
                });
              },
            ),
          ),
        ),
        const SizedBox(height: Dimens.space_16),
        if (!Validator.isListNullOrEmpty(provider.listState.data))
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: Dimens.space_12),
            child: ActionWidgetItem(dataModel: provider.listState.data!.first),
          )
      ],
    );
  }

  _onSearch() {
    var provider = ActionProvider.of(context, listen: false);
    CshLoading().showLoading(context);
    provider.getItemData(_barcodeController.text.trim()).then((value) {
      CshLoading().hideLoading(context);
    }, onError: (error) {
      CshLoading().hideLoading(context);
      CshSnackBar.error(context: context, message: error);
    });
  }
}
