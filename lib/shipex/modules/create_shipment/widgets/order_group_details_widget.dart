import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../l10n.dart';
import '../providers/order_group_details_provider.dart';
import '../screen/create_shipment_screen.dart';
import '../screen/upload_eway_bill_screen.dart';
import 'doc_downloader_widget.dart';

class OrderGroupDetailsWidget extends StatelessWidget {
  final String groupId;
  final String? shipmentId;
  final String? courierAwb;
  final int? devicesQuantity;
  final String? lotName;
  final String? pinCode;

  const OrderGroupDetailsWidget({
    super.key,
    required this.groupId,
    this.shipmentId,
    this.courierAwb,
    this.lotName,
    this.devicesQuantity,
    this.pinCode,
  });

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var l10n = L10n(context);
    return ChangeNotifierProvider<OrderGroupDetailsProvider>(
      create: (_) => OrderGroupDetailsProvider(groupId),
      lazy: false,
      builder: (BuildContext insideContext, __) {
        var provider = OrderGroupDetailsProvider.of(insideContext);
        if (provider.isDataLoading) {
          return const Scaffold(
            body: Center(
              child: SizedBox(
                height: Dimens.space_30,
                width: Dimens.space_30,
                child: CircularProgressIndicator(),
              ),
            ),
          );
        } else if (provider.isDataLoading == false && !Validator.isNullOrEmpty(provider.errorMessage)) {
          return Scaffold(
            body: Center(
              child: Row(
                children: [
                  const SizedBox.shrink(),
                  Expanded(
                    child: Text(
                      provider.errorMessage!,
                      style: theme.primaryTextTheme.headlineMedium,
                      textAlign: TextAlign.center,
                    ),
                  )
                ],
              ),
            ),
          );
        }
        return Column(
          children: [
            Expanded(
              child: ListView.separated(
                padding: const EdgeInsets.symmetric(vertical: Dimens.space_12, horizontal: Dimens.space_16),
                itemBuilder: (context, index) {
                  return _verticalKeyValuePair(
                      theme,
                      provider.responseData?.getLabelAndValueData().keys.toList()[index] ?? "",
                      provider.responseData?.getLabelAndValueData().values.toList()[index] ?? "");
                },
                separatorBuilder: (context, index) {
                  return const SizedBox(height: Dimens.space_12);
                },
                itemCount: provider.responseData?.getLabelAndValueData().length ?? 0,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: Dimens.space_16, vertical: Dimens.space_12),
              child: Column(
                children: [
                  DocDownloaderWidget(
                    shipmentId: shipmentId ?? "",
                    courierAwb: courierAwb ?? "",
                  ),
                  if (!Validator.isNullOrEmpty(provider.responseData?.invoiceLink)) ...[
                    const SizedBox(height: Dimens.space_12),
                    SizedBox(
                      width: double.infinity,
                      child: CshMediumButton(
                        text: l10n.invoice,
                        onPressed: () {},
                      ),
                    ),
                  ],
                  const SizedBox(height: Dimens.space_12),
                  SizedBox(
                    width: double.infinity,
                    child: CshMediumButton(
                      text: l10n.uploadEWayBill,
                      onPressed: () {
                        UploadEwayBillScreenArguments args = UploadEwayBillScreenArguments(
                            shipmentId: shipmentId, facilityId: provider.responseData?.facilityId);
                        Navigator.of(context).pushNamed(UploadEwayBillScreen.route, arguments: args);
                      },
                    ),
                  ),
                  const SizedBox(height: Dimens.space_12),
                  SizedBox(
                    width: double.infinity,
                    child: CshMediumButton(
                      text: l10n.createShipment,
                      onPressed: () {
                        CreateShipmentScreenArguments args = CreateShipmentScreenArguments(
                          facilityId: provider.responseData?.facilityId,
                          groupId: groupId,
                          pinCode: pinCode,
                          shipmentId: (!Validator.isNullOrEmpty(shipmentId)) ? int.parse(shipmentId!) : 0,
                          lotName: lotName,
                          devicesQuantity: devicesQuantity,
                        );
                        Navigator.of(context).pushNamed(CreateShipmentScreen.route, arguments: args);
                      },
                    ),
                  )
                ],
              ),
            )
          ],
        );
      },
    );
  }

  _verticalKeyValuePair(ThemeData theme, String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: theme.primaryTextTheme.headlineMedium),
        const SizedBox(height: Dimens.space_8),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(),
            Expanded(
              child: Text(
                value,
                style: theme.primaryTextTheme.bodyText2,
              ),
            )
          ],
        )
      ],
    );
  }
}
