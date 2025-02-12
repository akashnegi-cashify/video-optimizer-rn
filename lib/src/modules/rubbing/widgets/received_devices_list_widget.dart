import 'package:core/core.dart';
import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/src/common/utils/csh_ml_scanner_util.dart';
import 'package:flutter_trc/src/common/widgets/paginated_listview.dart';
import 'package:flutter_trc/src/common/widgets/shimmer_list_widget.dart';
import 'package:flutter_trc/src/common/widgets/title_value_row_widget.dart';
import 'package:flutter_trc/src/modules/rubbing/l10n.dart';
import 'package:flutter_trc/src/modules/rubbing/model/rubbing_device_data.dart';
import 'package:flutter_trc/src/modules/rubbing/providers/received_devices_provider.dart';
import 'package:provider/provider.dart';

class ReceivedDevicesListWidget extends StatefulWidget {
  const ReceivedDevicesListWidget({Key? key}) : super(key: key);

  @override
  State<ReceivedDevicesListWidget> createState() => _ReceivedDevicesListWidgetState();
}

class _ReceivedDevicesListWidgetState extends PaginatedListState<RubbingDeviceData, ReceivedDevicesListWidget> {
  @override
  Widget build(BuildContext context) {
    return (isLoading && items.isEmpty)
        ? const ShimmerListWidget()
        : this.iterate((item, index) {
            return _ItemReceivedDevicesWidget(
              rubbingDeviceData: item!,
              onRubbingAction: resetAndRefreshScreen,
            );
          }, onRefresh: () async {});
  }

  @override
  void requestApi(int pageNo, int pageSize,
      {Function(List<RubbingDeviceData>? list)? onSuccess, Function(String? errorMessage)? onError}) {
    var provider = Provider.of<ReceivedDevicesProvider>(context, listen: false);
    var l10 = L10n(context, listen: false);
    provider.getDataStream(pageNo, pageSize, provider.searchQuery).listen((event) {
      if (onSuccess != null) onSuccess(event?.dt?.deviceList);
    }).onError((e) {
      CshSnackBar.error(context: context, message: ApiErrorHelper.getErrorMessage(e) ?? l10.somethingWentWrong);
    });
  }
}

class _ItemReceivedDevicesWidget extends StatelessWidget {
  final VoidCallback onRubbingAction;
  final RubbingDeviceData rubbingDeviceData;

  const _ItemReceivedDevicesWidget({Key? key, required this.onRubbingAction, required this.rubbingDeviceData})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    ReceivedDevicesProvider provider = Provider.of<ReceivedDevicesProvider>(context, listen: false);
    L10n l10n = L10n(context);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: Dimens.space_8, horizontal: Dimens.space_16),
      child: CshCard(
        child: Column(
          children: [
            TitleValueRowWidget(title: l10n.deviceBarcode, value: rubbingDeviceData.deviceBarcode ?? ""),
            TitleValueRowWidget(title: l10n.deviceName, value: rubbingDeviceData.productTitle ?? ""),
            TitleValueRowWidget(title: l10n.deviceId, value: rubbingDeviceData.deviceId.toString()),
            const SizedBox(height: Dimens.space_16),
            ComboButton(
              firstBtnText: l10n.fail,
              padding: EdgeInsets.zero,
              secondBtnText: l10n.done,
              isFirstPrimary: true,
              firstBtnClick: Validator.isNullOrEmpty(rubbingDeviceData.deviceBarcode)
                  ? null
                  : () => markRubbing(provider, l10n, context, false),
              secondBtnClick: rubbingDeviceData.deviceBarcode != null
                  ? () {
                      if (Validator.isTrue(provider.isGlassChangeRole)) {
                        CshMlScannerUtil().openScanner(
                          context,
                          header: "Scan part barcode",
                          hintText: "Scan part barcode",
                          onScanned: (scannedData, controller) {
                            Navigator.pop(context); // close scanner
                            markRubbing(provider, l10n, context, true, partBarcode: scannedData);
                          },
                        );
                      } else {
                        markRubbing(provider, l10n, context, true);
                      }
                    }
                  : null,
            ),
          ],
        ),
      ),
    );
  }

  void markRubbing(ReceivedDevicesProvider provider, L10n l10n, BuildContext context, bool isDone,
      {String? partBarcode}) {
    provider.markRubbing(rubbingDeviceData.deviceBarcode!, isDone, partBarcode).then((res) {
      showSuccessMessage(res?.successMsg ?? "", context);
      onRubbingAction();
    }).catchError((e) {
      String errorMessage = ApiErrorHelper.getErrorMessage(e) ?? l10n.somethingWentWrong;
      showErrorMessage(errorMessage, context);
    });
  }

  void showErrorMessage(String errorMessage, BuildContext context) =>
      CshSnackBar.error(context: context, message: errorMessage);

  void showSuccessMessage(String successMessage, BuildContext context) =>
      CshSnackBar.success(context: context, message: successMessage);
}
