import 'dart:io';

import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../../../../qc/modules/qc_tester/calculator/resources/device_media_response.dart';
import '../providers/video_upload_provider.dart';

class VideoUploadOptimizerCard extends StatefulWidget {
  final ImageListData? dataModel;
  final Function(String?)? onMediaUploaded;

  const VideoUploadOptimizerCard({
    super.key,
    this.onMediaUploaded,
    this.dataModel,
  });

  @override
  State<VideoUploadOptimizerCard> createState() => _VideoUploadCardState();
}

class _VideoUploadCardState extends State<VideoUploadOptimizerCard> {

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return ChangeNotifierProvider(
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
                  height: MediaQuery.of(context).size.height * 0.20,
                  width: MediaQuery.of(context).size.width * 0.42,
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
                              iconSize: MobileIconSize.xxLarge,
                              iconColor: theme.shadowColor,
                            )
                          : Image.file(provider.videoThumbnailFile!, fit: BoxFit.cover),
                ),
              ),
              if (!Validator.isNullOrEmpty(widget.dataModel?.imageName)) ...[
                const SizedBox(height: Dimens.space_12),
                CshTextNew.h5(widget.dataModel!.imageName!),
              ],
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
                _takeVideo(context, provider);
              },
            )
          ],
        ),
      ),
    );
  }

  _takeVideo(BuildContext context, VideoUploadProvider provider) async {
    final ImagePicker picker = ImagePicker();
    XFile? selectedFile = await picker.pickVideo(source: ImageSource.camera);
    if (selectedFile != null) {
      provider.uploadVideo(File(selectedFile.path)).then((value) {
        if (widget.onMediaUploaded != null) {
          widget.onMediaUploaded!(value.$1);
        }
      }, onError: (error) {
        CshSnackBar.error(context: context, message: error, snackBarPosition: SnackBarPosition.TOP);
      });
    }
  }

}
