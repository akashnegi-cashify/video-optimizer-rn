import 'dart:async';

import 'package:core_widgets/core_widgets.dart' as core;
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
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
  final TextEditingController _searchController = TextEditingController();
  bool _isSearchActive = false;
  Timer? _timer;
  String _query = "";

  @override
  void initState() {
    _searchController.addListener(() {
      if (_searchController.text.isEmpty) {
        _isSearchActive = false;
      } else {
        _isSearchActive = true;
      }
      setState(() {});
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var l10n = L10n(context);
    var theme = Theme.of(context);

    return Column(
      children: [
        const SizedBox(height: core.Dimens.space_12),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: core.Dimens.space_16),
          child: core.CshTextFormField(
            controller: _searchController,
            maxLines: 1,
            maxLength: 50,
            keyboardType: TextInputType.name,
            hintText: l10n.name,
            onChanged: (data) {
              if (_timer?.isActive ?? false) _timer?.cancel();
              _timer = Timer(
                const Duration(milliseconds: 400),
                () {
                  if (!core.Validator.isNullOrEmpty(data)) {
                    _query = data.trim();
                    resetAndRefreshScreen(pageNumber: 1);
                  } else {
                    _query = "";
                    resetAndRefreshScreen(pageNumber: 1);
                  }
                },
              );
            },
            prefixIcon: core.CshIcon(
              FeatherIcons.search,
              padding: EdgeInsets.zero,
              iconSize: core.MobileIconSize.medium,
              iconColor: theme.primaryColor,
            ),
            suffixIcon: core.Validator.isTrue(_isSearchActive)
                ? core.CshIcon(
                    FeatherIcons.xCircle,
                    padding: EdgeInsets.zero,
                    iconSize: core.MobileIconSize.medium,
                    iconColor: theme.shadowColor,
                    onClick: () {
                      _isSearchActive = false;
                      _searchController.clear();
                      setState(() {});
                    },
                  )
                : null,
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
      {Function(List<GroupLotListData>? list)? onSuccess, Function(String errorMessage)? onError}) {
    var provider = GroupListProvider.of(context, listen: false);
    provider.fetchNewDataListData(pageNo++, query: _query).then((value) {
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
