import 'dart:io';

import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/src/modules/engineer/l10n.dart';
import 'package:flutter_trc/src/modules/engineer/my_devices/wip_devices/models/engineer_part_info.dart';
import 'package:flutter_trc/src/modules/engineer/resources/engineer_api_service.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../../../amplify/amplifier.dart';
import '../../../../../../amplify/amplify_provider.dart';

class ConsumePartButtonWidget extends StatelessWidget {
  final EngineerPartInfo partInfo;
  final VoidCallback? onRequestCompletion;

  const ConsumePartButtonWidget({Key? key, required this.partInfo, this.onRequestCompletion}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ImagePicker picker = ImagePicker();
    L10n l10n = L10n(context);
    AmplifyProvider amplifyProvider = AmplifyProvider.of(context, listen: false);
    return CshBigOutlineButton(
      text: l10n.consume,
      onPressed: () async {
        try {
          CshLoading().showLoading(context);
          XFile? imageFilex = await picker.pickImage(source: ImageSource.camera);
          if (imageFilex != null) {
            File imageFile = File(imageFilex.path);
            String fileName = Amplifier.fileNameFromPath(imageFile.path);
            amplifyProvider.uploadFile(
              fileName: fileName,
              folderName: amplifyProvider.configResponse?.data?.folderName,
              file: imageFile,
              onProgress: (int currentBytes, int totalBytes) {},
              onFileUploaded: (String imagePath) async {
                String s3Key = imagePath;
                if (!Validator.isNullOrEmpty(s3Key)) {
                  String s3Url = await amplifyProvider.getS3FileUrlFromS3Key(filePath: s3Key, fullPath: true);
                  if (!Validator.isNullOrEmpty(s3Url)) {
                    EngineerAPIService.consumePart(partInfo.partBarcode!, partInfo.partId, partInfo.prId, s3Url).listen(
                        (event) {
                      CshLoading().hideLoading(context);
                      if (event?.isSuccess == true) {
                        if (onRequestCompletion != null) {
                          onRequestCompletion!();
                        }
                        CshSnackBar.success(
                          context: context,
                          message: l10n.consumePartSuccess(partInfo.partName),
                          snackBarPosition: SnackBarPosition.TOP,
                        );
                      } else {
                        CshSnackBar.error(
                          context: context,
                          message: event?.errorMsg ?? l10n.somethingWentWrong,
                          snackBarPosition: SnackBarPosition.TOP,
                        );
                      }
                    }, onError: (error) {
                      CshLoading().hideLoading(context);
                      String? errorMessage = ApiErrorHelper.getErrorMessage(error);
                      CshSnackBar.error(
                        context: context,
                        message: errorMessage ?? l10n.somethingWentWrong,
                        snackBarPosition: SnackBarPosition.TOP,
                      );
                    });
                  } else {
                    displayGenericErrorMessage(context, l10n);
                  }
                } else {
                  displayGenericErrorMessage(context, l10n);
                }
              },
              onFailed: (String errorMsg) {
                CshLoading().hideLoading(context);
                CshSnackBar.error(context: context, message: errorMsg, snackBarPosition: SnackBarPosition.TOP);
              },
            );
          } else {
            CshLoading().hideLoading(context);
          }
        } catch (e) {
          CshLoading().hideLoading(context);
          CshSnackBar.error(context: context, message: e.toString(), snackBarPosition: SnackBarPosition.TOP);
        }
      },
    );
  }

  void displayGenericErrorMessage(BuildContext context, L10n l10n) {
    CshLoading().hideLoading(context);
    CshSnackBar.error(context: context, message: l10n.somethingWentWrong, snackBarPosition: SnackBarPosition.TOP);
  }
}
