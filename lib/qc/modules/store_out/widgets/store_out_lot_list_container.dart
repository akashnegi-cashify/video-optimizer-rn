import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_trc/src/common/widgets/my_search_bar_widget.dart';
import 'package:provider/provider.dart';

import '../providers/store_out_provider.dart';
import '../screens/index.dart';
import 'index.dart';

class StoreOutLotListContainer extends StatelessWidget {
  final Function(String? lotName)? onItemClick;

  StoreOutLotListContainer({super.key, this.onItemClick});

  final GlobalKey<StoreOutLotListWidgetState> listKey = GlobalKey<StoreOutLotListWidgetState>();

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Selector<StoreOutProvider, bool>(
          builder: (BuildContext selectorContext, value, Widget? child) {
            if (!value) {
              return const SizedBox.shrink();
            }
            var provider = StoreOutProvider.of(selectorContext, listen: false);
            return Padding(
              padding: const EdgeInsets.fromLTRB(Dimens.space_16, Dimens.space_16, Dimens.space_16, 0),
              child: MySearchBarWidget(
                isAutoFocus: true,
                showBorder: false,
                onQuery: (query) {
                  provider.setSearchQuery(query);
                  listKey.currentState?.resetAndRefreshScreen();
                },
              ),
            );
          },
          selector: (_, StoreOutProvider provider) {
            return provider.showSearchBox;
          },
        ),
        Expanded(
          child: Stack(
            children: [
              Positioned.fill(child: StoreOutLotListWidget(onItemClick: onItemClick, key: listKey)),
              Positioned(
                  bottom: 0,
                  right: 0,
                  left: 0,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: Dimens.space_20, vertical: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        FloatingActionButton(
                          onPressed: () => _openFilterScreen(context),
                          backgroundColor: theme.primaryColor,
                          heroTag: 'filter',
                          child: CshIcon(
                            FeatherIcons.filter,
                            iconColor: theme.colorScheme.background,
                          ),
                        ),
                        Selector<StoreOutProvider, bool>(
                          builder: (BuildContext context, value, Widget? child) {
                            return FloatingActionButton(
                              onPressed: () => _showSearchBox(context),
                              backgroundColor: theme.primaryColor,
                              heroTag: 'searchQuery',
                              child: CshIcon(
                                value ? FeatherIcons.x : FeatherIcons.search,
                                iconColor: theme.colorScheme.background,
                              ),
                            );
                          },
                          selector: (_, StoreOutProvider provider) {
                            return provider.showSearchBox;
                          },
                        ),
                      ],
                    ),
                  ))
            ],
          ),
        ),
      ],
    );
  }

  void _showSearchBox(BuildContext context) {
    var provider = StoreOutProvider.of(context, listen: false);
    provider.showSearchBox = !provider.showSearchBox;
    if (isNotEmpty(provider.searchQuery)) {
      provider.setSearchQuery("");
      listKey.currentState?.resetAndRefreshScreen();
    }
  }

  void _openFilterScreen(BuildContext context) {
        var provider = StoreOutProvider.of(context, listen: false);
    StoreOutLotFilterScreen.navigate(context, selectedLotType: provider.selectedLotTypeList).then((value) {
      if (value != null && value is List<int>) {
        provider.selectedLotTypeList = value;
        listKey.currentState?.resetAndRefreshScreen();
      }
    });
  }
}
