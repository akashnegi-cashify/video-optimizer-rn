import 'package:core_widgets/core_widgets.dart' hide iterate;
import 'package:flutter/material.dart';

import '../../../../src/common/resources/lot_list_request.dart';
import '../../../../src/utils/paginate_list_abstract.dart';
import '../providers/store_out_provider.dart';
import '../resources/index.dart';
import '../resources/services.dart';
import 'index.dart';

class StoreOutLotListWidget extends StatefulWidget {
  const StoreOutLotListWidget({
    super.key,
    this.onItemClick,
  });

  final Function(String? lotName)? onItemClick;

  @override
  State<StoreOutLotListWidget> createState() => _StoreOutLotListWidgetState();
}

class _StoreOutLotListWidgetState extends PaginatedListState<StoreOutLotListItem, StoreOutLotListWidget>
    with AutomaticKeepAliveClientMixin {
  @override
  void initState() {
    super.initState();
    var provider = StoreOutProvider.of(context, listen: false);
    provider.controller.stream.listen((event) {
      resetAndRefreshScreen();
    });

    provider.searchQueryStreamController.stream.listen((event) {
      resetAndRefreshScreen();
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return iterate(
      (item, index) => Padding(
        padding: EdgeInsets.only(
          left: Dimens.space_16,
          right: Dimens.space_16,
          top: index == 0 ? Dimens.space_16 : Dimens.space_8,
          bottom: index == items.length - 1 ? Dimens.space_16 : Dimens.space_8,
        ),
        child: cshGestureDetector(
            child: ListItemWidget(
              lotName: item.lotGrpName,
              noOfDevices: "${item.deviceCount ?? 0}",
              lotType: item.lotType,
            ),
            onTap: () {
              widget.onItemClick?.call(item.lotGrpName);
            }),
      ),
      onRefresh: () {
        return Future.delayed(const Duration(seconds: 1), () {});
      },
    );
  }

  @override
  void requestApi(int pageNo,
      {Function(List<StoreOutLotListItem>? list)? onSuccess, Function(String errorMessage)? onError}) {
    var provider = StoreOutProvider.of(context, listen: false);
    FilterMap? filterMap;
    LotListRequest request = LotListRequest()
      ..pageNo = pageNo * pageSize
      ..pageSize = pageSize;

    if (isNotEmpty(provider.searchQuery)) {
      filterMap = FilterMap(searchQuery: provider.searchQuery);
    }

    if (isNotEmpty(provider.lotTypeQuery)) {
      filterMap = filterMap ?? FilterMap();
      filterMap.lotType = provider.lotTypeQuery;
    }

    request.filterMap = filterMap;

    StoreOutServices.fetchStoreOutLotList(request).listen(
      (value) {
        if (onSuccess != null) {
          onSuccess(ArrayUtil.removeNullItems(value?.lotList ?? []));
        }
      },
      onError: (error) {
        if (onError != null) {
          onError(error);
        }
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}
