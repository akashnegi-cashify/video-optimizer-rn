import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_trc/src/modules/elss/common_models/elss_part.dart';

import '../l10n.dart';

class OptionSkuTileWidget extends StatefulWidget {
  final int indexing;
  final ElssPart? dataModel;
  final Function()? onImageUpload;

  const OptionSkuTileWidget(
    this.indexing, {
    Key? key,
    this.dataModel,
    this.onImageUpload,
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Row(
              children: [
                Text(
                  widget.indexing.toString(),
                  style: theme.primaryTextTheme.overline,
                ),
                const SizedBox(width: Dimens.space_1),
                Text(
                  widget.dataModel?.partName ?? "",
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: theme.primaryTextTheme.overline,
                ),
              ],
            ),
          ),
          const SizedBox(
            width: Dimens.space_16,
          ),
          GestureDetector(
            onTap: () {
              if (widget.onImageUpload != null) {
                widget.onImageUpload!();
              }
            },
            child: (!Validator.isNullOrEmpty(widget.dataModel?.imageS3Url))
                ? Container(
                    alignment: Alignment.center,
                    height: Dimens.space_20,
                    padding: const EdgeInsets.symmetric(horizontal: Dimens.space_4),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(Dimens.space_4),
                      border: Border.all(
                        color: theme.primaryColor,
                        width: Dimens.space_2,
                      ),
                    ),
                    child: Text(
                      l10n.imageAttached,
                      textAlign: TextAlign.center,
                      style: theme.primaryTextTheme.headline6?.copyWith(color: theme.primaryColor),
                    ),
                  )
                : CshIcon(
                    FeatherIcons.camera,
                    iconSize: MobileIconSize.large,
                    padding: EdgeInsets.zero,
                    iconColor: theme.primaryColor,
                  ),
          )
        ],
      ),
    );
  }
}
