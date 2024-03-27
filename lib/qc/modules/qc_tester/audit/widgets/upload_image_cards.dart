import 'dart:io';

import 'package:core_widgets/core_widgets.dart' hide ImageUtil;
import 'package:flutter/material.dart';
import 'package:flutter_trc/src/utils/image_util.dart';
import 'package:flutter_trc/src/utils/media_upload/media_optimiser_utils.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;

import '../l10n.dart';

class UploadMediaCards extends StatefulWidget {
  final String? labelText;
  File? selectedFile;
  final Function(String) s3UploadedImageUrlCallback;
  final Function(File) setFileForPersistence;
  final Function() onCrossedButtonTapped;

  UploadMediaCards({
    Key? key,
    required this.s3UploadedImageUrlCallback,
    required this.setFileForPersistence,
    this.selectedFile,
    this.labelText,
    required this.onCrossedButtonTapped,
  }) : super(key: key) {}

  @override
  State<UploadMediaCards> createState() => _UploadMediaCardsState();
}

class _UploadMediaCardsState extends State<UploadMediaCards> {
  final ImagePicker picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    var l10n = L10n(context);
    var theme = Theme.of(context);
    return GestureDetector(
      onTap: widget.selectedFile != null
          ? null
          : () async {
              XFile? xFile = await picker.pickImage(source: ImageSource.camera, requestFullMetadata: false);

              if (xFile != null && context.mounted) {
                var compressedFile = await ImageUtil.compressImage(File(xFile.path));
                widget.selectedFile = compressedFile;
                widget.setFileForPersistence(widget.selectedFile!);
                String fileName = path.basename(compressedFile.path);
                CshLoading().showLoading(context);
                MediaUploadUtil().uploadMediaWithType(mediaFile: compressedFile, fileName: fileName).then((value) {
                  CshLoading().hideLoading(context);
                  CshSnackBar.success(
                    context: context,
                    message: l10n.imageUploadedSuccessfully,
                    snackBarPosition: SnackBarPosition.TOP,
                    duration: SnackBarDuration.SHORT,
                  );

                  widget.s3UploadedImageUrlCallback(value);
                  setState(() {});
                }, onError: (error) {
                  CshLoading().hideLoading(context);
                  CshSnackBar.error(context: context, message: error.toString());
                });
              }
            },
      child: Container(
        width: 100,
        padding: EdgeInsets.only(
          top: widget.selectedFile != null ? Dimens.space_6 : Dimens.space_28,
          bottom: widget.selectedFile != null ? Dimens.space_8 : Dimens.space_12,
          left: Dimens.space_4,
          right: Dimens.space_6,
        ),
        decoration: BoxDecoration(
          border: Border.all(color: theme.dividerColor, width: Dimens.space_4),
          borderRadius: BorderRadius.circular(Dimens.space_4),
        ),
        child: widget.selectedFile != null
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      widget.selectedFile = null;
                      widget.onCrossedButtonTapped();
                      setState(() {});
                    },
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: CshIcon(
                        Icons.cancel,
                        padding: const EdgeInsets.only(right: Dimens.space_4),
                        iconColor: theme.dividerColor,
                        iconSize: MobileIconSize.medium,
                      ),
                    ),
                  ),
                  const SizedBox(height: Dimens.space_6),
                  Image.file(widget.selectedFile!, height: Dimens.space_100)
                ],
              )
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CshIcon(
                    Icons.upload_file,
                    padding: EdgeInsets.zero,
                    iconColor: theme.primaryTextTheme.headlineMedium?.color,
                    iconSize: MobileIconSize.xxLarge,
                  ),
                  const SizedBox(height: Dimens.space_20),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          widget.labelText ?? "Upload Media",
                          style: theme.primaryTextTheme.headlineMedium,
                          textAlign: TextAlign.center,
                        ),
                      ),
                      const SizedBox(),
                    ],
                  ),
                ],
              ),
      ),
    );
  }
}
