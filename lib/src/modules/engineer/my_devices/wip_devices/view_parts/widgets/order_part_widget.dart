import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/src/common/widgets/my_counter_button.dart';
import 'package:flutter_trc/src/header/trc_header.dart';
import 'package:flutter_trc/src/modules/engineer/l10n.dart';
import 'package:flutter_trc/src/modules/engineer/my_devices/wip_devices/view_parts/models/order_engineer_part.dart';
import 'package:flutter_trc/src/modules/engineer/my_devices/wip_devices/view_parts/providers/order_part_provider.dart';
import 'package:provider/provider.dart';

import '../../../../../../common/widgets/searchbar_widget.dart';

class OrderPartScreenArg {
  final String? deviceBarcode;

  OrderPartScreenArg(this.deviceBarcode);
}

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
    OrderPartScreenArg deviceInfo = ModalRoute.of(context)?.settings.arguments as OrderPartScreenArg;

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
                                const SizedBox(height: Dimens.space_6),
                                CshDropDown(
                                    items: provider.partTypeList,
                                    key: ValueKey("${part.sku}-${part.partColor}-${part.selectedPartType?.id}"),
                                    selectedItem: part.selectedPartType,
                                    hintText: "Select",
                                    onChanged: (DropDownItem? value) {
                                      provider.updatePartTypeSelection(part, value);
                                    }),
                              ],
                            ),
                          ),
                          const SizedBox(width: Dimens.space_8),
                          MyCounterButton(
                            onIncrementClick: () {
                              provider.updateDataForNIndex(part, 1);
                            },
                            onDecrementClick: () {
                              provider.updateDataForNIndex(part, -1);
                            },
                            key: ValueKey(part.orderQuantity),
                            isDismissed: part.selectedPartType == null,
                            maxCount: provider.getMaxQuantity(part.selectedPartType),
                            counter: part.orderQuantity ?? 0,
                          )
                        ],
                      ),
                    );
                  },
                );
              }))
            ],
          ),
          bottomNavigationBar: CshBigButton(
            text: l10n.request,
            onPressed: context.watch<OrderPartProvider>().getSelectedPartList().isEmpty
                ? null
                : () {
                    CshLoading().showLoading(context);
                    context.read<OrderPartProvider>().orderParts(
                      l10n,
                      handleError: (errorMessage) {
                        CshLoading().hideLoading(context);
                        CshSnackBar.error(context: context, message: errorMessage);
                      },
                      callback: () {
                        CshLoading().hideLoading(context);
                        Navigator.pop(context, true);
                        CshSnackBar.success(context: context, message: l10n.partsOrderedSuccessfully);
                      },
                    );
                  },
          ),
        );
      },
    );
  }
}
