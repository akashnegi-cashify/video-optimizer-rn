import 'package:components/components.dart';
import 'package:core_widgets/core_widgets.dart' hide iterate;
import 'package:flutter/material.dart';
import 'package:flutter_trc/qc/modules/data_wipe/dialog/show_bulk_erase_initiate_dialog.dart';
import 'package:flutter_trc/qc/modules/data_wipe/dialog/show_filter_dialog.dart';
import 'package:flutter_trc/qc/modules/data_wipe/providers/data_wipe_list_provider.dart';
import 'package:flutter_trc/qc/modules/data_wipe/resources/data_wipe_filter_list_response.dart';
import 'package:flutter_trc/qc/modules/data_wipe/resources/data_wipe_list_response.dart';
import 'package:flutter_trc/qc/modules/data_wipe/resources/data_wipe_service.dart';
import 'package:flutter_trc/qc/modules/data_wipe/screens/data_wipe_detail_screen.dart';
import 'package:flutter_trc/qc/modules/data_wipe/widgets/data_wipe_card_widget.dart';
import 'package:flutter_trc/src/services/service_groups.dart';

import '../l10n.dart';

class DataWipeListWidget extends StatefulWidget {
  const DataWipeListWidget({super.key});

  @override
  State<DataWipeListWidget> createState() => _DataWipeListWidgetState();
}

class _DataWipeListWidgetState extends State<DataWipeListWidget> {
  final CshListController _listController = CshListController();
  @override
  Widget build(BuildContext context) {
    var provider = DataWipeListProvider.of(context, listen: false);
    var l10n = L10n(context);
    return Column(
      children: [
        Expanded(
          child: CshApiList<DataWipeListItem>(
            apiConfig: ListApiConfig(
              apiUrl: "/v1/data-erasure/list",
              serviceGroup: TRCServiceGroups.qcErazer,
              headers: {
                "X-User-Auth": "${AuthHandler().userAuth}" ,
                'X-SSO-TOKEN' : 'false'           
              }
            ),
          filterConfig: FilterConfig(filterData: [
          CshFilterData(
            label: "Search QR Code",
            field: 'qrCode',
            crudFilter: 'stock.qrCode',
            filterType: CshFilterType.input,
            valueType: CshFilterValueType.contains,
            position: FilterPosition.top,
            keyboardType: TextInputType.text,
            filterGroup: FilterGroupType.multipleTypeSearch,
          ),
          CshFilterData(
            label: "Status Code",
            field: 'sc',
            crudFilter: 'status',
            filterType: CshFilterType.select,
            valueType: CshFilterValueType.equality,
            position: FilterPosition.bottom,
            filterGroup: FilterGroupType.multipleTypeSearch,
            lookUpsObs: (paginationInfo) {
              return DataWipeService.getDataWipeListFilters().map((event) {
                final list = event.dataWipeFilterMap?["status"]?.filterList ?? [];
                return list
                    .where((e) => e.id != null && e.label != null)
                    .map((e) => CshLooksUpData(label: e.label!, value: e.id!.toString()))
                    .toList();
              });
            },
            enableFilterPagination: false,
          ),
          CshFilterData(
            label: "Erasure Provider",
            field: 'ep',
            crudFilter: 'provider',
            filterType: CshFilterType.select,
            valueType: CshFilterValueType.equality,
            position: FilterPosition.bottom,
            filterGroup: FilterGroupType.multipleTypeSearch,
            lookUpsObs: (paginationInfo) {
              return DataWipeService.getDataWipeListFilters().map((event) {
                final list = event.dataWipeFilterMap?["erasureProviderCode"]?.filterList ?? [];
                return list
                    .where((e) => e.id != null && e.label != null)
                    .map((e) => CshLooksUpData(label: e.label!, value: e.id!.toString()))
                    .toList();
              });
            },
            enableFilterPagination: false,
          ),
        ]),
            controller: _listController,
            itemFromJson: DataWipeListItem.fromJson,
            // pageSize: 20,
            shimmerLoaderWidget: const CshShimmer(height: Dimens.space_60),
            listPadding: const EdgeInsets.all(Dimens.space_16),
            verticalRowSpacing: Dimens.space_16,
            getRowWidget: (item, index) {
              final data = item;
              return InkWell(
                onTap: () {
                  if (data?.qrCode != null) {
                    DataWipeDetailScreen.navigateTo(context, data!.qrCode!);
                  }
                },
                child: DataWipeCardWidget(
                  data?.qrCode,
                  data?.erasureProvider.toString(),
                  data?.productName,
                  data?.status,
                  data?.statusCode,
                  data?.errorMessage,
                ),
              );
            },
          ),
        ),
        CshBigButton(
          text: l10n.initiateBulk,
          onPressed: provider.forceHideBulkErase
              ? null
              : () {
                  _onBulkEraseClicked(provider);
                },
        )
      ],
    );
  }

  void _onFilterClicked(DataWipeListProvider provider) {
    showFilterDialog(
      context,
      selectedFilter: provider.selectedFilter,
      onFilterApplied: (selectedFilter) {
        Navigator.pop(context); // Close the dialog
        provider.saveSelectedFilters(selectedFilter);
        _listController.refresh();
      },
    );
  }

  void _onBulkEraseClicked(DataWipeListProvider provider) {
    showBulkEraseInitiateDialog(context, provider.bulkEraseStatusAllowed!, onProceed: (status) {
      Navigator.pop(context); // Close the dialog
      _showConfirmationDialog(status);
    });
  }

  _showConfirmationDialog(DataWipFilterListItem status) {
    var l10n = L10n(context, listen: false);
    showErrorDialog(context, l10n.erasedDesc(status.label!), l10n.sreYouSure, l10n.proceed, (_) {
      Navigator.pop(context);
      var provider = DataWipeListProvider.of(context, listen: false);
      CshLoading().showLoading(context);
      provider.initiateBulkErase(status.id!).then((value) {
        CshLoading().hideLoading(context);
        CshSnackBar.success(context: context, message: value);
        _listController.refresh();
      }, onError: (error) {
        CshLoading().hideLoading(context);
        CshSnackBar.error(context: context, message: error.toString());
      });
    });
  }
}
