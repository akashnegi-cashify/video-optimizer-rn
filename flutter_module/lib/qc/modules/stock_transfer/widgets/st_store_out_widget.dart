import 'package:calculator_ui/calculator_ui.dart';
import 'package:core/core.dart';
import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/qc/modules/stock_transfer/providers/st_store_out_provider.dart';
import 'package:flutter_trc/qc/modules/stock_transfer/resources/st_lot_details_response.dart';
import 'package:flutter_trc/qc/modules/stock_transfer/screens/storage_device_list_screen.dart';
import 'package:ml_barcode_scanner/ml_barcode_scanner.dart';

import '../l10n.dart';

class StStoreOutWidget extends StatelessWidget {
  const StStoreOutWidget({super.key});

  @override
  Widget build(BuildContext context) {
    var provider = StStoreOutProvider.of(context);
    var theme = Theme.of(context);
    return StreamBuilder<StLotDetailResponse?>(
      stream: provider.lotDetailsStream,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CshShimmer(show: true);
        }

        if (snapshot.hasError) {
          var errorMessage = ApiErrorHelper.getErrorMessage(snapshot.error);
          return Padding(
            padding: const EdgeInsets.all(Dimens.space_16),
            child: Text(
              errorMessage.toString(),
              textAlign: TextAlign.center,
              style: theme.textTheme.titleMedium?.copyWith(color: theme.colorScheme.error),
            ),
          );
        }

        if (snapshot.hasData) {
          var data = snapshot.data;
          provider.setData(data);
          return _StoreOut();
        }
        return const SizedBox.shrink();
      },
    );
  }
}

class _StoreOut extends StatefulWidget {
  const _StoreOut({super.key});

  @override
  State<_StoreOut> createState() => _StoreOutState();
}

class _StoreOutState extends State<_StoreOut> {
  _BottomButtonState _bottomButtonState = _BottomButtonState.idle;
  MlScannerController? _scannerController;

  // @override
  // void didUpdateWidget(covariant _StoreOut oldWidget) {
  //   _bottomButtonState = _BottomButtonState.idle;
  //   super.didUpdateWidget(oldWidget);
  // }

