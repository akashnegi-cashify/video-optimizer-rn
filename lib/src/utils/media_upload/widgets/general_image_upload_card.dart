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

class GeneralImageUploadCard extends StatefulWidget {
  final Function(String?)? onMediaUploaded;
  final double? cardHeight;
  final double? cardWidth;
  final String? imageUrl;

  const GeneralImageUploadCard({
    super.key,
    this.onMediaUploaded,
    this.cardHeight,
    this.cardWidth,
    this.imageUrl,
  });

  @override
  State<GeneralImageUploadCard> createState() => _GeneralImageUploadCardState();
}

class _GeneralImageUploadCardState extends State<GeneralImageUploadCard>
    with AutomaticKeepAliveClientMixin, DisputedImageEditorListener {

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);

    var provider = ImageUploadProvider.of(context);

    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () async {
        if (!Validator.isNullOrEmpty(provider.s3Url)) {
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
              height: widget.cardHeight ?? Dimens.space_60,
              width: widget.cardWidth ?? Dimens.space_60,
              alignment: Alignment.center,
              child: provider.isDataLoading
                  ? const Center(
                      child: SizedBox(
                        height: Dimens.space_20,
                        width: Dimens.space_20,
                        child: CircularProgressIndicator(),
                      ),
                    )
                  : Validator.isNullOrEmpty(provider.s3Url)
                      ? CshIcon(
                          FeatherIcons.camera,
                          iconSize: MobileIconSize.large,
                          iconColor: theme.shadowColor,
                        )
                      : fetchImage(ImageAssetHelper.imagePath("placeholder.png"), widget.imageUrl,
                          fit: BoxFit.cover, isUseCacheImage: true),
            ),
          ),
        ],
      ),
    );
  }

  _showRetakeModal(BuildContext innerContext, ThemeData theme) {
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
                Navigator.of(context).pop();
              },
              secondBtnClick: () async {
                Navigator.of(context).pop();
                _takeImage(context);
              },
            )
          ],
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;

  Future<void> _takeImage(BuildContext context) async {
    final ImagePicker picker = ImagePicker();
    XFile? xFile = await picker.pickImage(source: ImageSource.camera);
    if (xFile != null && mounted) {
      File selectedFile = File(xFile.path);
      ImageUtil.compressImage(selectedFile).then((targetFile) {
        selectedFile = targetFile;
      }).whenComplete(() {
        Navigator.pushNamed(context, DisputeImageEditorScreen.route,
            arguments: DisputeImageEditorScreenArg(selectedFile, this));
      });
    }
  }

  @override
  void onImageEditComplete(File editedFile) {
    var provider = ImageUploadProvider.of(context, listen: false);
    provider.uploadImage(context, File(editedFile.path), s3UrlCallback: (String url) {
      if (widget.onMediaUploaded != null) {
        widget.onMediaUploaded!(url);
      }
    });
  }
}
