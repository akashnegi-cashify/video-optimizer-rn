import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';

import '../l10n.dart';
import '../providers/action_provider.dart';
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
    var provider = ActionProvider.of(context);
    return Column(
      children: [

        if (!Validator.isListNullOrEmpty(provider.listState.data))
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: Dimens.space_12),
            child: ActionWidgetItem(dataModel: provider.listState.data!.first),
          ),
        if (Validator.isListNullOrEmpty(provider.listState.data))
          Center(
            child: Text(
              "No Item Found",
              style: theme.primaryTextTheme.headlineMedium,
              textAlign: TextAlign.center,
            ),
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
