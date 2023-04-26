import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import '../l10n.dart';
import '../models/list_alternate_parts_response.dart';

class AlternatePartItemWidget extends StatelessWidget {
  final ListAlternateData? dataModel;
  final Function()? onRequestCallback;

  const AlternatePartItemWidget({
    Key? key,
    this.dataModel,
    this.onRequestCallback,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var l10n = L10n(context);
    var theme = Theme.of(context);
    return CshCard(
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (!Validator.isNullOrEmpty(dataModel?.productName)) ...[
                  Row(
                    children: [
                      const SizedBox.shrink(),
                      Expanded(
                        child: Text(
                          dataModel!.productName!,
                          style: theme.primaryTextTheme.headline4,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: Dimens.space_8),
                ],
                if (!Validator.isNullOrEmpty(dataModel?.sku))
                  Row(
                    children: [
                      const SizedBox.shrink(),
                      Expanded(
                        child: Text(
                          dataModel!.sku!,
                          style: theme.primaryTextTheme.headline4,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
              ],
            ),
          ),
          const SizedBox(width: Dimens.space_8),
          CshMediumButton(
            text: l10n.request,
            onPressed: onRequestCallback ?? () {},
          )
        ],
      ),
    );
  }
}
