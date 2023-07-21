import 'dart:async';

import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/shipex/modules/dispatch/providers/shipex_dispatch_provider.dart';

import '../../l10n.dart';
import '../models/delivery_partner_list_response.dart';
import 'delivery_partner_detail_card_widget.dart';

class DispatchDeliveryListWidget extends StatefulWidget {
  final Function(DeliveryPartnerListData? dataModel)? onDeliveryPartnerClicked;

  const DispatchDeliveryListWidget({
    super.key,
    this.onDeliveryPartnerClicked,
  });

  @override
  State<DispatchDeliveryListWidget> createState() => _DispatchDeliveryListWidgetState();
}

class _DispatchDeliveryListWidgetState extends State<DispatchDeliveryListWidget> with AutomaticKeepAliveClientMixin {
  @override
  void initState() {
    scheduleMicrotask(() {
      var provider = ShipexDispatchProvider.of(context, listen: false);
      provider.fetchDeliveryPartnerListData();
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    var theme = Theme.of(context);
    var l10n = L10n(context);
    var provider = ShipexDispatchProvider.of(context);
    if (Validator.isTrue(provider.deliveryListLoading)) {
      return const Center(
        child: SizedBox(
          height: Dimens.space_30,
          width: Dimens.space_30,
          child: CircularProgressIndicator(),
        ),
      );
    } else if (!Validator.isNullOrEmpty(provider.deliveryListErrorMessage)) {
      return Center(
        child: Row(
          children: [
            const SizedBox.shrink(),
            Expanded(
              child: Text(
                provider.deliveryListErrorMessage!,
                style: theme.primaryTextTheme.headlineMedium,
                textAlign: TextAlign.center,
              ),
            )
          ],
        ),
      );
    } else {
      if (Validator.isListNullOrEmpty(provider.deliveryPartnerList)) {
        return Center(
          child: Row(
            children: [
              const SizedBox.shrink(),
              Expanded(
                  child: Text(
                l10n.noDeliveryPartnerFound,
                style: theme.primaryTextTheme.headlineMedium,
                textAlign: TextAlign.center,
              )),
            ],
          ),
        );
      } else {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: Dimens.space_12),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: Dimens.space_16),
              child: Text(
                l10n.listOfDeliveryPartners,
                style: theme.primaryTextTheme.displaySmall,
              ),
            ),
            Expanded(
              child: ListView.separated(
                padding: const EdgeInsets.symmetric(horizontal: Dimens.space_16, vertical: Dimens.space_20),
                itemBuilder: (context, index) {
                  return DeliveryPartnerDetailCardWidget(
                    dataModel: provider.deliveryPartnerList![index],
                    onCardPressed: widget.onDeliveryPartnerClicked ?? (DeliveryPartnerListData? dataModel) {},
                  );
                },
                separatorBuilder: (context, index) {
                  return const SizedBox(height: Dimens.space_10);
                },
                itemCount: provider.deliveryPartnerList!.length,
              ),
            ),
          ],
        );
      }
    }
  }

  @override
  bool get wantKeepAlive => true;
}
