import 'package:core_widgets/core_widgets.dart' as core;
import 'package:flutter/material.dart';

import '../../../utils/paginate_list_abstract.dart';
import '../l10n.dart';
import '../models/engineer_list_response.dart';
import '../providers/inventory_home_provider.dart';
import 'engineer_list_item_widget.dart';

class InventoryPendingDeliveryWidget extends StatefulWidget {
  const InventoryPendingDeliveryWidget({Key? key}) : super(key: key);

  @override
  State<InventoryPendingDeliveryWidget> createState() => InventoryPendingDeliveryWidgetState();
}

class InventoryPendingDeliveryWidgetState
    extends PaginatedListState<EngineerDataResponse, InventoryPendingDeliveryWidget> {
  InventoryPendingDeliveryWidgetState() : super(initialScrollOffset: 20, pageSize: 20);

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var l10n = L10n(context);
    return Column(
      children: [
        Expanded(
          child: iterate(
            (item, index) {
              return EngineerListItemWidget(index: index + 1, dataModel: item);
            },
            onRefresh: () async {},
            onNoDataFound: () {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(l10n.noDataFound, style: theme.primaryTextTheme.titleMedium),
                  const SizedBox(height: core.Dimens.space_12),
                  core.CshMediumButton(
                    text: l10n.refresh,
                    onPressed: () {
                      resetAndRefreshScreen();
                    },
                  )
                ],
              );
            },
            onError: (String error) {
              return Center(
                child: Row(
                  children: [
                    const SizedBox.shrink(),
                    Expanded(child: Text(error, style: theme.primaryTextTheme.displaySmall, textAlign: TextAlign.center))
                  ],
                ),
              );
            },
            separator: const SizedBox(height: core.Dimens.space_8),
            padding: const EdgeInsets.all(core.Dimens.space_16),
          ),
        ),
      ],
    );
  }

  @override
  void requestApi(int pageNo,
      {Function(List<EngineerDataResponse>? list)? onSuccess, Function(String errorMessage)? onError}) {
    var provider = InventoryHomeProvider.of(context, listen: false);
    provider.getAssignmentPendingEngineerList(pageNo++, pageSize).then((value) {
      if (onSuccess != null) {
        onSuccess(value?.data?.engineerDataList);
      }
    }, onError: (error) {
      if (onError != null) {
        onError(error);
      }
    });
  }
}
