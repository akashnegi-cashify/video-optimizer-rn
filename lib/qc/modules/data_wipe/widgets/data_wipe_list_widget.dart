import 'package:core_widgets/core_widgets.dart' hide iterate;
import 'package:flutter/material.dart';
import 'package:flutter_trc/qc/modules/data_wipe/dialog/show_bulk_erase_initiate_dialog.dart';
import 'package:flutter_trc/qc/modules/data_wipe/dialog/show_filter_dialog.dart';
import 'package:flutter_trc/qc/modules/data_wipe/providers/data_wipe_list_provider.dart';
import 'package:flutter_trc/qc/modules/data_wipe/resources/data_wipe_filter_list_response.dart';
import 'package:flutter_trc/qc/modules/data_wipe/resources/data_wipe_list_response.dart';
import 'package:flutter_trc/qc/modules/data_wipe/widgets/data_wipe_card_widget.dart';
import 'package:flutter_trc/src/utils/paginate_list_abstract.dart';

class DataWipeListWidget extends StatefulWidget {
  const DataWipeListWidget({super.key});

  @override
  State<DataWipeListWidget> createState() => _DataWipeListWidgetState();
}

class _DataWipeListWidgetState extends PaginatedListState<DataWipeListItem, DataWipeListWidget> {
  @override
  Widget build(BuildContext context) {
    var provider = DataWipeListProvider.of(context, listen: false);
    return Column(
      children: [
        Expanded(
          child: iterate(
            (item, index) {
              return DataWipeCardWidget(
                item.qrCode,
                item.erasureProvider.toString(),
                item.productName,
                item.status,
                item.statusCode,
              );
            },
            separator: const SizedBox(height: Dimens.space_16),
            padding: const EdgeInsets.all(Dimens.space_16),
          ),
        ),
        ComboButton(
          firstBtnText: "Filters",
          secondBtnText: "Initiate Bulk",
          secondBtnClick: () {
            _onBulkEraseClicked(provider);
          },
          firstBtnClick: () {
            _onFilterClicked(provider);
          },
        )
      ],
    );
  }

  @override
  void requestApi(int pageNo,
      {Function(List<DataWipeListItem>? list)? onSuccess, Function(String errorMessage)? onError}) {
    var provider = DataWipeListProvider.of(context, listen: false);
    provider.getDataList(pageNo * pageSize, pageSize).then((value) {
      onSuccess?.call(value);
    }, onError: (error) {
      onError?.call(error);
    });
  }

  void _onFilterClicked(DataWipeListProvider provider) {
    showFilterDialog(
      context,
      selectedFilter: provider.selectedFilter,
      onFilterApplied: (selectedFilter) {
        Navigator.pop(context); // Close the dialog
        provider.saveSelectedFilters(selectedFilter);
        resetAndRefreshScreen();
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
    showErrorDialog(context, "Initiate Bulk Erase on ${status.label} status", "Are you sure?", "Proceed", (_) {
      Navigator.pop(context);
      var provider = DataWipeListProvider.of(context, listen: false);
      provider.initiateBulkErase(status.id);
    });
  }
}
