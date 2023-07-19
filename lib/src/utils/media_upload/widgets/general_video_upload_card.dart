import 'dart:io';

import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../providers/video_upload_provider.dart';

class GeneralVideoUploadCard extends StatefulWidget {
  final Function(String?)? onMediaUploaded;
  final double? cardHeight;
  final double? cardWidth;

  const GeneralVideoUploadCard({
    super.key,
    this.cardWidth,
    this.cardHeight,
    this.onMediaUploaded,
  });

  @override
  State<GeneralVideoUploadCard> createState() => _GeneralVideoUploadCardState();
}

class _GeneralVideoUploadCardState extends State<GeneralVideoUploadCard> with AutomaticKeepAliveClientMixin {
  final ImagePicker _picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return ChangeNotifierProvider<VideoUploadProvider>(
      create: (_) => VideoUploadProvider(),
      lazy: false,
      builder: (BuildContext insideContext, __) {
        var provider = VideoUploadProvider.of(insideContext);
        return GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: () async {
            if (!Validator.isNullOrEmpty(provider.videoS3Url)) {
              _showRetakeModal(insideContext, theme);
            } else {
              XFile? selectedFile = await _picker.pickVideo(source: ImageSource.camera);
              if (selectedFile != null) {
                provider.uploadVideo(context, File(selectedFile.path), s3UrlCallback: (String url) {
                  if (widget.onMediaUploaded != null) {
                    widget.onMediaUploaded!(url);
                  }
                });
              }
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
                      : provider.videoThumbnailFile == null
                          ? CshIcon(
                              FeatherIcons.video,
                              iconSize: MobileIconSize.large,
                              iconColor: theme.shadowColor,
                            )
                          : Image.file(provider.videoThumbnailFile!, fit: BoxFit.cover),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  _showRetakeModal(BuildContext innerContext, ThemeData theme) {
    var provider = VideoUploadProvider.of(innerContext, listen: false);
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
                  "Retake Video",
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
                Navigator.of(context);
              },
              secondBtnClick: () async {
                Navigator.of(context).pop();
                XFile? selectedFile = await _picker.pickVideo(source: ImageSource.camera);
                if (selectedFile != null) {
                  provider.uploadVideo(context, File(selectedFile.path), s3UrlCallback: (String url) {
                    if (widget.onMediaUploaded != null) {
                      widget.onMediaUploaded!(url);
                    }
                  });
                }
              },
            )
          ],
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
