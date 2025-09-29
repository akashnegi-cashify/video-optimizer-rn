import 'dart:async';
import 'dart:io';

import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_trc/qc/modules/qc_tester/disputed_image_capture/models/disputed_media_data_response.dart';
import 'package:flutter_trc/src/common/utils/csh_video_picker.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../providers/video_upload_provider.dart';

class GeneralVideoUploadCard extends StatelessWidget {
  final Function(String?, String?)? onMediaUploaded;
  final double? cardHeight;
  final double? cardWidth;
  final VideoUrlData? videoUrl;
  final VoidCallback? onMediaUploadingStarted;
  final bool isCustomCameraVideo;

  const GeneralVideoUploadCard({
    super.key,
    this.cardWidth,
    this.cardHeight,
    this.videoUrl,
    this.onMediaUploaded,
    this.onMediaUploadingStarted,
    this.isCustomCameraVideo = false,
  });

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
            if (!Validator.isNullOrEmpty(videoUrl?.videoUrl)) {
              _showRetakeModal(context, theme, provider);
            } else {
              _takeVideo(context, provider);
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
                      : Validator.isNullOrEmpty(videoUrl?.videoThumbnail)
                          ? CshIcon(FeatherIcons.video, iconSize: MobileIconSize.large, iconColor: theme.shadowColor)
                          : Image.file(File(videoUrl!.videoThumbnail!), fit: BoxFit.cover),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  _showRetakeModal(BuildContext context, ThemeData theme, VideoUploadProvider provider) {
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
                Text("Retake Video", style: theme.primaryTextTheme.displaySmall),
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
                _takeVideo(context, provider);
              },
            )
          ],
        ),
      ),
    );
  }

  _takeVideo(BuildContext context, VideoUploadProvider provider) async {
    File? videoFile;
    if (isCustomCameraVideo) {
      videoFile = await _customVideo(context);
      _uploadVideo(videoFile, provider, context);
    } else {
      XFile? selectedFile = await ImagePicker().pickVideo(source: ImageSource.camera);
      if (selectedFile != null) {
        videoFile = File(selectedFile.path);
        _uploadVideo(videoFile, provider, context);
      }
    }
  }

  _uploadVideo(File? videoFile, VideoUploadProvider provider, BuildContext context) {
    if (videoFile != null) {
      onMediaUploadingStarted?.call();
      provider.uploadVideo(videoFile, isCompressed: !isCustomCameraVideo).then((value) {
        String videoUrl = value.$1;
        String? videoThumbnail = value.$2;
        if (onMediaUploaded != null) {
          onMediaUploaded!(videoUrl, videoThumbnail);
        }
      }, onError: (error) {
        if (context.mounted) {
          CshSnackBar.error(context: context, message: error);
        }
      });
    }
  }

  Future<File> _customVideo(BuildContext context) {
    var completer = Completer<File>();
    CshVideoPicker(context).pickVideo((file) {
      completer.complete(file);
    });
    return completer.future;
  }
}
