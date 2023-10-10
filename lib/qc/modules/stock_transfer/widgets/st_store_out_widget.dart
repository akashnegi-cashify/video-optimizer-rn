import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/qc/modules/stock_transfer/models/st_lot_details_response.dart';
import 'package:flutter_trc/qc/modules/stock_transfer/providers/st_store_out_provider.dart';
import 'package:ml_barcode_scanner/ml_barcode_scanner.dart';

class StStoreOutWidget extends StatelessWidget {
  const StStoreOutWidget({super.key});

  @override
  Widget build(BuildContext context) {
    var provider = StStoreOutProvider.of(context);
    return StreamBuilder<StLotDetailResponse?>(
      stream: provider.lotDetailsStream,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CshShimmer(show: true);
        }

        if (snapshot.hasError) {
          return CshTextNew.bodyText2(snapshot.error.toString());
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

  String? _scannedBarcode;

  @override
  void didUpdateWidget(covariant _StoreOut oldWidget) {
    _bottomButtonState = _BottomButtonState.idle;
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    var provider = StStoreOutProvider.of(context);
    var details = provider.lotDetails;
    return Padding(
      padding: const EdgeInsets.all(Dimens.space_16),
      child: Column(
        children: [
          CshTextNew.bodyText2("Add barcode to transfer lot:-"),
          const SizedBox(height: Dimens.space_8),
          CshTextNew.h3(details?.lotName ?? ""),
          const SizedBox(height: Dimens.space_8),
          Expanded(
            child: _bottomButtonState == _BottomButtonState.idle
                ? Container(color: Colors.red)
                : MlBarcodeScannerWidget(
                    scanFormatList: const [ScanFormats.barcode],
                    onScannerDetected: (value, controller) {
                      _scannerController = controller;
                      _scannedBarcode = value;
                      controller.stop();
                      _bottomButtonState = _BottomButtonState.scanned;
                      setState(() {});
                    },
                  ),
          ),
          const SizedBox(height: Dimens.space_8),
          CshTextNew.subTitle1("Tab scan button to start scanning"),
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
              Expanded(child: CshBigButton(text: "Skip", onPressed: () => _removeDevice())),
              const SizedBox(width: Dimens.space_16),
              _bottomButtonState == _BottomButtonState.idle
                  ? Expanded(
                      child: CshBigButton(
                          text: "Scan",
                          onPressed: () {
                            setState(() {
                              _bottomButtonState = _BottomButtonState.scanning;
                            });
                          }),
                    )
                  : _bottomButtonState == _BottomButtonState.scanned
                      ? Expanded(
                          child: CshBigButton(
                              text: "Add",
                              onPressed: () {
                                // TODO: check for box charger api
                              }),
                        )
                      : const SizedBox.shrink()
            ],
          )
        ],
      ),
    );
  }

  void _removeDevice() {
    var provider = StStoreOutProvider.of(context, listen: false);
    CshLoading().showLoading(context);
    provider.removeDevice().then((value) {
      CshLoading().hideLoading(context);
      CshSnackBar.success(context: context, message: "Device removed from lot");
      _onProceedNext(provider);
    }, onError: (error) {
      CshLoading().hideLoading(context);
      CshSnackBar.error(context: context, message: error);
    });
  }

  _onProceedNext(StStoreOutProvider provider) {
    if (provider.isMoreDevicesAvailable()) {
      provider.getLotDetailsStream();
    } else {
      Navigator.pop(context, true);
    }
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
