import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/src/common/widgets/my_search_bar_widget.dart';
import 'package:provider/provider.dart';

import '../l10n.dart';
import '../providers/index.dart';

class StoreOutLotFilterWidget extends StatefulWidget {
  const StoreOutLotFilterWidget({super.key});

  @override
  State<StoreOutLotFilterWidget> createState() => _StoreOutLotFilterWidgetState();
}

class _StoreOutLotFilterWidgetState extends State<StoreOutLotFilterWidget> {
  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var l10n = L10n(context);
    return ChangeNotifierProvider(
      create: (context) => StoreOutLotFilterProvider(),
      child: Builder(builder: (builderContext) {
        var provider = StoreOutLotFilterProvider.of(context: builderContext);
        return Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(Dimens.space_16, Dimens.space_16, Dimens.space_16, 0),
              child: MySearchBarWidget(
                  hintText: "Search Lot Type",
                  showBorder: false,
                  onQuery: (query) {
                    provider.searchQuery = query;
                  }),
            ),
            const Expanded(child: _FilterItemWidget()),
            const SizedBox(height: Dimens.space_8),
            ComboButton(
                firstBtnText: l10n.clear,
                secondBtnText: l10n.apply,
                isFirstPrimary: true,
                firstBtnClick: () => _onCancel(builderContext),
                secondBtnClick: provider.isAnyItemSelected() ? () => _onApply(builderContext) : null),
          ],
        );
      }),
    );
  }

  void _onCancel(BuildContext context) {
    var provider = StoreOutLotFilterProvider.of(context: context, listen: false);
    provider.clearFilter();
  }

  void _onApply(BuildContext context) {
    var provider = StoreOutLotFilterProvider.of(context: context, listen: false);
    var selectedItem = provider.getSelectedFilter();
    Navigator.pop(context, selectedItem);
  }
}

class _FilterItemWidget extends StatelessWidget {
  const _FilterItemWidget();

  @override
  Widget build(BuildContext context) {
    var provider = StoreOutLotFilterProvider.of(context: context);
    var isLoading = provider.status == RequestStatus.initial;

    return isLoading
        ? ListView.separated(
            itemBuilder: (context, index) {
              return CshShimmer(show: isLoading, child: const ListTile());
            },
            separatorBuilder: (context, index) {
              return const SizedBox(height: Dimens.space_8);
            },
            itemCount: 20)
        : ListView.separated(
            padding: const EdgeInsets.all(Dimens.space_16),
            itemBuilder: (context, index) {
              var item = provider.filters?[index];
              return GestureDetector(
                onTap: () {
                  provider.updateFilterSelectionState(item?.lotType);
                },
                child: CshCard(
                  child: CshCheckbox(
                    title: CshTextNew.bodyText1(item?.lotName ?? ""),
                    onChanged: (value) {
                      provider.updateFilterSelectionState(item?.lotType);
                    },
                    isSelected: item?.isSelected ?? false,
                  ),
                ),
              );
            },
            separatorBuilder: (context, index) {
              return const SizedBox(height: Dimens.space_16);
            },
            itemCount: provider.filters?.length ?? 0);
  }
}
