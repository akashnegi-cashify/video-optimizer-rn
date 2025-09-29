import 'package:core_widgets/core_widgets.dart' hide iterate;
import 'package:flutter/material.dart';

import '../../../../src/utils/paginate_list_abstract.dart';
import '../l10n.dart';
import '../providers/store_out_provider.dart';
import '../resources/index.dart';
import 'index.dart';

class StoreOutLotListWidget extends StatefulWidget {
  const StoreOutLotListWidget({
    super.key,
    this.onItemClick,
  });

  final Function(String? lotName, int? lotId)? onItemClick;

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
      (item, index) => cshGestureDetector(
          child: ListItemWidget(
            l10n.groupName,
            lotValue: item.lotGrpName,
            noOfDevices: "${item.deviceCount ?? 0}",
            lotType: item.lotType,
            isInProcess: item.isStoreOutInProcess ?? false,
          ),
          onTap: () {
            widget.onItemClick?.call(item.lotGrpName, item.lotId);
          }),
      padding: const EdgeInsets.only(left: Dimens.space_16, right: Dimens.space_16, bottom: Dimens.space_16),
      separator: const SizedBox(height: Dimens.space_12),
      onRefresh: () {
        return Future.delayed(const Duration(milliseconds: 500));
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
