import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import '../l10n.dart';
import 'index.dart';

class ProductInfoWidget extends StatelessWidget {
  final String? sourceName;
  final String? product;
  final String? brand;
  final String? imei1;
  final String? imei2;

  const ProductInfoWidget({
    super.key,
    this.sourceName,
    this.product,
    this.brand,
    this.imei1,
    this.imei2,
  });

  @override
  Widget build(BuildContext context) {
    var l10n = L10n(context);
    return Padding(
      padding: const EdgeInsets.all(Dimens.space_12),
      child: CshCard(
        padding: EdgeInsets.zero,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            LabeledText(label: l10n.product, value: product),
            LabeledText(label: l10n.brand, value: brand),
            LabeledText(label: l10n.imei1, value: imei1),
            LabeledText(label: l10n.imei2, value: imei2),
            LabeledText(label: l10n.sourceName, value: sourceName),
          ],
        ),
      ),
    );
  }
}
