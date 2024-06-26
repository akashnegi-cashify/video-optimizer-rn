import 'package:core_widgets/core_widgets.dart' as core;
import 'package:flutter/material.dart';
import 'package:flutter_trc/shipex/modules/packaging/providers/group_list_provider.dart';

import '../../../../src/utils/paginate_list_abstract.dart';
import '../l10n.dart';
import '../models/group_lot_list_repsonse.dart';
import '../packaging_process_screen.dart';
import 'group_list_data_card_widget.dart';

class NewOrderDataList extends StatefulWidget {
  const NewOrderDataList({super.key});

  @override
  State<NewOrderDataList> createState() => _NewOrderDataListState();
}

class _NewOrderDataListState extends PaginatedListState<GroupLotListData, NewOrderDataList> {
  _NewOrderDataListState() : super(initialScrollOffset: 10, pageSize: 10);

  String _query = "";

  @override
  Widget build(BuildContext context) {
    var l10n = L10n(context);
    var theme = Theme.of(context);

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
              return GroupListDataCardWidget(
                dataModel: item,
                onCardTap: () {
                  PackagingProcessScreenArguments args = PackagingProcessScreenArguments(dataModel: item);
                  Navigator.of(context).pushNamed(PackagingProcessScreen.route, arguments: args);
                },
              );
            },
            onRefresh: () async {},
            separator: const SizedBox(height: core.Dimens.space_12),
            onNoDataFound: () {
              return Center(
                child: Text(
                  l10n.noNewDataFound,
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
      {Function(List<GroupLotListData>? list)? onSuccess, Function(String errorMessage)? onError}) {
    var provider = GroupListProvider.of(context, listen: false);
    provider.fetchNewDataListData(++pageNo, query: _query).then((value) {
      if (onSuccess != null) {
        onSuccess(value.groupLotList);
      }
    }, onError: (error) {
      if (onError != null) {
        onError(error);
      }
    });
  }
}
