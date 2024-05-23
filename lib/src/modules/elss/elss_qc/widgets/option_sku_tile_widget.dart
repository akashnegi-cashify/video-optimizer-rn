import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/src/modules/elss/common_models/elss_part.dart';
import '../l10n.dart';

class OptionSkuTileWidget extends StatefulWidget {
  final int indexing;
  final ElssPart? dataModel;

  const OptionSkuTileWidget(
    this.indexing, {
    Key? key,
    this.dataModel,
  }) : super(key: key);

  @override
  State<OptionSkuTileWidget> createState() => _OptionSkuTileWidgetState();
}

class _OptionSkuTileWidgetState extends State<OptionSkuTileWidget> {
  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var l10n = L10n(context);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: Dimens.space_16),
      height: Dimens.space_60,
      width: double.infinity,
      decoration: BoxDecoration(
        color: theme.shadowColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(Dimens.space_4),
      ),
      alignment: Alignment.center,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "${widget.indexing}. ",
            style: theme.primaryTextTheme.labelSmall,
          ),
          const SizedBox(width: Dimens.space_1),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  widget.dataModel?.partName ?? "",
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: theme.primaryTextTheme.labelSmall,
                ),
                Text(
                  "Price: ${l10n.formatPrice(widget.dataModel?.price, defaultValue: 0)}",
                  style: theme.primaryTextTheme.labelSmall,
                ),
              ],
            ),
          ),
          if (widget.dataModel?.quantity != null) ...[
            const SizedBox(width: Dimens.space_8),
            Text(
              "Qty. ${widget.dataModel!.quantity!}",
              style: theme.primaryTextTheme.labelSmall,
            ),
          ]
        ],
      ),
    );
  }
}
