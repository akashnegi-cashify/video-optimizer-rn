import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/src/utils/media_upload/providers/image_upload_provider.dart';
import 'package:flutter_trc/src/utils/media_upload/widgets/general_image_upload_card.dart';
import 'package:provider/provider.dart';

import '../../../../../src/utils/media_upload/widgets/general_video_upload_card.dart';
import '../models/disputed_media_data_response.dart';
import '../providers/dispute_image_capture_provider.dart';

class DisputedImageInfoWidget extends StatefulWidget {
  final DisputeMediaInfoData? dataModel;

  const DisputedImageInfoWidget({
    super.key,
    this.dataModel,
  });

  @override
  State<DisputedImageInfoWidget> createState() => _DisputedImageInfoWidgetState();
}

class _DisputedImageInfoWidgetState extends State<DisputedImageInfoWidget> {
  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var provider = DisputeImageCaptureProvider.of(context);
    return Container(
      alignment: Alignment.centerLeft,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(Dimens.space_12),
        border: Border.all(color: theme.shadowColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: Dimens.space_60,
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: Dimens.space_4, horizontal: Dimens.space_8),
            decoration: BoxDecoration(
              color: theme.disabledColor,
              borderRadius: const BorderRadius.only(
                topRight: Radius.circular(Dimens.space_12),
                topLeft: Radius.circular(Dimens.space_12),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (!Validator.isNullOrEmpty(widget.dataModel?.label)) ...[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const SizedBox.shrink(),
                      Expanded(
                        child: Text(
                          widget.dataModel!.label!,
                          style: theme.primaryTextTheme.headlineMedium,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: Dimens.space_6)
                ],
                if (!Validator.isNullOrEmpty(widget.dataModel?.subHeading)) ...[
                  if (Validator.isNullOrEmpty(widget.dataModel?.label)) const SizedBox(height: Dimens.space_6),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const SizedBox.shrink(),
                      Expanded(
                        child: Text(
                          widget.dataModel!.subHeading!,
                          style: theme.primaryTextTheme.headlineSmall,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ]
              ],
            ),
          ),
          if (widget.dataModel?.imageCount != null) ...[
            const SizedBox(height: Dimens.space_16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: Dimens.space_12),
              child: Wrap(
                alignment: WrapAlignment.start,
                direction: Axis.horizontal,
                runSpacing: Dimens.space_16,
                spacing: Dimens.space_8,
                children: List.generate(
                  widget.dataModel!.imageCount!,
                  (index) => ChangeNotifierProvider<ImageUploadProvider>(
                    create: (_) => ImageUploadProvider(),
                    child: GeneralImageUploadCard(
                      cardHeight: 100.0,
                      cardWidth: 100.0,
                      imageUrl: widget.dataModel?.imageS3Urls?[index],
                      onMediaUploaded: (String? url) {
                        widget.dataModel?.imageS3Urls?[index] = url ?? "";
                        provider.checkSubmitButtonStatus();
                        provider.notifyListeners();
                      },
                    ),
                  ),
                ),
              ),
            )
          ],
          if (widget.dataModel?.videoCount != null) ...[
            const SizedBox(height: Dimens.space_16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: Dimens.space_12),
              child: Wrap(
                direction: Axis.horizontal,
                runSpacing: Dimens.space_16,
                spacing: Dimens.space_8,
                children: List.generate(
                  widget.dataModel!.videoCount!,
                  (index) => GeneralVideoUploadCard(
                    cardHeight: 100.0,
                    cardWidth: 100.0,
                    onMediaUploaded: (String? url) {
                      widget.dataModel?.videoS3urls?[index] = url ?? "";
                      provider.checkSubmitButtonStatus();
                      provider.notifyListeners();
                    },
                  ),
                ),
              ),
            )
          ],
          const SizedBox(
            height: Dimens.space_20,
          )
        ],
      ),
    );
  }
}
