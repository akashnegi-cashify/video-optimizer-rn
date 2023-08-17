import 'dart:async';

import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/shipex/modules/packaging/widgets/packaging_steps_header_widget.dart';

import '../l10n.dart';

enum PackagingStep {
  scanAWB("Scan AWB to proceed", "Step 1 of 3", "Scan awb number"),
  scanInvoice("Scan Invoice Number to proceed", "Step 2 of 3", "Scan invoice number"),
  scanDeviceBarcode("Scan any device of the lot", "Step 3 of 3", "Scan device barcode");

  final String headerDescription;
  final String stepName;
  final String hintText;

  const PackagingStep(this.headerDescription, this.stepName, this.hintText);

  static PackagingStep getPackagingStepByIndex(int index) {
    return PackagingStep.values[index];
  }
}

class PackagingProcessStepOneWidget extends StatefulWidget {
  final String? lotName;
  final int? quantity;
  final PackagingStep step;
  final Function(String data, PackagingStep step)? onProcessFinished;

  const PackagingProcessStepOneWidget({
    super.key,
    this.quantity,
    this.lotName,
    required this.step,
    this.onProcessFinished,
  });

  @override
  State<PackagingProcessStepOneWidget> createState() => PackagingProcessStepOneWidgetState();
}

class PackagingProcessStepOneWidgetState extends State<PackagingProcessStepOneWidget> {
  final TextEditingController _awbController = TextEditingController();

  Timer? _timer;

  final FocusNode _focusNode = FocusNode();
  int delayInMilli = 500;

  resetScannerValue() {
    _awbController.text = "";
    requestFocus();
  }

  requestFocus() {
    _focusNode.requestFocus();
  }

  // @override
  // void initState() {
  //   if (kDebugMode) {
  //     delayInMilli = 2000;
  //   }
  //   super.initState();
  // }

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
            description: widget.step.headerDescription,
            stepName: widget.step.stepName,
            quantity: widget.quantity,
            lotName: widget.lotName,
          ),
          const SizedBox(height: Dimens.space_12),
          CshTextFormField(
            controller: _awbController,
            keyboardType: TextInputType.name,
            focusNode: _focusNode,
            autofocus: true,
            hintText: widget.step.hintText,
            maxLength: 100,
            onChanged: (data) {
              if (_timer?.isActive ?? false) _timer?.cancel();
              _timer = Timer(
                Duration(milliseconds: delayInMilli),
                () {
                  if (widget.onProcessFinished != null) {
                    widget.onProcessFinished!(data.trim(), widget.step);
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
