import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';

import '../../l10n.dart';
import '../models/delivery_partner_list_response.dart';

class DeliveryPartnerDetailCardWidget extends StatelessWidget {
  final DeliveryPartnerListData? dataModel;
  final Function(DeliveryPartnerListData? dataModel)? onCardPressed;

  const DeliveryPartnerDetailCardWidget({
    super.key,
    this.dataModel,
    this.onCardPressed,
  });

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var l10n = L10n(context);
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () {
        if (onCardPressed != null) {
          onCardPressed!(dataModel);
        }
      },
      child: CshCard(
        radius: CshRadius.rad8,
        elevation: CardElevation.dimen_10,
        padding: const EdgeInsets.symmetric(vertical: Dimens.space_12, horizontal: Dimens.space_10),
        child: Row(
          children: [
            Text("${l10n.name}: ", style: theme.primaryTextTheme.bodyMedium),
            const SizedBox(width: Dimens.space_4),
            Expanded(
              child: Text(
                dataModel?.name ?? "",
                style: theme.primaryTextTheme.headlineMedium,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            )
          ],
        ),
      ),
    );
  }
}
