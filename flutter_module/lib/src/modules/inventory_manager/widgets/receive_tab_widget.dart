import 'package:components/components.dart';
import 'package:core/core.dart';
import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/src/common/utils/csh_ml_scanner_util.dart';
import 'package:flutter_trc/src/services/service_groups.dart';

import '../l10n.dart';
import '../models/list_receive_pending_part_response.dart';
import '../resources/inventory_manager_service.dart';

class ReceiveTabWidget extends StatefulWidget {
  const ReceiveTabWidget({Key? key}) : super(key: key);

  @override
  State<ReceiveTabWidget> createState() => _ReceiveTabWidgetState();
}

class _ReceiveTabWidgetState extends State<ReceiveTabWidget> {
  final CshListController _listController = CshListController();
  String? _scannedBarcode;

  FilterConfig _getFilterConfig() {
    return FilterConfig();
  }

  void _refreshList() {
    _listController.refresh();
  }

  void _openScanner(BuildContext context) {
    CshMlScannerUtil().openScanner(
      context,
      onScanned: (scannedData, controller) {
        if (!Validator.isNullOrEmpty(scannedData)) {
          Navigator.of(context).pop(); // dismiss the scanner
          setState(() {
            _scannedBarcode = scannedData.trim();
          });
          _refreshList();
        }
      },
    );
  }

  void _clearScan() {
    setState(() {
      _scannedBarcode = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    var l10n = L10n(context);
    var theme = Theme.of(context);

    // Show scanner button if no barcode scanned yet
    if (_scannedBarcode == null) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: Dimens.space_30),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: double.infinity,
                child: CshMediumButton(
                  text: l10n.scanPartBarcode,
                  onPressed: () => _openScanner(context),
                ),
              ),
            ],
          ),
        ),
      );
    }

    // Show list after barcode is scanned
    return Column(
      children: [
        // Scanned barcode header with rescan option
        Container(
          padding: const EdgeInsets.all(Dimens.space_12),
          color: theme.primaryColor.withOpacity(0.1),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Scanned Barcode:',
                      style: theme.textTheme.bodySmall?.copyWith(color: Colors.grey),
                    ),
                    Text(
                      _scannedBarcode!,
                      style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              IconButton(
                icon: const Icon(Icons.qr_code_scanner),
                onPressed: () => _openScanner(context),
                tooltip: 'Scan Again',
              ),
              IconButton(
                icon: const Icon(Icons.close),
                onPressed: _clearScan,
                tooltip: 'Clear',
              ),
            ],
          ),
        ),
        // List of pending parts for scanned barcode
        Expanded(
          child: CshApiList<ListResponsePendingDataResponse>(
            apiConfig: ListApiConfig(
              apiUrl: "/inventory/receive-pending-parts?pbr=$_scannedBarcode&",
              serviceGroup: TRCServiceGroups.unifyTrc,
            ),
            filterConfig: _getFilterConfig(),
            controller: _listController,
            itemFromJson: ListResponsePendingDataResponse.fromJson,
            shimmerLoaderWidget: const CshShimmer(height: Dimens.space_60),
            listPadding: const EdgeInsets.all(Dimens.space_16),
            verticalRowSpacing: Dimens.space_16,
            isHideCoreFilterButton: true,
            getRowWidget: (item, index) {
              final data = item;
              return _ReceivePendingPartCard(
                data: data,
                onTap: () {
                  if (data?.prid != null) {
                    _receivePartAction(context, data!.prid!, l10n);
                  }
                },
              );
            },
          ),
        ),
      ],
    );
  }

  void _receivePartAction(BuildContext context, int prid, L10n l10n) {
    CshLoading().showLoading(context);
    InventoryService.addItemIntoReceiveList(prid).listen(
      (event) {
        CshLoading().hideLoading(context);
        if (event != null) {
          CshSnackBar.success(context: context, message: "Part received successfully!");
          _refreshList();
        }
      },
      onError: (error) {
        CshLoading().hideLoading(context);
        String em = ApiErrorHelper.getErrorMessage(error) ?? "Something went wrong";
        CshSnackBar.error(context: context, message: em);
      },
    );
  }
}

class _ReceivePendingPartCard extends StatelessWidget {
  final ListResponsePendingDataResponse? data;
  final VoidCallback? onTap;

  const _ReceivePendingPartCard({
    Key? key,
    this.data,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);

    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(Dimens.space_12),
        decoration: BoxDecoration(
          color: theme.cardColor,
          borderRadius: BorderRadius.circular(Dimens.space_8),
          border: Border.all(color: theme.dividerColor),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    data?.partName ?? '-',
                    style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                if (data?.isUrgent == true)
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: Dimens.space_8, vertical: Dimens.space_4),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(Dimens.space_4),
                    ),
                    child: Text(
                      'URGENT',
                      style: theme.textTheme.labelSmall?.copyWith(color: Colors.white),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: Dimens.space_8),
            _buildInfoRow('Part Barcode', data?.partBarcode ?? '-'),
            _buildInfoRow('Device', data?.deviceName ?? '-'),
            _buildInfoRow('Device Barcode', data?.deviceBarcode ?? '-'),
            _buildInfoRow('SKU', data?.sku ?? '-'),
            _buildInfoRow('Status', data?.status ?? '-'),
            _buildInfoRow('Requested Qty', data?.requestedQty?.toString() ?? '-'),
            if (data?.isBulk == true) _buildInfoRow('Bulk', 'Yes'),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: Dimens.space_2),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120,
            child: Text(
              '$label:',
              style: const TextStyle(color: Colors.grey, fontSize: 12),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(fontSize: 12),
            ),
          ),
        ],
      ),
    );
  }
}
