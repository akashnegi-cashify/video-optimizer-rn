import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/qc/modules/qc_tester/lob_devices/resources/variant_list_response.dart';

class VariantListItemWidget extends StatelessWidget {
  final VariantListData item;
  final Function(VariantListData item)? onTap;

  const VariantListItemWidget(this.item, {this.onTap, super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (onTap != null) {
          onTap!(item);
        }
      },
      child: CshCard(
        child: Column(
          children: [
            buildValues(context, "Model", item.commonName ?? "Not found"),
            buildValues(context, "Screen Size", item.screenSize ?? ""),
            buildValues(context, "Processor", item.processor ?? ""),
          ],
        ),
      ),
    );
  }

  Widget buildValues(BuildContext context, String key, String value) {
    var theme = Theme.of(context);
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Flexible(flex: 2, fit: FlexFit.tight, child: Text(key, style: theme.textTheme.headlineSmall)),
        const SizedBox(width: Dimens.space_8),
        Flexible(flex: 4, fit: FlexFit.tight, child: Text(value, style: theme.textTheme.headlineMedium, maxLines: 2))
      ],
    );
  }
}
