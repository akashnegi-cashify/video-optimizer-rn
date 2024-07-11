import 'dart:async';

import 'package:core/core.dart';
import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/rms/modules/receive_device/barcode_types.dart';
import 'package:flutter_trc/rms/modules/receive_device/providers/create_video_module_provider.dart';
import 'package:flutter_trc/src/common/utils/csh_ml_scanner_util.dart';
import 'package:flutter_trc/src/common/utils/csh_video_picker.dart';
import 'package:path/path.dart' as path;
import 'package:provider/provider.dart';

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
    return CshBigButton(text: "Create Video", onPressed: () => _onCreateVideoButtonClicked(context, provider));
  }

  _onCreateVideoButtonClicked(BuildContext context, CreateVideoModuleProvider provider) {
    showBarcodeTypeSelectionDialog(
      context,
      onSelected: (barcodeType) {
        Navigator.pop(context); // Close the dialog
        CshMlScannerUtil().openScanner(
          context,
          onScanned: (scannedData, controller) {
            CshLoading().showLoading(context);
            provider.getDeviceDetails(scannedData, barcodeType).then((value) {
              Navigator.pop(context); // Close the scanner
              CshLoading().hideLoading(context);
              Future.delayed(const Duration(milliseconds: 500), () {
                _createVideo(context, provider, scannedData, barcodeType);
              });
            }, onError: (error) {
              CshLoading().hideLoading(context);
              CshSnackBar.error(context: context, message: error.toString(), snackBarPosition: SnackBarPosition.TOP);
            });
          },
        );
      },
    );
  }

  _createVideo(BuildContext context, CreateVideoModuleProvider provider, String barcode, BarcodeTypes barcodeType) {
    CshVideoPicker(context).pickVideo(
      (file) async {
        try {
          String fileName = path.basename(file.path);
          _showUploadDialog(context, provider.fileUploadProgressStream);
          provider.uploadVideoFile(file, fileName).then((value) {
            Navigator.pop(context); // close progress dialog
            provider.saveVideo(barcode, barcodeType, value).then((value) {
              CshSnackBar.success(context: context, message: "Video uploaded successfully");
            }, onError: (error) {
              CshSnackBar.error(context: context, message: error.toString());
            });
          }, onError: (error) {
            CshSnackBar.error(context: context, message: error.toString());
          });
        } catch (e) {
          Logger.debug('mydebug-----_CreateVideoButton._onCreateVideoButtonClicked', [e]);
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
                title: Text("Uploading Videos - $progress%", style: theme.textTheme.titleMedium),
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
