import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/src/modules/inventory_manager/models/recommended_part_response.dart';

import '../l10n.dart';

class RecommendedBarcodeListWidget extends StatelessWidget {
  final List<RecommendedPartData> recommendedPartList;

  const RecommendedBarcodeListWidget(this.recommendedPartList, {super.key});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var l10n = L10n(context);
    return CshCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            l10n.suggestedBarcode,
            style: theme.primaryTextTheme.headlineMedium?.copyWith(color: theme.primaryColor),
          ),
          const SizedBox(height: Dimens.space_8),
          Table(
            border: TableBorder.all(),
            defaultVerticalAlignment: TableCellVerticalAlignment.middle,
            children: [
              TableRow(children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: Dimens.space_2),
                  child: Center(child: CshTextNew.overLine(l10n.partBarcode)),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: Dimens.space_2),
                  child: Center(child: CshTextNew.overLine(l10n.location)),
                ),
              ]),
              ..._getTableRows()
            ],
          ),
        ],
      ),
    );
  }

  List<TableRow> _getTableRows() {
    return recommendedPartList.map((e) {
      return TableRow(children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: Dimens.space_4),
          child: Center(child: CshTextNew.h4(e.barcode ?? "")),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: Dimens.space_4, horizontal: Dimens.space_4),
          child: Center(child: CshTextNew.h4(e.location ?? "")),
        ),
      ]);
    }).toList();
  }
}
