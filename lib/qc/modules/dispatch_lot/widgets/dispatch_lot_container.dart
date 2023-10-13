import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:provider/provider.dart';

import '../providers/dispatch_lot_provider.dart';
import '../screens/index.dart';
import 'index.dart';

class DispatchLotContainer extends StatelessWidget {
  const DispatchLotContainer({super.key});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Selector<DispatchLotProvider, bool>(
          builder: (BuildContext selectorContext, value, Widget? child) {
            var provider = DispatchLotProvider.of(context: selectorContext, listen: false);
            if (value) {
              return Container(
                padding: const EdgeInsets.all(Dimens.space_16),
                child: SearchBarWidget(
                  initialText: provider.searchQuery,
                  onQuery: (value) {
                    provider.searchQuery = value;
                  },
                ),
              );
            } else {
              return const SizedBox.shrink();
            }
          },
          selector: (
            BuildContext context,
            DispatchLotProvider provider,
          ) {
            return provider.showSearchBox;
          },
        ),
        Expanded(
          child: Stack(
            children: [
              Positioned.fill(
                child: Selector<DispatchLotProvider, String>(
                  builder: (BuildContext context, value, Widget? child) {
                    return DispatchLotsWidget(key: ObjectKey(value));
                  },
                  selector: (
                    BuildContext context,
                    DispatchLotProvider provider,
                  ) {
                    return provider.searchQuery ?? '';
                  },
                ),
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
                        Selector<DispatchLotProvider, bool>(
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
                            DispatchLotProvider provider,
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
    var provider = DispatchLotProvider.of(context: context, listen: false);
    provider.showSearchBox = !provider.showSearchBox;
  }

  void _openFilterScreen(BuildContext context) {
    DispatchLotFilterScreen.navigate(context).then((value) {
      var provider = DispatchLotProvider.of(context: context, listen: false);
      provider.channelQuery = value;
    });
  }
}
