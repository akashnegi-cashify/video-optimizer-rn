import 'package:core_widgets/core_widgets.dart' hide iterate;
import 'package:flutter/material.dart';
import 'package:flutter_trc/src/common/widgets/my_search_bar_widget.dart';
import 'package:flutter_trc/src/modules/trc_executive/models/tl_list_response.dart';
import 'package:flutter_trc/src/modules/trc_executive/providers/tl_list_provider.dart';
import 'package:flutter_trc/src/modules/trc_executive/screens/trc_executive_store_out_screen.dart';
import 'package:flutter_trc/src/utils/paginate_list_abstract.dart';

import '../l10n.dart';

class TlListWidget extends StatefulWidget {
  const TlListWidget({super.key});

  @override
  State<TlListWidget> createState() => _TlListWidgetState();
}

class _TlListWidgetState extends PaginatedListState<TlListData, TlListWidget> {
  @override
  Widget build(BuildContext context) {
    var provider = TlListProvider.of(context);
    var theme = Theme.of(context);
    var l10n = L10n(context);
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(Dimens.space_16, Dimens.space_16, Dimens.space_16, 0),
          child: MySearchBarWidget(
            hintText: l10n.searchByName,
            onQuery: (query) {
              provider.searchQuery = query;
              resetAndRefreshScreen();
            },
          ),
        ),
        Expanded(
          child: iterate(
            (item, index) {
              return InkWell(
                onTap: () {
                  TRCExecutiveStoreOutScreen.navigate(context, item);
                },
                child: CshCard(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CshTextNew.subTitle1(item.id ?? ""),
                      const SizedBox(height: Dimens.space_4),
                      CshTextNew.subTitle1(item.name ?? ""),
                    ],
                  ),
                ),
              );
            },
            onRefresh: () async {},
            separator: const SizedBox(height: Dimens.space_12),
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
            padding: const EdgeInsets.symmetric(horizontal: Dimens.space_16, vertical: Dimens.space_12),
          ),
        ),
      ],
    );
  }

  @override
  void requestApi(int pageNo, {Function(List<TlListData>? list)? onSuccess, Function(String errorMessage)? onError}) {
    var provider = TlListProvider.of(context, listen: false);
    provider.getTlList(pageNo, pageSize).then((value) {
      onSuccess?.call(value);
    }, onError: (error) {
      onError?.call(error);
    });
  }
}
