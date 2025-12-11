import 'package:components/components.dart';
import 'package:core_widgets/core_widgets.dart' hide iterate;
import 'package:flutter/material.dart';
import 'package:flutter_trc/src/common/widgets/search_with_dropdown_widget.dart';
import 'package:flutter_trc/src/services/service_groups.dart';
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

class _PreDispatchLotsWidgetState extends State<PreDispatchLotsWidget> {
  final CshListController _listController = CshListController();
  @override
  void initState() {
    super.initState();
    var provider = PreDispatchLotProvider.of(context: context, listen: false);
    provider.controller.stream.listen((event) {
      if (mounted) {
        _listController.refresh();
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
            _listController.refresh();
          },
        ),
        Expanded(
          child: CshApiList<PreDispatchLotInfo>(
            apiConfig:
                ListApiConfig(apiUrl: "/lot-pre-dispatch/list?", serviceGroup: TRCServiceGroups.qc),
            controller: _listController,
            shimmerLoaderWidget: const CshShimmer(height: Dimens.space_60),
            listPadding: const EdgeInsets.all(Dimens.space_16),
            verticalRowSpacing: Dimens.space_16,
            itemFromJson: PreDispatchLotInfo.fromJson,
            getRowWidget: (item, index) {
              return PreDispatchLotWidget(
                lot: item!,
                index: index,
                onItemClick: () => _onItemClick(context, lot: item, l10n: l10n),
              );
            },
          ),
        ),
      ],
    );
  }

  void _onItemClick(BuildContext context, {required PreDispatchLotInfo lot, required L10n l10n}) {
    if ((lot.scanPending ?? 0) != 0) {
      PreDispatchScreen.navigate(context, lot.lotGroupName, _allScanDoneCallback);
    } else {
      if (isNotEmpty(lot.lotGroupName)) {
        var provider = PreDispatchLotProvider.of(context: context, listen: false);
        CshLoading().showLoading(context);
        provider.completePreDispatchLot(lot.lotGroupName!).then((value) {
          CshLoading().hideLoading(context);
          if (value?.isValid() == true) {
            CshSnackBar.success(context: context, message: value?.message ?? 'Success');
            _listController.refresh();
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
    _listController.refresh();
  }

  void _setSearchFilterAndReset(SearchType type, String value) {
    var provider = PreDispatchLotProvider.of(context: context, listen: false);
    if (type == LotSearchType.lotName) {
      provider.lotName = value;
    } else {
      provider.barcode = value;
    }
    _listController.refresh();
  }
}
