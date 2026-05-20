import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class AssemblyScanProgressView extends StatefulWidget {
  final String parentBarcode;
  final ValueListenable<List<String>> scannedBarcodes;
  final void Function(String barcode) onManualSubmit;

  const AssemblyScanProgressView({
    super.key,
    required this.parentBarcode,
    required this.scannedBarcodes,
    required this.onManualSubmit,
  });

  @override
  State<AssemblyScanProgressView> createState() => _AssemblyScanProgressViewState();
}

class _AssemblyScanProgressViewState extends State<AssemblyScanProgressView> {
  final TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _submit() {
    final text = _controller.text.trim();
    if (text.isEmpty) return;
    widget.onManualSubmit(text);
    _controller.clear();
    FocusScope.of(context).unfocus();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(Dimens.space_16),
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          CshTextFormField(
            controller: _controller,
            hintText: "Scan Barcode",
            textInputAction: TextInputAction.done,
            onFieldSubmitted: (_) => _submit(),
          ),
          const SizedBox(height: Dimens.space_12),
          CshMediumButton(text: "Submit", onPressed: _submit),
          const SizedBox(height: Dimens.space_16),
          ValueListenableBuilder<List<String>>(
            valueListenable: widget.scannedBarcodes,
            builder: (_, list, __) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  CshTextNew.h4("Parent: ${widget.parentBarcode}", isPrimary: false),
                  const SizedBox(height: Dimens.space_4),
                  CshTextNew.h4("Scanned this session: ${list.length}", isPrimary: false),
                  if (list.isNotEmpty) ...[
                    const SizedBox(height: Dimens.space_8),
                    ConstrainedBox(
                      constraints: const BoxConstraints(maxHeight: 96),
                      child: ListView.builder(
                        shrinkWrap: true,
                        padding: EdgeInsets.zero,
                        itemCount: list.length,
                        itemBuilder: (_, i) => Padding(
                          padding: const EdgeInsets.symmetric(vertical: 2),
                          child: Row(
                            children: [
                              const Icon(Icons.check_circle, size: Dimens.space_14, color: Colors.green),
                              const SizedBox(width: Dimens.space_6),
                              Expanded(child: CshTextNew.h4(list[i])),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}
