import 'dart:io';

import 'package:core/core.dart';
import 'package:core_widgets/core_widgets.dart' hide ImageUtil;
import 'package:flutter/material.dart';
import 'package:flutter_trc/src/modules/engineer/l10n.dart';
import 'package:flutter_trc/src/modules/engineer/my_devices/wip_devices/models/engineer_part_info.dart';
import 'package:flutter_trc/src/modules/engineer/my_devices/wip_devices/view_parts/part_detail/capture_consume_parts_media_screen.dart';
import 'package:flutter_trc/src/modules/engineer/resources/engineer_api_service.dart';
import 'package:flutter_trc/src/utils/image_util.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../../../amplify/amplifier.dart';
import '../../../../../../amplify/amplify_provider.dart';

class ConsumePartButtonWidget extends StatelessWidget {
  final EngineerPartInfo partInfo;
  final VoidCallback? onRequestCompletion;

  const ConsumePartButtonWidget({Key? key, required this.partInfo, this.onRequestCompletion}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    L10n l10n = L10n(context);
    AmplifyProvider amplifyProvider = AmplifyProvider.of(context, listen: false);
    return CshBigOutlineButton(
      text: l10n.consume,
      onPressed: () async {
        try {
          // CshLoading().showLoading(context);
          if (Validator.isTrue(partInfo.isService)) {
            _callConsumeApi(context, l10n);
          } else {
            Navigator.pushNamed(context, CaptureConsumePartsMediaScreen.route,
                arguments: CaptureConsumePartMediaArg(
                    onImageUploaded: (urlsMap) {
                      Logger.debug('mydebug-----ConsumePartButtonWidget.build', [urlsMap.toString()]);
                      // TODO: move to a screen where need to add images
                      // _callConsumeApi(context, l10n);
                    },
                    retrievedPartsMediaCount: 10));

            // final ImagePicker picker = ImagePicker();
            // XFile? imageFilex = await picker.pickImage(source: ImageSource.camera);
            //
            // if (imageFilex == null) {
            //   if (context.mounted) CshLoading().hideLoading(context);
            //   return;
            // }
            //
            // File imageFile = File(imageFilex.path);
            // imageFile = await ImageUtil.compressImage(imageFile);
            // String fileName = Amplifier.fileNameFromPath(imageFile.path);
            // amplifyProvider.uploadFile(
            //   fileName: fileName,
            //   folderName: amplifyProvider.configResponse?.data?.folderName,
            //   file: imageFile,
            //   onProgress: (int currentBytes, int totalBytes) {},
            //   onFileUploaded: (String imagePath) async {
            //     String s3Key = imagePath;
            //     if (!Validator.isNullOrEmpty(s3Key)) {
            //       String s3Url = await amplifyProvider.getS3FileUrlFromS3Key(filePath: s3Key, fullPath: true);
            //       if (!Validator.isNullOrEmpty(s3Url)) {
            //         _callConsumeApi(context, l10n, s3Url);
            //       } else {
            //         displayGenericErrorMessage(context, l10n);
            //       }
            //     } else {
            //       displayGenericErrorMessage(context, l10n);
            //     }
            //   },
            //   onFailed: (String errorMsg) {
            //     CshLoading().hideLoading(context);
            //     showSnackBar(context, errorMsg, isError: true);
            //   },
            // );
          }
        } catch (e) {
          CshLoading().hideLoading(context);
          showSnackBar(context, e.toString(), isError: true);
        }
      },
    );
  }

  void displayGenericErrorMessage(BuildContext context, L10n l10n) {
    CshLoading().hideLoading(context);
    showSnackBar(context, l10n.somethingWentWrong, isError: true);
  }

  _callConsumeApi(BuildContext context, L10n l10n, {List<String>? s3ImageUrl}) {
    EngineerAPIService.consumePart(partInfo.partBarcode!, partInfo.partId, partInfo.prId, s3ImageUrl).listen((event) {
      CshLoading().hideLoading(context);
      if (event?.isSuccess == true) {
        if (onRequestCompletion != null) {
          onRequestCompletion!();
        }
        showSnackBar(context, l10n.consumePartSuccess(partInfo.partName));
      } else {
        showSnackBar(context, event?.errorMsg ?? l10n.somethingWentWrong, isError: true);
      }
    }, onError: (error) {
      CshLoading().hideLoading(context);
      String? errorMessage = ApiErrorHelper.getErrorMessage(error);
      showSnackBar(context, errorMessage ?? l10n.somethingWentWrong, isError: true);
    });
  }

  showSnackBar(BuildContext context, String message, {bool isError = false}) {
    ThemeData theme = Theme.of(context);
    CustomColors customTheme = theme.extension<CustomColors>() as CustomColors;
    var backgroundColor = customTheme.successColor;
    if (isError) {
      backgroundColor = theme.errorColor;
    }
    SnackBar snackBar = SnackBar(
      behavior: SnackBarBehavior.fixed,
      duration: const Duration(seconds: 3),
      padding: const EdgeInsets.all(Dimens.space_16),
      backgroundColor: backgroundColor,
      dismissDirection: DismissDirection.endToStart,
      content: Text(
        message,
        style: theme.textTheme.titleSmall!.copyWith(color: theme.colorScheme.background),
      ),
    );
    return ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
