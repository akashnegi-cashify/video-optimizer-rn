import 'dart:async';

import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/shipex/modules/packaging/widgets/packaging_steps_header_widget.dart';

import '../l10n.dart';

class PackagingProcessStepOneWidget extends StatelessWidget {
  final String? lotName;
  final int? quantity;
  final Function(String)? onProcessFinished;

  PackagingProcessStepOneWidget({
    super.key,
    this.quantity,
    this.lotName,
    this.onProcessFinished,
  });

  final TextEditingController _awbController = TextEditingController();
  Timer? _timer;

  @override
  Widget build(BuildContext context) {
    var l10n = L10n(context);
    return Padding(
      padding: const EdgeInsets.all(Dimens.space_16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          PackagingHeaderWidget(
            title: l10n.packagingProcedure,
            description: l10n.scanOrEnterAwbToProceed,
            stepName: l10n.step1Of3,
            quantity: quantity,
            lotName: lotName,
          ),
          const SizedBox(height: Dimens.space_12),
          CshTextFormField(
            controller: _awbController,
            keyboardType: TextInputType.name,
            hintText: l10n.enterAwbNo,
            maxLength: 100,
            onChanged: (data) {
              if (_timer?.isActive ?? false) _timer?.cancel();
              _timer = Timer(
                const Duration(milliseconds: 500),
                () {
                  if (onProcessFinished != null) {
                    onProcessFinished!(data.trim());
                  }
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
