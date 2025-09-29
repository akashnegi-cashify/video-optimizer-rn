import 'dart:io';

import 'package:core/core.dart';
import 'package:core_widgets/core_widgets.dart' hide ImageUtil;
import 'package:flutter/material.dart';
import 'package:flutter_trc/src/utils/image_util.dart';
import 'package:flutter_trc/src/utils/media_upload/media_optimiser_utils.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;

import '../l10n.dart';

class UploadMediaCards extends StatefulWidget {
  final String? labelText;
  final Function(String) s3UploadedImageUrlCallback;
  final Function(File) setFileForPersistence;
  final Function() onCrossedButtonTapped;
  final File? selectedFile;

  const UploadMediaCards({
    Key? key,
    this.selectedFile,
    required this.s3UploadedImageUrlCallback,
    required this.setFileForPersistence,
    this.labelText,
    required this.onCrossedButtonTapped,
  }) : super(key: key);

  @override
  State<UploadMediaCards> createState() => _UploadMediaCardsState();
}

class _UploadMediaCardsState extends State<UploadMediaCards> {
  final ImagePicker picker = ImagePicker();

  File? _selectedFile;
  bool _isUploading = false;

  _captureMediaAndUpload(L10n l10n) async {
    XFile? xFile = await picker.pickImage(source: ImageSource.camera, requestFullMetadata: false);

    if (xFile != null && context.mounted) {
      setState(() {
        _isUploading = true;
      });
      ImageUtil.compressImage(File(xFile.path)).then((compressedFile) {
        _selectedFile = compressedFile;
        String fileName = path.basename(compressedFile.path);
        MediaUploadUtil().uploadMediaWithType(mediaFile: compressedFile, fileName: fileName).then((value) {
          CshSnackBar.success(
            context: context,
            message: l10n.imageUploadedSuccessfully,
            snackBarPosition: SnackBarPosition.TOP,
            duration: SnackBarDuration.SHORT,
          );
          widget.setFileForPersistence(_selectedFile!);
          widget.s3UploadedImageUrlCallback(value);
          setState(() {
            _isUploading = false;
          });
        }, onError: (error) {
          setState(() {
            _isUploading = false;
            _selectedFile = null;
          });
          CshSnackBar.error(context: context, message: error.toString());
        });
      });
    }
  }

  @override
  void initState() {
    _selectedFile = widget.selectedFile;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var l10n = L10n(context);
    var theme = Theme.of(context);
    return GestureDetector(
      onTap: _selectedFile != null ? null : () => _captureMediaAndUpload(l10n),
      child: Container(
        width: 100,
        padding: EdgeInsets.only(
          top: _selectedFile != null ? Dimens.space_6 : Dimens.space_28,
          bottom: _selectedFile != null ? Dimens.space_8 : Dimens.space_12,
          left: Dimens.space_4,
          right: Dimens.space_6,
        ),
        decoration: BoxDecoration(
          border: Border.all(color: theme.dividerColor, width: Dimens.space_4),
          borderRadius: BorderRadius.circular(Dimens.space_4),
        ),
        child: _selectedFile != null
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      widget.onCrossedButtonTapped();
                      setState(() {
                        _selectedFile = null;
                      });
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
                  Image.file(_selectedFile!, height: Dimens.space_100)
                ],
              )
            : _isUploading
                ? const SizedBox(height: 100, child: Center(child: CircularProgressIndicator()))
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
