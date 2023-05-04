import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import '../l10n.dart';
import '../models/engineer_list_response.dart';
import '../screens/pending_delivery_screen.dart';

class EngineerListItemWidget extends StatelessWidget {
  final int index;
  final EngineerDataResponse? dataModel;

  const EngineerListItemWidget({
    Key? key,
    required this.index,
    this.dataModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var l10n = L10n(context);
    if ((!Validator.isNullOrEmpty(dataModel?.name))) {
      return GestureDetector(
        onTap: () {
          if (dataModel?.id != null) {
            PendingDeliveryScreenArguments args = PendingDeliveryScreenArguments(id: dataModel!.id!);
            Navigator.of(context).pushNamed(PendingDeliveryScreen.route, arguments: args);
          } else {
            CshSnackBar.error(context: context, message: l10n.idNotFound);
          }
        },
        child: CshCard(
          radius: CshRadius.rad8,
          elevation: CardElevation.dimen_10,
          padding: const EdgeInsets.symmetric(horizontal: Dimens.space_8, vertical: Dimens.space_8),
          child: Row(
            children: [
              RichText(
                text: TextSpan(
                  text: "$index  ",
                  style: theme.primaryTextTheme.headline4?.copyWith(color: theme.primaryColor),
                  children: <TextSpan>[
                    TextSpan(
                      text: l10n.engineerSName,
                      style: theme.primaryTextTheme.headline4?.copyWith(color: theme.primaryColor),
                    )
                  ],
                ),
              ),
              const SizedBox(width: Dimens.space_16),
              Text(
                dataModel?.name ?? "",
                style: theme.primaryTextTheme.headline4,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              )
            ],
          ),
        ),
      );
    } else {
      return const SizedBox.shrink();
    }
  }
}
