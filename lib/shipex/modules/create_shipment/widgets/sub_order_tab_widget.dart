import 'dart:async';

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
  final TextEditingController _searchController = TextEditingController();
  String? _query;
  Timer? _timer;

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var l10n = L10n(context);
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: core.Dimens.space_8, horizontal: core.Dimens.space_12),
          child: core.CshTextFormField(
            controller: _searchController,
            hintText: l10n.searchByName,
            maxLines: 1,
            maxLength: 50,
            onChanged: (String data) {
              if (_timer?.isActive ?? false) _timer?.cancel();
              _timer = Timer(
                const Duration(milliseconds: 500),
                () {
                  if (data.isEmpty) {
                    _query = data.trim();
                  } else {
                    _query = null;
                  }
                },
              );
            },
            keyboardType: TextInputType.name,
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
                  style: theme.primaryTextTheme.subtitle1,
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
                        style: theme.primaryTextTheme.headline3,
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
    provider.getSubOrderGroupDataList(10, pageNo, shipmentStatus: widget.shipmentNumber, query: _query).then((value) {
      if (onSuccess != null) {
        onSuccess(value.subOrderList);
      }
    }, onError: (error) {
      if (onError != null) {
        onError(error);
      }
    });
  }

  @override
  void dispose() {
    if (_timer != null) {
      _timer!.cancel();
    }
    super.dispose();
  }
}
