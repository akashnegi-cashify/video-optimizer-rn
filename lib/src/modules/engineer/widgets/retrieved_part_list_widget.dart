import 'package:core_widgets/core_widgets.dart' hide iterate;
import 'package:flutter/material.dart';
import 'package:flutter_trc/src/common/utils/csh_ml_scanner_util.dart';
import 'package:flutter_trc/src/modules/engineer/models/retrieved_part_list_response.dart';
import 'package:flutter_trc/src/modules/engineer/providers/retrieved_part_list_provider.dart';
import 'package:flutter_trc/src/utils/paginate_list_abstract.dart';
import '../l10n.dart';

class RetrievedPartListWidget extends StatefulWidget {
  const RetrievedPartListWidget({super.key});

  @override
  State<RetrievedPartListWidget> createState() => _RetrievedPartListWidgetState();
}

class _RetrievedPartListWidgetState extends PaginatedListState<RetrievedPartListData, RetrievedPartListWidget> {
  final _barcodeController = TextEditingController();

  final _debounce = TextInputDebounce();

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var l10n = L10n(context);
    var provider = RetrievedPartListProvider.of(context);
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(Dimens.space_16, Dimens.space_16, Dimens.space_16, 0),
          child: CshTextFormField(
            hintText: l10n.retrievedPartBarcode,
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
        Expanded(
            child: iterate(
          (item, index) {
            return _RetrievedPartItem(item);
          },
          onRefresh: () async {},
          separator: const SizedBox(height: Dimens.space_16),
          padding: const EdgeInsets.all(Dimens.space_16),
          onNoDataFound: () {
            return Center(child: Text("No data found", style: theme.primaryTextTheme.titleMedium));
          },
        ))
      ],
    );
  }

  @override
  void requestApi(int pageNo,
      {Function(List<RetrievedPartListData>? list)? onSuccess, Function(String errorMessage)? onError}) {
    var provider = RetrievedPartListProvider.of(context, listen: false);
    provider.getList(++pageNo, pageSize).then((value) {
      onSuccess?.call(value);
    }, onError: (error) {
      onError?.call(error);
    });
  }

  @override
  void dispose() {
    _debounce.stop();
    _barcodeController.dispose();
    super.dispose();
  }
}

class _RetrievedPartItem extends StatelessWidget {
  final RetrievedPartListData item;

  const _RetrievedPartItem(this.item, {super.key});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var l10n = L10n(context);
    return CshCard(
      child: Column(
        children: [
          _labelValueWidget(theme, l10n.sku, item.sku ?? ""),
          const SizedBox(height: Dimens.space_8),
          _labelValueWidget(theme, l10n.partName, item.partName ?? ""),
          const SizedBox(height: Dimens.space_8),
          _labelValueWidget(theme, l10n.deviceBarcode, item.deviceBarcode ?? ""),
          const SizedBox(height: Dimens.space_8),
          _labelValueWidget(theme, l10n.retrievedPartsBarcode, item.retrievedPartBarcode ?? ""),
        ],
      ),
    );
  }

  _labelValueWidget(ThemeData theme, String label, String value) {
    return Row(
      children: [
        Expanded(
          child: Text(
            label,
            style: theme.primaryTextTheme.headlineMedium?.copyWith(color: theme.primaryColor),
          ),
        ),
        Expanded(
          child: Text(
            value,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: theme.primaryTextTheme.headlineMedium,
          ),
        )
      ],
    );
  }
}
