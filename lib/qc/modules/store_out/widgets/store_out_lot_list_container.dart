import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:provider/provider.dart';

import '../providers/store_out_provider.dart';
import '../screens/index.dart';
import 'index.dart';

class StoreOutLotListContainer extends StatelessWidget {
  final Function(String? lotName)? onItemClick;
  const StoreOutLotListContainer({super.key,this.onItemClick});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Selector<StoreOutProvider, bool>(
          builder: (BuildContext selectorContext, value, Widget? child) {
            var provider = StoreOutProvider.of(selectorContext, listen: false);
            return Visibility(
              visible: value,
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: Dimens.space_8, horizontal: Dimens.space_8),
                child: SearchBarWidget(
                  initialText: provider.searchQuery,
                  onQuery: (value) {
                    provider.setSearchQuery(value);
                  },
                ),
              ),
            );
          },
          selector: (
            BuildContext context,
            StoreOutProvider provider,
          ) {
            return provider.showSearchBox;
          },
        ),
        Expanded(
          child: Stack(
            children: [
              Positioned.fill(
                child:   StoreOutLotListWidget(onItemClick: onItemClick)
              ),
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
                          selector: (
                            BuildContext context,
                            StoreOutProvider provider,
                          ) {
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
    var provider = StoreOutProvider.of( context, listen: false);
    provider.showSearchBox = !provider.showSearchBox;
    if(isNotEmpty(provider.searchQuery)){
      provider.setSearchQuery("");
    }
  }

  void _openFilterScreen(BuildContext context) {
    StoreOutLotFilterScreen.navigate(context).then((value) {
      var provider = StoreOutProvider.of( context, listen: false);
      provider.lotTypeQuery = value;
    });
  }
}
