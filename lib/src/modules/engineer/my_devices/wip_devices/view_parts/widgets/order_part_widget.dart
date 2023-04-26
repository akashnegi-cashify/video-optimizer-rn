import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/src/header/trc_header.dart';
import 'package:flutter_trc/src/modules/engineer/l10n.dart';
import 'package:flutter_trc/src/modules/engineer/models/engineer_device_info.dart';
import 'package:flutter_trc/src/modules/engineer/my_devices/wip_devices/view_parts/models/order_engineer_part.dart';
import 'package:flutter_trc/src/modules/engineer/my_devices/wip_devices/view_parts/providers/order_part_provider.dart';
import 'package:provider/provider.dart';

import '../../../../../../common/widgets/searchbar_widget.dart';

class OrderPartScreen extends StatelessWidget {
  const OrderPartScreen({Key? key}) : super(key: key);
  static const route = "engineer/part/order-part";

  @override
  Widget build(BuildContext context) {
    return const _OrderPartWidget();
  }
}

class _OrderPartWidget extends StatelessWidget {
  const _OrderPartWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    EngineerDeviceInfo deviceInfo = ModalRoute.of(context)?.settings.arguments as EngineerDeviceInfo;

    L10n l10n = L10n(context);

    return ChangeNotifierProvider(
      create: (context) {
        return OrderPartProvider(deviceInfo.deviceBarcode)
          ..getListParts((errorMsg) {
            CshSnackBar.error(context: context, message: errorMsg);
          }, l10n);
      },
      builder: (context, widget) {
        return Scaffold(
          appBar: TrcHeader(l10n.orderPart),
          body: Column(
            children: [
              SearchbarWidget(
                hint: l10n.searchHere,
                onQuery: (query) {
                  context.read<OrderPartProvider>().query = query;
                },
              ),
              Expanded(child: Consumer<OrderPartProvider>(builder: (context, provider, widget) {
                return CshList(
                  onRefresh: () {
                    provider.getListParts((String errorMsg) {
                      CshSnackBar.error(context: context, message: errorMsg);
                    }, l10n);
                  },
                  rowCount: provider.displayList.length,
                  getRowWidget: (index) {
                    OrderEngineerPart part = provider.displayList[index];

                    return CshCard(
                        child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CshTextNew.h3("${l10n.partName} - ${part.partName}"),
                              CshTextNew.h6("${l10n.partSku} - ${part.sku}"),
                              CshTextNew.h6("${l10n.color} - ${part.partColor}"),
                            ],
                          ),
                        ),
                        CounterButton(
                          onIncrementClick: () {
                            provider.updateDataForNIndex(part, 1);
                          },
                          onDecrementClick: () {
                            provider.updateDataForNIndex(part, -1);
                          },
                          key: ValueKey(part.orderQuantity),
                          counter: part.orderQuantity ?? 0,
                        )
                      ],
                    ));
                  },
                );
              }))
            ],
          ),
          bottomNavigationBar: CshBigButton(
            text: l10n.request,
            onPressed: context
                    .watch<OrderPartProvider>()
                    .displayList
                    .where((element) => (element.orderQuantity ?? 0) > 0)
                    .isEmpty
                ? null
                : () {
                    context.read<OrderPartProvider>().orderParts(
                        (errorMessage) => CshSnackBar.error(context: context, message: errorMessage), l10n, () {
                      CshSnackBar.success(context: context, message: l10n.partsOrderedSuccessfully);
                    });
                  },
          ),
        );
      },
    );
  }
}
