import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/src/modules/laptop_assembly/resources/assembly_parts_response.dart';

const int _kAssemblyScannedStatusCode = 143;

class ChildPartWidget extends StatelessWidget {
  final AssemblyChildPart part;

  const ChildPartWidget({super.key, required this.part});

  bool get _isScanned => part.statusCode == _kAssemblyScannedStatusCode;

  @override
  Widget build(BuildContext context) {
    return CshCard(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CshTextNew.subTitle2(part.partName ?? '-'),
                const SizedBox(height: Dimens.space_4),
                CshTextNew.h4(part.deviceBarcode ?? '-', isPrimary: false),
              ],
            ),
          ),
          const SizedBox(width: Dimens.space_12),
          _StatusChip(isScanned: _isScanned),
        ],
      ),
    );
  }
}

class _StatusChip extends StatelessWidget {
  final bool isScanned;

  const _StatusChip({required this.isScanned});

  @override
  Widget build(BuildContext context) {
    final color = isScanned ? Colors.green : Colors.grey;
    final label = isScanned ? "Scanned" : "Pending";
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: Dimens.space_12, vertical: Dimens.space_4),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(Dimens.space_16),
        border: Border.all(color: color),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(isScanned ? Icons.check_circle : Icons.radio_button_unchecked, size: Dimens.space_14, color: color),
          const SizedBox(width: Dimens.space_4),
          CshTextNew.h4(label),
        ],
      ),
    );
  }
}