  @override
  Widget build(BuildContext context) {
    var provider = StStoreOutProvider.of(context);
    var theme = Theme.of(context);
    var l10n = L10n(context);
    var details = provider.lotDetails;
    return Padding(
      padding: const EdgeInsets.all(Dimens.space_16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          CshCard(
            child: Column(
              children: [
                RichText(
                  text: TextSpan(
                    text: "${l10n.lotName}: ",
                    style: theme.textTheme.bodyMedium,
                    children: [TextSpan(text: details?.lotName ?? "", style: theme.primaryTextTheme.displaySmall)],
                  ),
                ),
                const SizedBox(height: Dimens.space_4),
                RichText(
                  text: TextSpan(
                    text: "${l10n.storeOut}: ",
                    style: theme.textTheme.bodyMedium,
                    children: [
                      TextSpan(
                          text: "${details?.scanCount ?? 0} / ${details?.deviceCount ?? 0} Done",
                          style: theme.primaryTextTheme.displaySmall)
                    ],
                  ),
                ),
                const SizedBox(height: Dimens.space_8),
                CshMediumButton(
                  text: l10n.deviceList,
                  onPressed: () {
                    StorageDeviceListScreen.pushNamed(context, provider.lotId!, onItemSelected: (item) {
                      provider.setData(item);
                      setState(() {});
                    });
                  },
                ),
              ],
            ),
          ),
          const SizedBox(height: Dimens.space_8),
          Expanded(
            child: _bottomButtonState == _BottomButtonState.idle
                ? Container(
                    color: theme.colorScheme.primary.withAlpha(20),
                    height: double.infinity,
                    width: double.infinity,
                    child: const Icon(Icons.qr_code_scanner_outlined, size: 100),
                  )
                : MlBarcodeScannerWidget(
                    isPlayScanSound: true,
                    zoomScale: 0.5,
                    onScannerDetected: (value, controller) {
                      _scannerController = controller;
                      if (value.toLowerCase() != provider.lotDetails?.barcode?.toLowerCase()) {
                        CshSnackBar.error(context: context, message: "Mismatch Qr Code scanned again");
                        return;
                      }
                      controller.stop();
                      _bottomButtonState = _BottomButtonState.scanned;
                      setState(() {});
                    },
                  ),
          ),
          const SizedBox(height: Dimens.space_8),
          Text(l10n.tabScanButtonStartScanning, style: theme.textTheme.titleMedium, textAlign: TextAlign.center),
          const SizedBox(height: Dimens.space_16),
          _DataWidget(label: "Location", value: details?.location),
          const SizedBox(height: Dimens.space_6),
          _DataWidget(label: "Model Name", value: details?.modelName),
          const SizedBox(height: Dimens.space_6),
          _DataWidget(label: "Barcode", value: details?.barcode),
          const SizedBox(height: Dimens.space_6),
          _DataWidget(label: "Destination", value: details?.destination),
          const SizedBox(height: Dimens.space_6),
          _DataWidget(label: "Type", value: details?.storage),
          const SizedBox(height: Dimens.space_16),
          Row(
            children: [
              Expanded(child: CshBigButton(text: l10n.skip, onPressed: () => _skipDevice())),
              const SizedBox(width: Dimens.space_16),
              _bottomButtonState == _BottomButtonState.idle
                  ? Expanded(child: CshBigButton(text: l10n.scan, onPressed: () => _setScanningState()))
                  : _bottomButtonState == _BottomButtonState.scanned
                      ? Expanded(child: CshBigButton(text: l10n.add, onPressed: () => _addDevice()))
                      : const SizedBox.shrink()
            ],
          )
        ],
      ),
    );
  }

  void _skipDevice() {
    var provider = StStoreOutProvider.of(context, listen: false);
    CshLoading().showLoading(context);
    provider.skipDevice().then((value) {
      CshLoading().hideLoading(context);
      CshSnackBar.success(
        context: context,
        message: "Device Skipped",
        snackBarPosition: SnackBarPosition.TOP,
        duration: SnackBarDuration.SHORT,
      );
      _getNextDevice();
      // _setScanningState();
    }, onError: (error) {
      CshLoading().hideLoading(context);
      _showSkipRetryDialog(error.toString());
    });
  }

  _showSkipRetryDialog(String errorMessage) {
    showPopup(
      context,
      title: "Warning!",
      desc: errorMessage,
      actions: [
        CshMediumButton(
          text: "Retry",
          onPressed: () {
            Navigator.pop(context); // dismiss dialog
            _skipDevice();
          },
        ),
        CshMediumButton(
          text: 'Cancel',
          onPressed: () {
            Navigator.pop(context); // dismiss dialog
          },
        ),
      ],
    );
  }

  _getNextDevice() {
    var provider = StStoreOutProvider.of(context, listen: false);
    provider.getLotDetailsStream();
  }

  _onProceedNext() {
    var provider = StStoreOutProvider.of(context, listen: false);
    if (provider.isMoreDevicesAvailable()) {
      _setScanningState();
      provider.getLotDetailsStream();
    } else {
      Navigator.pop(context, true);
    }
  }

  _setScanningState() {
    _bottomButtonState = _BottomButtonState.scanning;
    _scannerController?.start();
    setState(() {});
  }

  void _addDevice() {
    var provider = StStoreOutProvider.of(context, listen: false);
    CshLoading().showLoading(context);
    provider.addDevice().then((_) {
      CshLoading().hideLoading(context);
      _onProceedNext();
    }, onError: (error) {
      CshLoading().hideLoading(context);
      _showAddDeviceRetryDialog(error.toString());
    });
  }

  void _showAddDeviceRetryDialog(String errorMessage) {
    showPopup(
      context,
      title: "Warning!",
      desc: errorMessage,
      actions: [
        CshMediumButton(
          text: "Retry",
          onPressed: () {
            Navigator.pop(context); // dismiss dialog
            _addDevice();
          },
        ),
        CshMediumButton(
          text: 'Cancel',
          onPressed: () {
            Navigator.pop(context); // dismiss dialog
            // _onProceedNext();
          },
        ),
      ],
    );
  }

  @override
  void dispose() {
    _scannerController = null;
    super.dispose();
  }
}

class _DataWidget extends StatelessWidget {
  final String label;
  final String? value;

  const _DataWidget({super.key, required this.label, this.value});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Row(
      children: [
        CshTextNew.bodyText1("$label: "),
        Expanded(
          child: Text(
            "$value",
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: theme.textTheme.displaySmall,
          ),
        ),
      ],
    );
  }
}

enum _BottomButtonState { idle, scanning, scanned }
