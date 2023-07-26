import 'dart:async';

import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_trc/shipex/modules/packaging/providers/group_list_provider.dart';

import '../l10n.dart';
import '../packaging_process_screen.dart';
import 'group_list_data_card_widget.dart';

class PendingOrderDataList extends StatefulWidget {
  const PendingOrderDataList({super.key});

  @override
  State<PendingOrderDataList> createState() => _PendingOrderDataListState();
}

class _PendingOrderDataListState extends State<PendingOrderDataList> {
  final TextEditingController _searchController = TextEditingController();
  bool _isSearchActive = false;
  Timer? _timer;

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
    scheduleMicrotask(() {
      if (mounted) {
        var provider = GroupListProvider.of(context, listen: false);
        provider.fetchPendingDataList();
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var provider = GroupListProvider.of(context);
    var theme = Theme.of(context);
    var l10n = L10n(context);
    if (Validator.isTrue(provider.pendingDataLoading)) {
      return const Center(
        child: SizedBox(
          height: Dimens.space_30,
          width: Dimens.space_30,
          child: CircularProgressIndicator(),
        ),
      );
    } else if (!Validator.isNullOrEmpty(provider.pendingErrorListMessage)) {
      return Center(
        child: Row(
          children: [
            const SizedBox.shrink(),
            Expanded(
              child: Text(
                provider.pendingErrorListMessage!,
                style: theme.primaryTextTheme.headlineMedium,
                textAlign: TextAlign.center,
              ),
            )
          ],
        ),
      );
    } else {
      if (Validator.isListNullOrEmpty(provider.groupDataPendingList)) {
        return Center(
          child: Row(
            children: [
              const SizedBox.shrink(),
              Expanded(
                child: Text(
                  l10n.noPendingListDataFound,
                  style: theme.primaryTextTheme.headlineMedium,
                  textAlign: TextAlign.center,
                ),
              )
            ],
          ),
        );
      } else {
        return Column(
          children: [
            const SizedBox(height: Dimens.space_12),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: Dimens.space_16),
              child: CshTextFormField(
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
                      if (!Validator.isNullOrEmpty(data)) {
                        provider.fetchLocalSearchResultsInPending(data.trim().toLowerCase());
                      }
                    },
                  );
                },
                prefixIcon: CshIcon(
                  FeatherIcons.search,
                  padding: EdgeInsets.zero,
                  iconSize: MobileIconSize.medium,
                  iconColor: theme.primaryColor,
                ),
                suffixIcon: Validator.isTrue(_isSearchActive)
                    ? CshIcon(
                        FeatherIcons.xCircle,
                        padding: EdgeInsets.zero,
                        iconSize: MobileIconSize.medium,
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
            (Validator.isTrue(_isSearchActive))
                ? (!Validator.isListNullOrEmpty(provider.localSearchResultsData))
                    ? Expanded(
                        child: ListView.separated(
                          padding: const EdgeInsets.symmetric(vertical: Dimens.space_12, horizontal: Dimens.space_16),
                          itemBuilder: (context, index) {
                            return GroupListDataCardWidget(
                              dataModel: provider.localSearchResultsData[index],
                              onCardTap: () {
                                PackagingProcessScreenArguments args = PackagingProcessScreenArguments(
                                    dataModel: provider.localSearchResultsData[index], isPendingGroupLot: true);
                                Navigator.of(context).pushNamed(PackagingProcessScreen.route, arguments: args);
                              },
                            );
                          },
                          separatorBuilder: (context, index) {
                            return const SizedBox(height: Dimens.space_12);
                          },
                          itemCount: provider.localSearchResultsData.length,
                        ),
                      )
                    : Center(
                        child: Text(
                          "No Data Found",
                          style: theme.primaryTextTheme.headlineMedium,
                        ),
                      )
                : Expanded(
                    child: ListView.separated(
                      padding: const EdgeInsets.symmetric(vertical: Dimens.space_12, horizontal: Dimens.space_16),
                      itemBuilder: (context, index) {
                        return GroupListDataCardWidget(
                          dataModel: provider.groupDataPendingList![index],
                          onCardTap: () {
                            PackagingProcessScreenArguments args = PackagingProcessScreenArguments(
                                dataModel: provider.groupDataPendingList![index], isPendingGroupLot: true);
                            Navigator.of(context).pushNamed(PackagingProcessScreen.route, arguments: args);
                          },
                        );
                      },
                      separatorBuilder: (context, index) {
                        return const SizedBox(height: Dimens.space_12);
                      },
                      itemCount: provider.groupDataPendingList!.length,
                    ),
                  )
          ],
        );
      }
    }
  }
}
