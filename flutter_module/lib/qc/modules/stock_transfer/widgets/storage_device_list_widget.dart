import 'package:core_widgets/core_widgets.dart' hide iterate;
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_trc/qc/modules/stock_transfer/providers/storage_device_list_provider.dart';
import 'package:flutter_trc/qc/modules/stock_transfer/resources/transfer_lot_device_list_response.dart';
import 'package:flutter_trc/src/common/utils/csh_ml_scanner_util.dart';
import 'package:flutter_trc/src/utils/paginate_list_abstract.dart';

import '../l10n.dart';

class StorageDeviceListWidget extends StatefulWidget {
  const StorageDeviceListWidget({super.key});

  @override
  State<StorageDeviceListWidget> createState() => _StorageDeviceListWidgetState();
}

class _StorageDeviceListWidgetState
    extends PaginatedListState<TransferLotDetailListData, StorageDeviceListWidget> {
  final _barcodeController = TextEditingController();

  final _debounce = TextInputDebounce();

  @override
  Widget build(BuildContext context) {
    var provider = StorageDeviceListProvider.of(context, listen: false);
    var theme = Theme.of(context);
    var l10n = L10n(context);
    return Column(
      children: [
        const SizedBox(height: Dimens.space_12),
        Padding(
          padding: const EdgeInsets.fromLTRB(Dimens.space_16, Dimens.space_16, Dimens.space_16, 0),
          child: CshTextFormField(
            hintText: l10n.searchBarcode,
            hintStyle: theme.textTheme.labelSmall,
            controller: _barcodeController,
            onChanged: (_) {
              _debounce.start(() {
                provider.searchQuery = _barcodeController.text;
                resetAndRefreshScreen();
              });
            },
            suffixIcon: InkWell(
              child: const Icon(Icons.qr_code_2),
              onTap: () {
                CshMlScannerUtil().openScanner(context, onScanned: (scannedData, controller) {
                  Navigator.pop(context); // close scanner
                  _barcodeController.text = scannedData;
                  provider.searchQuery = _barcodeController.text;
                  resetAndRefreshScreen();
                });
              },
            ),
          ),
        ),
        const SizedBox(height: Dimens.space_12),
        Expanded(
          child: iterate(
            (item, index) {
              return GestureDetector(
                onTap: () {
                  Navigator.of(context).pop(item);
                },
                child: _Item(item),
              );
            },
            padding: const EdgeInsets.all(Dimens.space_16),
            separator: const SizedBox(height: Dimens.space_12),
          ),
        ),
      ],
    );
  }

  @override
  void requestApi(int pageNo,
      {Function(List<TransferLotDetailListData>? list)? onSuccess, Function(String errorMessage)? onError}) {
    var provider = StorageDeviceListProvider.of(context, listen: false);
    provider.getDeviceList(pageSize, pageNo * pageSize).then((value) {
      onSuccess?.call(value);
    }, onError: (error) {
      onError?.call(error.toString());
    });
  }

  @override
  void dispose() {
    _debounce.stop();
    _barcodeController.dispose();
    super.dispose();
  }
}

class _Item extends StatelessWidget {
  final TransferLotDetailListData item;

  const _Item(this.item);

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var l10n = L10n(context);
    return CshCard(
        child: Column(
      children: [
        _row(l10n.model, item.model ?? "", theme),
        _row(l10n.barcode, item.qrCode ?? "", theme),
        _row(l10n.location, item.location ?? "", theme, isLast: true),
      ],
    ));
  }

  _row(String title, String value, ThemeData theme, {bool isLast = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: Dimens.space_4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Flexible(
            flex: 2,
            fit: FlexFit.tight,
            child: Text(
              title,
              style: theme.textTheme.titleSmall?.copyWith(color: theme.colorScheme.primary),
            ),
          ),
          Flexible(
            flex: 4,
            fit: FlexFit.tight,
            child: Row(
              children: [
                Expanded(child: Text(value, style: theme.primaryTextTheme.headlineMedium)),
                if (isLast)
                  CshIcon(FeatherIcons.arrowRight,
                      padding: EdgeInsets.zero, iconSize: MobileIconSize.medium, iconColor: theme.colorScheme.primary),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
