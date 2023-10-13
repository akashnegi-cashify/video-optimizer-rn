import 'package:core_widgets/core_widgets.dart' as core;
import 'package:flutter/material.dart';

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
      resetAndRefreshScreen();
    });
  }

  @override
  Widget build(BuildContext context) {
    var l10n = L10n(context);
    return iterate((item, index) => PreDispatchLotWidget(
          lot: item,
          index: index,
          onItemClick: () => _onItemClick(context, index: index, l10n: l10n),
        ));
  }

  @override
  void requestApi(int pageNo,
      {Function(List<PreDispatchLotInfo>? list)? onSuccess, Function(String errorMessage)? onError}) {
    var provider = PreDispatchLotProvider.of(context: context, listen: false);
    FilterMap? filterMap;
    PreDispatchLotRequest request = PreDispatchLotRequest()
      ..pageNo = pageNo * pageSize
      ..pageSize = pageSize;

    if (core.isNotEmpty(provider.searchQuery)) {
      filterMap = FilterMap(searchQuery: provider.searchQuery);
    }

    if (core.isNotEmpty(provider.lotTypeQuery)) {

      filterMap = filterMap ?? FilterMap();
      filterMap.lotType = provider.lotTypeQuery;
    }

    request.filterMap = filterMap;

    provider.getDataStream(request).listen(
      (value) {
        if (onSuccess != null) {
          onSuccess(core.ArrayUtil.removeNullItems(value?.lots ?? []));
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

    if(items[index].pendingQty != 0){
      PreDispatchScreen.navigate(context,items[index].lotGroupName,_allScanDoneCallback);
    }
    else{
      if(core.isNotEmpty(items[index].lotGroupName)){
        var provider = PreDispatchLotProvider.of(context: context, listen: false);
        core.CshLoading().showLoading(context);
        provider.completePreDispatchLot(items[index].lotGroupName!).then((value) {
          core. CshLoading().hideLoading(context);
          if (value?.isValid() == true) {
            core. CshSnackBar.success(context: context, message: value?.message ?? 'Success');
            resetAndRefreshScreen();
          } else {
            core. CshSnackBar.error(context: context, message: value?.errorMessage ?? 'Something Went Wrong.');
          }
        }, onError: (error) {
          core. CshLoading().hideLoading(context);
          core. CshSnackBar.error(context: context, message: error ?? 'Something Went Wrong.');
        });

      }
    }

  }


  void _allScanDoneCallback(){
    var provider = PreDispatchLotProvider.of(context: context, listen: false);
    Navigator.popUntil(context, ModalRoute.withName(PreDispatchLotScreen.route));
    provider.lotTypeQuery =provider.searchQuery= null;
    resetAndRefreshScreen();
  }
}
