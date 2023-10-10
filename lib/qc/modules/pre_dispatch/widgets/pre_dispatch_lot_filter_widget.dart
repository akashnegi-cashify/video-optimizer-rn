import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../l10n.dart';
import '../providers/pre_dispatch_filter_provider.dart';

class PreDispatchLotFilterWidget extends StatefulWidget {
  const PreDispatchLotFilterWidget({super.key});

  @override
  State<PreDispatchLotFilterWidget> createState() => _PreDispatchLotFilterWidgetState();
}

class _PreDispatchLotFilterWidgetState extends State<PreDispatchLotFilterWidget> {
  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var l10n = L10n(context);
    return ChangeNotifierProvider(
      create: (context) => PreDispatchFilterProvider(),
      child: Builder(builder: (builderContext) {
        return Padding(
          padding: const EdgeInsets.all(Dimens.space_8),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    CshTextNew(
                      l10n.selectLotTypeToDisplay,
                      textStyle: theme.textTheme.displaySmall?.copyWith(
                        color: theme.primaryColor,
                      ),
                    ),
                    const SizedBox(height: Dimens.space_12),
                    const Expanded(child: _FilterItemWidget()),
                  ],
                ),
              ),
              const SizedBox(height: Dimens.space_8),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                      child: CshBigButton(
                    text: l10n.clear,
                    onPressed: () => _onCancel(builderContext),
                  )),
                  const SizedBox(width: Dimens.space_8),
                  Expanded(
                      child: CshBigButton(
                    text: l10n.apply,
                    onPressed: () => _onApply(builderContext),
                  )),
                ],
              )
            ],
          ),
        );
      }),
    );
  }

  void _onCancel(BuildContext context) {
    var provider = PreDispatchFilterProvider.of(context: context, listen: false);
    provider.clearFilter();
  }

  void _onApply(BuildContext context) {
    var provider = PreDispatchFilterProvider.of(context: context, listen: false);
    var selectedItem = provider.getSelectedFilter();
    Navigator.pop(context, selectedItem);
  }
}

class _FilterItemWidget extends StatefulWidget {
  const _FilterItemWidget();

  @override
  State<_FilterItemWidget> createState() => _FilterItemWidgetState();
}

class _FilterItemWidgetState extends State<_FilterItemWidget> {
  @override
  Widget build(BuildContext context) {
    var provider = PreDispatchFilterProvider.of(context: context);
    var isLoading = provider.status == RequestStatus.initial;
    var list = provider.filters?.map((e) => RadioListItem(e?.lotType, e?.lotName, e?.isSelected ?? false)).toList();

    return isLoading
        ? ListView.separated(
            itemBuilder: (context, index) {
              return CshShimmer(show: isLoading, child: const ListTile());
            },
            separatorBuilder: (context, index) {
              return const SizedBox(height: Dimens.space_8);
            },
            itemCount: 20)
        : SingleChildScrollView(
            padding: const EdgeInsets.all(Dimens.space_6),
            child: RadioListWidget(
              list: list,
              isShowedInCard: true,
              onItemSelected: (item) {
                provider.updateFilterSelectionState(item.id);
              },
            ),
          );
  }
}
