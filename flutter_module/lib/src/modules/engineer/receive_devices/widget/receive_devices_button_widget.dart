import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/src/common/utils/csh_ml_scanner_util.dart';
import 'package:flutter_trc/src/modules/engineer/l10n.dart';
import 'package:flutter_trc/src/modules/engineer/receive_devices/models/receive_devices_response.dart';
import 'package:flutter_trc/src/modules/engineer/receive_devices/providers/engineer_receive_devices_presenter.dart';
import 'package:ml_barcode_scanner/widgets/index.dart';

import '../../../../common/widgets/title_value_row_widget.dart';

class ReceiveDevicesButtonWidget extends StatefulWidget {
  const ReceiveDevicesButtonWidget({Key? key}) : super(key: key);

  @override
  State<ReceiveDevicesButtonWidget> createState() => _ReceiveDevicesButtonWidgetState();
}

class _ReceiveDevicesButtonWidgetState extends State<ReceiveDevicesButtonWidget> with ViewActions {
  late L10n l10n;
  late EngineerReceiveDevicePresenter presenter;

  @override
  void initState() {
    presenter = EngineerReceiveDevicePresenter(this);
    super.initState();
  }

  @override
  void didChangeDependencies() {
    l10n = L10n(context);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return CshBigButton(
      text: l10n.receiveDevices,
      onPressed: () {
        CshMlScannerUtil().openScanner(
          context,
          onScanned: (scannedData, controller) {
            presenter.receiveDevice(scannedData, controller);
          },
        );
      },
    );
  }

  @override
  displayDataInBottomSheet(ReceiveDevicesResponse receiveDevicesResponse, VoidCallback onBottomSheetClosed) {
    showCshBottomSheet(
        context: context,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: Dimens.space_48, horizontal: Dimens.space_16),
          child: Column(
            children: [
              TitleValueRowWidget(
                  title: l10n.deviceBarcode, value: receiveDevicesResponse.deviceInfo!.deviceBarcode ?? ""),
              TitleValueRowWidget(
                  title: l10n.productTitle, value: receiveDevicesResponse.deviceInfo!.productTitle ?? ""),
              TitleValueRowWidget(title: l10n.status, value: receiveDevicesResponse.deviceInfo!.status ?? ""),
            ],
          ),
        )).whenComplete(onBottomSheetClosed);
  }

  @override
  onError({String? errorMessage}) {
    CshSnackBar.error(context: context, message: errorMessage ?? l10n.somethingWentWrong);
  }

  @override
  resumeScanner(MlScannerController? controller) {
    controller?.start();
  }

  @override
  handleLoading(bool loading) {
    if (loading) {
      CshLoading().showLoading(context);
    } else {
      CshLoading().hideLoading(context);
    }
  }

  @override
  displayErrorBottomSheet({VoidCallback? onBottomSheetClosed, String? message}) {
    showCshBottomSheet(
        context: context,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: Dimens.space_48, horizontal: Dimens.space_16),
          child: CshTextNew.h4(message ?? l10n.somethingWentWrong),
        )).whenComplete(onBottomSheetClosed ?? () {});
  }
}

mixin ViewActions {
  onError({String? errorMessage});

  handleLoading(bool loading);

  displayDataInBottomSheet(ReceiveDevicesResponse receiveDevicesResponse, VoidCallback onBottomSheetClosed);

  displayErrorBottomSheet({VoidCallback? onBottomSheetClosed, String? message});

  resumeScanner(MlScannerController? controller);
}
