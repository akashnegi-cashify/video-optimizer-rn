import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/shipex/modules/dispatch/models/delivery_partner_list_response.dart';
import 'package:flutter_trc/shipex/modules/pending_dispatch/resources/delivery_partner_list_type.dart';
import 'package:flutter_trc/shipex/modules/pending_dispatch/resources/pending_dispatch_service.dart';
import 'package:flutter_trc/shipex/modules/pending_dispatch/screens/complete_dispatch_screen.dart';
import 'package:flutter_trc/src/common/widgets/shimmer_list_widget.dart';
import '../../l10n.dart';

class PendingDispatchProviderListWidget extends StatefulWidget {
  const PendingDispatchProviderListWidget({super.key});

  @override
  State<PendingDispatchProviderListWidget> createState() => _PendingDispatchProviderListWidgetState();
}

class _PendingDispatchProviderListWidgetState extends State<PendingDispatchProviderListWidget> {
  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var l10n = L10n(context);
    return Padding(
        padding: const EdgeInsets.all(Dimens.space_16),
        child: StreamBuilder<DeliveryPartnerListResponse>(
          stream: getApiStream(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const ShimmerListWidget(itemHeight: Dimens.space_60);
            }

            if (snapshot.hasData && snapshot.data?.deliveryPartnerList != null) {
              var list = snapshot.data!.deliveryPartnerList;
              return CshList(
                rowCount: list?.length ?? 0,
                verticalRowSpacing: Dimens.space_16,
                listPadding: EdgeInsets.zero,
                noDataFoundWidget: ({isListEmpty, serverErrorMsg}) {
                  return Center(child: Text(l10n.noDataFound, style: theme.primaryTextTheme.titleMedium));
                },
                onRefresh: () {
                  setState(() {});
                },
                getRowWidget: (index) {
                  var item = list?[index];
                  return GestureDetector(
                    onTap: () {
                      CompleteDispatchScreen.navigate(context, item?.key ?? "").then((value) {
                        setState(() {});
                      });
                    },
                    child: CshCard(
                      child: Row(
                        children: [
                          Expanded(child: Text(item?.name ?? "", style: theme.textTheme.titleMedium)),
                          Text("${item?.count ?? 0}", style: theme.textTheme.titleMedium),
                        ],
                      ),
                    ),
                  );
                },
              );
            }
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(l10n.noDataFound, style: theme.primaryTextTheme.titleMedium),
                  const SizedBox(height: Dimens.space_16),
                  CshMediumButton(
                      text: l10n.retry,
                      onPressed: () {
                        setState(() {});
                      }),
                ],
              ),
            );
          },
        ));
  }

  Stream<DeliveryPartnerListResponse> getApiStream() {
    return PendingDispatchService.getPendingDispatchProviderList(DeliveryPartnerListTye.scanned);
  }
}
