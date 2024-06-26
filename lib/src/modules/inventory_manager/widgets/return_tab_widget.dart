import 'package:core_widgets/core_widgets.dart' as core;
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_trc/src/modules/inventory_manager/widgets/return_list_item_widget.dart';
import '../../../utils/paginate_list_abstract.dart';
import '../l10n.dart';
import '../models/return_part_response.dart';
import '../providers/return_page_provider.dart';
import '../screens/return_item_status_screen.dart';

class ReturnTabWidget extends StatefulWidget {
  const ReturnTabWidget({Key? key}) : super(key: key);

  @override
  State<ReturnTabWidget> createState() => _ReturnTabWidgetState();
}

class _ReturnTabWidgetState extends PaginatedListState<ReturnItemData, ReturnTabWidget> {
  _ReturnTabWidgetState() : super(pageSize: 10, initialScrollOffset: 10);

  final TextEditingController _searchController = TextEditingController();
  final core.TextInputDebounce _deBouncer = core.TextInputDebounce();

  // Timer? _deBouncer;

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var l10n = L10n(context);
    var provider = ReturnProvider.of(context);
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: core.Dimens.space_16, vertical: core.Dimens.space_8),
          child: core.CshTextFormField(
            controller: _searchController,
            maxLines: 1,
            maxLength: 50,
            isBorderAllowed: true,
            autofocus: false,
            hintText: l10n.searchBarcode,
            keyboardType: TextInputType.text,
            onChanged: (data) {
              _deBouncer.start(() {
                if (!core.Validator.isNullOrEmpty(data)) {
                  provider.barcode = data.trim();
                  resetAndRefreshScreen(pageNumber: 0);
                  provider.barcode = null;
                } else {
                  resetAndRefreshScreen(pageNumber: 0);
                }
              });
            },
            prefixIcon: core.CshIcon(
              FeatherIcons.search,
              iconColor: theme.primaryColor,
              iconSize: core.MobileIconSize.medium,
              padding: EdgeInsets.zero,
            ),
          ),
        ),
        Expanded(
          child: iterate(
            (item, index) {
              return ReturnListItemWidget(
                dataModel: item,
                onCardTap: () async {
                  if (item.prid != null) {
                    ReturnStatusScreenArguments arg = ReturnStatusScreenArguments(detailsModel: item);
                    await Navigator.pushNamed(context, ReturnStatusScreen.route, arguments: arg);
                    resetAndRefreshScreen(pageNumber: 0);
                  } else {
                    core.CshSnackBar.error(context: context, message: l10n.pridIsNotPresent);
                  }
                },
              );
            },
            separator: const SizedBox(height: core.Dimens.space_8),
            onNoDataFound: () {
              return Center(
                child: Text(
                  l10n.noDataFound,
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
  void dispose() {
    super.dispose();
    _deBouncer.stop();
  }

  @override
  void requestApi(int pageNo,
      {Function(List<ReturnItemData>? list)? onSuccess, Function(String errorMessage)? onError}) {
    var provider = ReturnProvider.of(context, listen: false);
    provider.fetchInventoryReturnPartList(pageNo++).then((value) {
      if (onSuccess != null) {
        onSuccess(value.listData?.listOfData);
      }
    }, onError: (error) {
      if (onError != null) {
        onError(error);
      }
    });
  }
}
