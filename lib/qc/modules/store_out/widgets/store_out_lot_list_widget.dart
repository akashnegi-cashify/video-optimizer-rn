import 'package:core_widgets/core_widgets.dart' hide iterate;
import 'package:flutter/material.dart';

import '../../../../src/utils/paginate_list_abstract.dart';
import '../providers/store_out_provider.dart';
import '../resources/index.dart';
import 'index.dart';
import '../l10n.dart';

class StoreOutLotListWidget extends StatefulWidget {
  const StoreOutLotListWidget({
    super.key,
    this.onItemClick,
  });

  final Function(String? lotName)? onItemClick;

  @override
  State<StoreOutLotListWidget> createState() => StoreOutLotListWidgetState();
}

class StoreOutLotListWidgetState extends PaginatedListState<StoreOutLotListItem, StoreOutLotListWidget>
    with AutomaticKeepAliveClientMixin {

  @override
  Widget build(BuildContext context) {
    super.build(context);
    var l10n = L10n(context);
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
              l10n.groupName,
              lotValue: item.lotGrpName,
              noOfDevices: "${item.deviceCount ?? 0}",
              lotType: item.lotType,
            ),
            onTap: () {
              widget.onItemClick?.call(item.lotGrpName);
            }),
      ),
      onRefresh: () {
        return Future.delayed(const Duration(seconds: 1));
      },
    );
  }

  @override
  void requestApi(int pageNo,
      {Function(List<StoreOutLotListItem>? list)? onSuccess, Function(String errorMessage)? onError}) {
    var provider = StoreOutProvider.of(context, listen: false);
    provider.fetchStoreOutList(pageNo * pageSize, pageSize).then((value) {
      onSuccess?.call(value!);
    }, onError: (error) {
      onError?.call(error);
    });
  }

  @override
  bool get wantKeepAlive => true;
}
