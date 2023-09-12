import 'dart:io';

import 'package:core_widgets/core_widgets.dart' hide ImageUtil;
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_trc/src/common/widgets/dispute_image_editor_screen.dart';
import 'package:flutter_trc/src/utils/image_util.dart';
import 'package:image_picker/image_picker.dart';

import '../../../modules/elss/widgets/network_image_widget.dart';
import '../../image_assest_helper.dart';
import '../providers/image_upload_provider.dart';

class GeneralImageUploadCard extends StatelessWidget {
  final Function(String?)? onMediaUploaded;
  final double? cardHeight;
  final double? cardWidth;
  final String? imageUrl;
  final bool isImageMarkingRequired;
  final VoidCallback? onMediaUploadingStarted;

  const GeneralImageUploadCard({
    super.key,
    this.onMediaUploaded,
    this.cardHeight,
    this.cardWidth,
    this.imageUrl,
    this.onMediaUploadingStarted,
    this.isImageMarkingRequired = false,
  });

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);

    var provider = ImageUploadProvider.of(context);

    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () async {
        if (!Validator.isNullOrEmpty(imageUrl)) {
          _showRetakeModal(context, theme);
        } else {
          _takeImage(context);
        }
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CshCard(
            padding: EdgeInsets.zero,
            elevation: CardElevation.dimen_10,
            radius: CshRadius.rad8,
            child: Container(
              height: cardHeight ?? Dimens.space_60,
              width: cardWidth ?? Dimens.space_60,
              alignment: Alignment.center,
              child: provider.isDataLoading
                  ? const Center(
                      child: SizedBox(
                        height: Dimens.space_20,
                        width: Dimens.space_20,
                        child: CircularProgressIndicator(),
                      ),
                    )
                  : Validator.isNullOrEmpty(imageUrl)
                      ? CshIcon(
                          FeatherIcons.camera,
                          iconSize: MobileIconSize.large,
                          iconColor: theme.shadowColor,
                        )
                      : fetchImage(ImageAssetHelper.imagePath("placeholder.png"), imageUrl,
                          fit: BoxFit.contain, isUseCacheImage: true),
            ),
          ),
        ],
      ),
    );
  }

  _showRetakeModal(BuildContext context, ThemeData theme) {
    showCshBottomSheet(
      context: context,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: Dimens.space_20, horizontal: Dimens.space_16),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Retake Image",
                  style: theme.primaryTextTheme.displaySmall,
                ),
                CshIcon(
                  FeatherIcons.x,
                  padding: EdgeInsets.zero,
                  iconSize: MobileIconSize.large,
                  onClick: () {
                    Navigator.of(context).pop();
                  },
                )
              ],
            ),
            const SizedBox(height: Dimens.space_20),
            ComboButton(
              firstBtnText: "Cancel",
              secondBtnText: "Retake",
              isFirstPrimary: true,
              padding: EdgeInsets.zero,
              buttonType: ButtonType.mini,
              firstBtnClick: () {
                // Dismiss dialog
                Navigator.of(context).pop();
              },
              secondBtnClick: () async {
                // Dismiss dialog
                Navigator.of(context).pop();
                _takeImage(context);
              },
            )
          ],
        ),
      ),
    );
  }

  Future<void> _takeImage(BuildContext context) async {
    final ImagePicker picker = ImagePicker();
    XFile? xFile = await picker.pickImage(source: ImageSource.camera, requestFullMetadata: false);
    if (xFile != null) {
      var compressedFile = await ImageUtil.compressImage(File(xFile.path));
      if (isImageMarkingRequired) {
        var file = await _getMarkingImage(context, compressedFile);
        if (file != null && file is File) {
          _uploadImage(context, file);
        }
      } else {
        _uploadImage(context, compressedFile);
      }
    }
  }

  _uploadImage(BuildContext context, File file) {
    var provider = ImageUploadProvider.of(context, listen: false);
    onMediaUploadingStarted?.call();
    provider.uploadImage(file).then((value) {
      if (onMediaUploaded != null) {
        onMediaUploaded!(value);
      }
    }, onError: (error) {
      CshSnackBar.error(context: context, message: error, snackBarPosition: SnackBarPosition.TOP);
    });
  }

  _getMarkingImage(BuildContext context, File compressedFile) {
    return Navigator.pushNamed(context, DisputeImageEditorScreen.route,
        arguments: DisputeImageEditorScreenArg(compressedFile));
  }
}
