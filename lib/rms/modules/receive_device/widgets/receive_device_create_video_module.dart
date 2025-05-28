import 'dart:async';

import 'package:calculator_ui/calculator_ui.dart';
import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/rms/modules/receive_device/barcode_types.dart';
import 'package:flutter_trc/rms/modules/receive_device/providers/create_video_module_provider.dart';
import 'package:flutter_trc/src/common/utils/csh_ml_scanner_util.dart';
import 'package:flutter_trc/src/common/utils/csh_video_picker.dart';
import 'package:flutter_trc/src/common/widgets/trc_scanner_widget.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:path/path.dart' as path;
import 'package:provider/provider.dart';

import '../l10n.dart';
import 'barcode_type_selection_dialog.dart';

class ReceiveDeviceCreateVideoModule extends StatelessWidget {
  const ReceiveDeviceCreateVideoModule({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(child: const _CreateVideoButton(), create: (_) => CreateVideoModuleProvider());
  }
}

class _CreateVideoButton extends StatelessWidget {
  const _CreateVideoButton({super.key});

  @override
  Widget build(BuildContext context) {
    var provider = CreateVideoModuleProvider.of(context);
    var l10n = L10n(context);
    return CshBigButton(text: l10n.createVideo, onPressed: () => _onCreateVideoButtonClicked(context, provider));
  }

  _onCreateVideoButtonClicked(BuildContext context, CreateVideoModuleProvider provider) {
    ResetLastScannedBarcode? _resetController;
    showBarcodeTypeSelectionDialog(
      context,
      onSelected: (barcodeType) {
        Navigator.pop(context); // Close the dialog
        CshMlScannerUtil().openScanner(
          context,
          scanFormatList: [BarcodeFormat.all],
          resetController: (resetController) {
            _resetController = resetController;
          },
          onScanned: (scannedData, controller) {
            CshLoading().showLoading(context);
            controller?.stop();
            provider.getDeviceDetails(scannedData, barcodeType).then((value) {
              Navigator.pop(context); // Close the scanner
              CshLoading().hideLoading(context);
              Future.delayed(const Duration(milliseconds: 500), () {
                _createVideo(context, provider, scannedData, barcodeType);
              });
            }, onError: (error) {
              CshLoading().hideLoading(context);
              _resetController?.resetLastScannedBarcode();
              showAlertDialog(
                context,
                title: "Scanned Value - $scannedData",
                desc: error.toString(),
                posBtnText: "Scan Again",
                onPosBtnPressed: (_) {
                  controller?.start();
                  Navigator.pop(context); // Close the alert dialog
                },
              );
            });
          },
        );
      },
    );
  }

  _createVideo(BuildContext context, CreateVideoModuleProvider provider, String barcode, BarcodeTypes barcodeType) {
    var l10n = L10n(context, listen: false);
    CshVideoPicker(context).pickVideo(
      (file) async {
        try {
          String fileName = path.basename(file.path);
          _showUploadDialog(context, provider.fileUploadProgressStream);
          provider.uploadVideoFile(file, fileName).then((value) {
            Navigator.pop(context); // close progress dialog
            provider.saveVideo(barcode, barcodeType, value).then((value) {
              CshSnackBar.success(context: context, message: l10n.videoUploadedSuccessfully);
            }, onError: (error) {
              CshSnackBar.error(context: context, message: error.toString());
            });
          }, onError: (error) {
            CshSnackBar.error(context: context, message: error.toString());
          });
        } catch (e) {
          CshSnackBar.error(context: context, message: e.toString());
          return null;
        }
      },
    );
  }

  _showUploadDialog(BuildContext context, StreamController<int>? fileUploadProgressStream) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) {
        var theme = Theme.of(context);
        var l10n = L10n(context, listen: false);
        return PopScope(
          canPop: false,
          child: StreamBuilder<int>(
            stream: fileUploadProgressStream?.stream,
            builder: (context, snapshot) {
              var progress = snapshot.data ?? 0;
              if (progress > 100) {
                progress = 100;
              }
              return AlertDialog(
                title: Text("${l10n.uploadingVideo} - $progress%", style: theme.textTheme.titleMedium),
                content: LinearProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(theme.primaryColor),
                  backgroundColor: theme.primaryColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(Dimens.space_6),
                  value: progress / 100,
                ),
              );
            },
          ),
        );
      },
    );
  }
}
