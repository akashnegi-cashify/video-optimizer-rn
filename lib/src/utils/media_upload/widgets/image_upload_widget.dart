import 'dart:io';

import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_trc/src/utils/fetch_image_widget.dart';
import 'package:flutter_trc/src/utils/image_assest_helper.dart';
import 'package:flutter_trc/src/utils/media_upload/providers/image_upload_provider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../../../../qc/modules/qc_tester/calculator/resources/device_media_response.dart';

class ImageUploadOptimizerCard extends StatefulWidget {
  final ImageListData? dataModel;
  final Function(String?)? onMediaUploaded;

  const ImageUploadOptimizerCard({
    super.key,
    this.dataModel,
    this.onMediaUploaded,
  });

  @override
  State<ImageUploadOptimizerCard> createState() => _ImageUploadOptimizerCardState();
}

class _ImageUploadOptimizerCardState extends State<ImageUploadOptimizerCard> {
  final ImagePicker _picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return ChangeNotifierProvider(
      create: (_) => ImageUploadProvider(),
      lazy: false,
      builder: (BuildContext insideContext, __) {
        var provider = ImageUploadProvider.of(insideContext);
        return GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: () async {
            if (!Validator.isNullOrEmpty(provider.s3Url)) {
              _showRetakeModal(insideContext, theme);
            } else {
              XFile? selectedFile = await _picker.pickImage(source: ImageSource.camera);
              if (selectedFile != null) {
                provider.uploadImage(context, File(selectedFile.path), s3UrlCallback: (String url) {
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
                      : Validator.isNullOrEmpty(provider.s3Url)
                          ? CshIcon(
                              FeatherIcons.camera,
                              iconSize: MobileIconSize.xxLarge,
                              iconColor: theme.shadowColor,
                            )
                          : fetchImage(ImageAssetHelper.imagePath("placeholder.png"), provider.s3Url,
                              fit: BoxFit.cover),
                ),
              ),
              if (!Validator.isNullOrEmpty(widget.dataModel?.imageName)) ...[
                const SizedBox(height: Dimens.space_6),
                CshTextNew.h5(widget.dataModel!.imageName!),
              ],
            ],
          ),
        );
      },
    );
  }

  _showRetakeModal(BuildContext innerContext, ThemeData theme) {
    var provider = ImageUploadProvider.of(innerContext, listen: false);
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
                Navigator.of(context);
              },
              secondBtnClick: () async {
                Navigator.of(context).pop();
                XFile? selectedFile = await _picker.pickImage(source: ImageSource.camera);
                if (selectedFile != null) {
                  provider.uploadImage(context, File(selectedFile.path), s3UrlCallback: (String url) {
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
}
