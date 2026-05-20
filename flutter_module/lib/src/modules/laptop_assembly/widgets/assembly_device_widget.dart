import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/src/modules/laptop_assembly/resources/assembly_device_response.dart';
import 'package:flutter_trc/src/modules/laptop_assembly/screens/assembly_parts_detail_screen.dart';

class AssemblyDeviceWidget extends StatelessWidget {
  final AssemblyDevice? item;
  final int index;
  final VoidCallback? onActionComplete;

  const AssemblyDeviceWidget({
    super.key,
    required this.index,
    this.item,
    this.onActionComplete,
  });

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return cshGestureDetector(
      onTap: () => _openPartsDetail(context),
      child: CshCard(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            CshTextNew(
              '#${index + 1}   ${item?.deviceBarcode ?? ''}',
              textStyle: theme.textTheme.headlineMedium?.copyWith(color: theme.primaryColor),
            ),
            const SizedBox(height: Dimens.space_12),
            _row("Model", item?.model ?? '-'),
            const SizedBox(height: Dimens.space_6),
            _row("Status", item?.statusDescription ?? '-'),
            const SizedBox(height: Dimens.space_6),
            _row("Engineer", item?.engineer ?? '-'),
          ],
        ),
      ),
    );
  }

  Widget _row(String title, String value) {
    return Flexible(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(child: CshTextNew.h4(title, isPrimary: false)),
          Expanded(child: CshTextNew.h4(value)),
        ],
      ),
    );
  }

  Future<void> _openPartsDetail(BuildContext context) async {
    final barcode = item?.deviceBarcode;
    if (barcode == null) return;
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => AssemblyPartsDetailScreen(parentBarcode: barcode)),
    );
    if (result == true) {
      onActionComplete?.call();
    }
  }
}
