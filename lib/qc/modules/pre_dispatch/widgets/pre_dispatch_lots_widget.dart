import 'package:core_widgets/core_widgets.dart' hide iterate;
import 'package:flutter/material.dart';
import 'package:flutter_trc/src/common/widgets/search_with_dropdown_widget.dart';

import '../../../../src/utils/paginate_list_abstract.dart';
import '../l10n.dart';
import '../providers/pre_dispatch_lot_provider.dart';
import '../resources/index.dart';
import '../screens/index.dart';
import 'index.dart';

class PreDispatchLotsWidget extends StatefulWidget {
  const PreDispatchLotsWidget({super.key});

  @override
  State<PreDispatchLotsWidget> createState() => _PreDispatchLotsWidgetState();
}

class _PreDispatchLotsWidgetState extends PaginatedListState<PreDispatchLotInfo, PreDispatchLotsWidget> {
  @override
  void initState() {
    super.initState();
    var provider = PreDispatchLotProvider.of(context: context, listen: false);
    provider.controller.stream.listen((event) {
      if (mounted) {
        resetAndRefreshScreen();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var l10n = L10n(context);
    return Column(
      children: [
        SearchWithDropdownWidget(
          padding: const EdgeInsets.fromLTRB(Dimens.space_16, Dimens.space_16, Dimens.space_16, 0),
          searchTypeValues: LotSearchType.values,
          onSearch: (type, value) {
            _setSearchFilterAndReset(type, value);
          },
          onDropDownChange: (item) {
            var provider = PreDispatchLotProvider.of(context: context, listen: false);
            provider.resetSearchFilters();
            resetAndRefreshScreen();
          },
        ),
        Expanded(
          child: iterate(
            (item, index) => PreDispatchLotWidget(
              lot: item,
              index: index,
              onItemClick: () => _onItemClick(context, index: index, l10n: l10n),
            ),
            onNoDataFound: () => Padding(
              padding: const EdgeInsets.only(top: Dimens.space_16),
              child: CshTextNew.subTitle1(l10n.noLotFound),
            ),
          ),
        ),
      ],
    );
  }

  @override
  void requestApi(int pageNo,
      {Function(List<PreDispatchLotInfo>? list)? onSuccess, Function(String errorMessage)? onError}) {
    var provider = PreDispatchLotProvider.of(context: context, listen: false);

    provider.getDataStream(pageNo, pageSize).listen(
      (value) {
        if (onSuccess != null) {
          onSuccess(ArrayUtil.removeNullItems(value?.lots ?? []));
        }
      },
      onError: (error) {
        if (onError != null) {
          onError(error);
        }
      },
    );
  }

  void _onItemClick(BuildContext context, {required int index, required L10n l10n}) {
    if (items[index].pendingQty != 0) {
      PreDispatchScreen.navigate(context, items[index].lotGroupName, _allScanDoneCallback);
    } else {
      if (isNotEmpty(items[index].lotGroupName)) {
        var provider = PreDispatchLotProvider.of(context: context, listen: false);
        CshLoading().showLoading(context);
        provider.completePreDispatchLot(items[index].lotGroupName!).then((value) {
          CshLoading().hideLoading(context);
          if (value?.isValid() == true) {
            CshSnackBar.success(context: context, message: value?.message ?? 'Success');
            resetAndRefreshScreen();
          } else {
            CshSnackBar.error(context: context, message: value?.errorMessage ?? 'Something Went Wrong.');
          }
        }, onError: (error) {
          CshLoading().hideLoading(context);
          CshSnackBar.error(context: context, message: error ?? 'Something Went Wrong.');
        });
      }
    }
  }

  void _allScanDoneCallback() {
    var provider = PreDispatchLotProvider.of(context: context, listen: false);
    Navigator.popUntil(context, ModalRoute.withName(PreDispatchLotScreen.route));
    provider.lotTypeQuery = null;
    provider.resetSearchFilters();
    resetAndRefreshScreen();
  }

  void _setSearchFilterAndReset(SearchType type, String value) {
    var provider = PreDispatchLotProvider.of(context: context, listen: false);
    if (type == LotSearchType.lotName) {
      provider.lotName = value;
    } else {
      provider.barcode = value;
    }
    resetAndRefreshScreen();
  }
}
