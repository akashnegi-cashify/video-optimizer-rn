import 'package:core/core.dart';
import 'package:core_widgets/core_widgets.dart' as core;
import 'package:flutter/material.dart';

import '../../../../src/utils/paginate_list_abstract.dart';
import '../l10n.dart';
import '../models/suborder_group_list_response.dart';
import '../providers/sub_order_group_list_provider.dart';
import '../screen/sub_order_group_detail_screen.dart';
import 'order_group_card_widget.dart';

class SubOrderGroupTabWidget extends StatefulWidget {
  final int shipmentNumber;

  const SubOrderGroupTabWidget({
    super.key,
    required this.shipmentNumber,
  });

  @override
  State<SubOrderGroupTabWidget> createState() => _SubOrderGroupTabWidgetState();
}

class _SubOrderGroupTabWidgetState extends PaginatedListState<SubOrderGroupListData, SubOrderGroupTabWidget> {
  _SubOrderGroupTabWidgetState() : super(initialScrollOffset: 10, pageSize: 10);
  String? _query;

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var l10n = L10n(context);
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(core.Dimens.space_16),
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(color: theme.primaryColor),
              borderRadius: BorderRadius.circular(core.Dimens.space_4),
            ),
            child: core.SearchBarWidget(
              hintText: "Search by name",
              onQuery: (query) {
                setState(() {
                  _query = query;
                  resetAndRefreshScreen();
                });
              },
            ),
          ),
        ),
        Expanded(
          child: iterate(
            (item, index) {
              return OrderGroupWidget(
                dataModel: item,
                isCreatedTypeList: widget.shipmentNumber == 1,
                onCardPressed: () {
                  SubOrderGroupDetailsScreenArguments args = SubOrderGroupDetailsScreenArguments(
                    groupId: (item.id != null) ? item.id!.toString() : "",
                    shipmentId: (item.shipmentId != null) ? item.shipmentId!.toString() : "",
                    courierAwb: item.packagingBarcode ?? "",
                    lotName: item.name,
                    devicesQuantity: item.totalQty ?? 0,
                    pinCode: item.pinCode,
                    shipmentStatus: widget.shipmentNumber,
                  );
                  Logger.debug('mydebug------_SubOrderGroupTabWidgetState.build', [args.toJson()]);
                  Navigator.of(context).pushNamed(SubOrderGroupDetailsScreen.route, arguments: args);
                },
              );
            },
            onRefresh: () async {},
            separator: const SizedBox(height: core.Dimens.space_12),
            onNoDataFound: () {
              return Center(
                child: Text(
                  l10n.noDataFound,
                  style: theme.primaryTextTheme.titleMedium,
                  textAlign: TextAlign.center,
                ),
              );
            },
            onError: (String error) {
              return Center(
                child: Row(
                  children: [
                    const SizedBox.shrink(),
                    Expanded(
                      child: Text(
                        error,
                        style: theme.primaryTextTheme.displaySmall,
                        textAlign: TextAlign.center,
                      ),
                    )
                  ],
                ),
              );
            },
            padding: const EdgeInsets.symmetric(horizontal: core.Dimens.space_16, vertical: core.Dimens.space_12),
          ),
        )
      ],
    );
  }

  @override
  void requestApi(int pageNo,
      {Function(List<SubOrderGroupListData>? list)? onSuccess, Function(String errorMessage)? onError}) {
    var provider = SubOrderGroupListProvider.of(context, listen: false);
    provider.getSubOrderGroupDataList(pageSize, ++pageNo, shipmentStatus: widget.shipmentNumber, query: _query).then(
        (value) {
      if (onSuccess != null) {
        onSuccess(value.subOrderList);
      }
    }, onError: (error) {
      if (onError != null) {
        onError(error);
      }
    });
  }
}
