import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/qc/modules/warehouse_audit/dialogs/show_audit_scanned_device_detail_dialog.dart';
import 'package:flutter_trc/qc/modules/warehouse_audit/providers/warehouse_audit_perform_provider.dart';
import 'package:flutter_trc/qc/modules/warehouse_audit/resources/upload_image_data.dart';
import 'package:flutter_trc/src/common/widgets/trc_scanner_widget.dart';
import 'package:flutter_trc/src/utils/media_upload/providers/image_upload_provider.dart';
import 'package:flutter_trc/src/utils/media_upload/widgets/general_image_upload_card.dart';
import 'package:ml_barcode_scanner/widgets/ml_barcode_scanner_widget.dart';
import 'package:provider/provider.dart';

class WarehouseAuditPerformWidget extends StatelessWidget {
  const WarehouseAuditPerformWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return TRCScannerWidget(
      hintText: "Scan Device Barcode",
      onScanDetected: (scannedData, controller) {
        if (_validateBarcode(scannedData, context)) {
          controller?.stop();
          _onScanDetected(context, scannedData, controller);
        }
      },
    );
  }

  bool _containsSpecialCharacters(String input) {
    RegExp regex = RegExp(r'[^a-zA-Z0-9]');
    return regex.hasMatch(input);
  }

  _validateBarcode(String scannedData, BuildContext context) {
    if (_containsSpecialCharacters(scannedData)) {
      CshSnackBar.error(
        context: context,
        message: "Please scan the device again",
        snackBarPosition: SnackBarPosition.TOP,
        duration: SnackBarDuration.MEDIUM,
      );
      return false;
    }
    return true;
  }

  _onScanDetected(BuildContext context, String scannedData, MlScannerController? controller,
      {Map<String, String>? uploadedImageMap}) {
    var provider = WarehouseAuditPerformProvider.of(context, listen: false);
    CshLoading().showLoading(context);
    provider.scanDevice(scannedData, imagesListMap: uploadedImageMap, isManualEntry: controller == null).then((value) {
      CshLoading().hideLoading(context);
      if (value?.status == 1 && (value?.requiredImageList?.length ?? 0) > 0) {
        var list = UploadImageData.encodeInList(value!.requiredImageList!);
        _showImageCaptureDialog(
          context,
          value.message,
          list,
          onImageUploaded: (uploadedImageList) {
            var uploadedImageMap = UploadImageData.decodeInMap(uploadedImageList);
            _onScanDetected(context, scannedData, controller, uploadedImageMap: uploadedImageMap);
          },
        );
      } else {
        showAuditScannedDeviceDetailsDialog(context, value).whenComplete(() => controller?.start());
      }
    }, onError: (error) {
      CshLoading().hideLoading(context);
      controller?.start();
      CshSnackBar.error(
        context: context,
        message: error.toString(),
        snackBarPosition: SnackBarPosition.TOP,
        duration: SnackBarDuration.MEDIUM,
      );
    });
  }

  _showImageCaptureDialog(BuildContext context, String? heading, List<UploadImageData> list,
      {required Function(List<UploadImageData> uploadedImageList) onImageUploaded}) {
    showCshBottomSheet(
        context: context,
        isDismissible: false,
        child: PopScope(
          canPop: false,
          child: Container(
            height: MediaQuery.of(context).size.height * 0.6,
            padding: const EdgeInsets.fromLTRB(Dimens.space_16, Dimens.space_24, Dimens.space_16, Dimens.space_20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CshTextNew.subTitle1(heading ?? ""),
                const SizedBox(height: Dimens.space_16),
                StatefulBuilder(
                  builder: (_, setState) {
                    return Expanded(
                      child: ListView.separated(
                          shrinkWrap: true,
                          itemBuilder: (_, index) {
                            var item = list[index];
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CshTextNew.subTitle2(item.heading),
                                const SizedBox(height: Dimens.space_4),
                                ChangeNotifierProvider(
                                  create: (_) => ImageUploadProvider(),
                                  child: GeneralImageUploadCard(
                                    cardHeight: 100,
                                    cardWidth: 100,
                                    imageUrl: item.imageUrl,
                                    onMediaUploaded: (url) {
                                      setState(() {
                                        item.imageUrl = url!;
                                      });
                                      if (_checkIsAllImagesUploaded(list)) {
                                        Navigator.pop(context); // Dismiss dialog
                                        onImageUploaded(list);
                                      }
                                    },
                                  ),
                                ),
                              ],
                            );
                          },
                          separatorBuilder: (context, index) {
                            return const SizedBox(height: Dimens.space_20);
                          },
                          itemCount: list.length),
                    );
                  },
                )
              ],
            ),
          ),
        ));
  }

  bool _checkIsAllImagesUploaded(List<UploadImageData> list) {
    for (var item in list) {
      if (Validator.isNullOrEmpty(item.imageUrl)) {
        return false;
      }
    }
    return true;
  }
}
