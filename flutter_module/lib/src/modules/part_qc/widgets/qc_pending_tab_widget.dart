import 'package:components/components.dart';
import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/src/modules/part_qc/models/qc_parts_list_response.dart';
import 'package:flutter_trc/src/modules/part_qc/providers/pq_provider.dart';
import 'package:flutter_trc/src/modules/part_qc/widgets/qc_part_list_widget.dart';
import 'package:flutter_trc/src/services/service_groups.dart';

import '../l10n.dart';

class QcPendingTabWidget extends StatefulWidget {
  const QcPendingTabWidget({Key? key}) : super(key: key);

  @override
  State<QcPendingTabWidget> createState() => _QcPendingTabWidgetState();
}

class _QcPendingTabWidgetState extends State<QcPendingTabWidget> {
  final CshListController _listController = CshListController();

  FilterConfig _getFilterConfig() {
    return FilterConfig(filterData: [
      CshFilterData(
        label: "Search Part Barcode",
        field: 'pbr',
        crudFilter: 'pbr',
        filterType: CshFilterType.input,
        valueType: CshFilterValueType.contains,
        position: FilterPosition.top,
        keyboardType: TextInputType.text,
        filterGroup: FilterGroupType.multipleTypeSearch,
      ),
      CshFilterData(
        label: "Part Name",
        field: 'pn',
        crudFilter: 'pn',
        filterType: CshFilterType.input,
        valueType: CshFilterValueType.contains,
        position: FilterPosition.top,
        keyboardType: TextInputType.text,
        filterGroup: FilterGroupType.multipleTypeSearch,
      ),
      CshFilterData(
        label: "SKU",
        field: 'sku',
        crudFilter: 'sku',
        filterType: CshFilterType.input,
        valueType: CshFilterValueType.contains,
        position: FilterPosition.top,
        keyboardType: TextInputType.text,
        filterGroup: FilterGroupType.multipleTypeSearch,
      ),
      CshFilterData(
        label: "Status",
        field: 'st',
        crudFilter: 'st',
        filterType: CshFilterType.input,
        valueType: CshFilterValueType.contains,
        position: FilterPosition.bottom,
        keyboardType: TextInputType.text,
        filterGroup: FilterGroupType.multipleTypeSearch,
      ),
    ]);
  }

  void _refreshList() {
    _listController.refresh();
  }

  @override
  Widget build(BuildContext context) {
    var provider = PartQcProvider.of(context, listen: false);
    var theme = Theme.of(context);
    var l10n = L10n(context);
    
    return CshApiList<QcPartListData>(
      apiConfig: ListApiConfig(
        apiUrl: "/qc/parts/list",
        serviceGroup: TRCServiceGroups.unifyTrc,
              ),
      filterConfig: _getFilterConfig(),
      controller: _listController,
      itemFromJson: QcPartListData.fromJson,
      shimmerLoaderWidget: const CshShimmer(height: Dimens.space_60),
      listPadding: const EdgeInsets.all(Dimens.space_16),
      verticalRowSpacing: Dimens.space_8,
      isHideCoreFilterButton: false,
      getRowWidget: (item, index) {
        final data = item;
                      return QcPartListItemWidget(
          dataModel: data,
                        onCardClicked: (bool isFaulty) async {
            if (data?.prid != null) {
              _showUnlinkModal(context, theme, l10n, isFaulty, provider, data!);
                          } else {
                            CshSnackBar.error(context: context, message: l10n.noPridFound);
                          }
                        },
                      );
                    },
    );
  }

  _showUnlinkModal(
      BuildContext context, ThemeData theme, L10n l10n, bool isFaulty, PartQcProvider provider, QcPartListData item) {
    showCshBottomSheet(
      context: context,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: Dimens.space_12, horizontal: Dimens.space_16),
        child: Column(
          children: [
            Text(
              isFaulty
                  ? l10n.areYouSureYouWantToMarkPartAsFaulty(item.partBarcode ?? "part")
                  : l10n.areYouSureYouWantToMarkPartAsOk(item.partBarcode ?? "part"),
              style: theme.primaryTextTheme.displaySmall,
            ),
            const SizedBox(height: Dimens.space_16),
            ComboButton(
              firstBtnText: l10n.no,
              secondBtnText: l10n.yes,
              buttonType: ButtonType.mini,
              isFirstPrimary: true,
              firstBtnClick: () {
                Navigator.of(context).pop();
              },
              secondBtnClick: () {
                Navigator.of(context).pop();
                _updatePartStatus(context, isFaulty, l10n, provider, item.prid!);
              },
            )
          ],
        ),
      ),
    );
  }

  _updatePartStatus(BuildContext context, bool isFaulty, L10n l10n, PartQcProvider provider, int prid) {
    CshLoading().showLoading(context);
    provider.updatePartStatus(isFaulty, prid).then((value) {
      CshLoading().hideLoading(context);
      if (value) {
        _refreshList();
        CshSnackBar.success(context: context, message: l10n.statusUpdatedSuccessfully);
      }
    }, onError: (error) {
      CshLoading().hideLoading(context);
      CshSnackBar.error(context: context, message: error);
    });
  }

}
