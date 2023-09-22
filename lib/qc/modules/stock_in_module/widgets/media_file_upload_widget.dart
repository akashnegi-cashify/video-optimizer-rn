import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../src/utils/media_upload/providers/image_upload_provider.dart';
import '../../../../src/utils/media_upload/widgets/general_image_upload_card.dart';
import '../../../../src/utils/media_upload/widgets/general_video_upload_card.dart';
import '../../qc_tester/disputed_image_capture/models/disputed_media_data_response.dart';
import '../models/validate_awb_response.dart';
import '../l10n.dart';

class MediaFileUploadWidget extends StatelessWidget {
  final Map<String, Items>? mapData;

  const MediaFileUploadWidget({
    super.key,
    this.mapData,
  });

  @override
  Widget build(BuildContext context) {
    var l10n = L10n(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(
          child: ListView.separated(
            shrinkWrap: true,
            padding: const EdgeInsets.all(Dimens.space_8),
            itemBuilder: (context, index) {
              var mapItem = mapData?[mapData?.keys.elementAt(index)];

              var imageList = mapItem?.imageUrls ?? [];
              var videoList =
                  mapItem?.videoUrls?.map((e) => VideoUrlData(e ?? '', videoThumbnail: null)).toList() ?? [];

              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Flexible(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        _Header(header: mapItem?.label ?? ''),
                        const SizedBox(height: Dimens.space_8),
                        GridView.builder(
                          padding: EdgeInsets.zero,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: imageList.length,
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
                          itemBuilder: (context, indexx) {
                            return ChangeNotifierProvider<ImageUploadProvider>(
                              create: (_) => ImageUploadProvider(),
                              child: Selector<ImageUploadProvider, String>(
                                builder: (BuildContext context, value, Widget? child) {
                                  return GeneralImageUploadCard(
                                    cardHeight: 100.0,
                                    cardWidth: 100.0,
                                    isImageMarkingRequired: true,
                                    imageUrl: imageList[indexx],
                                    onMediaUploaded: (String? url) {
                                      imageList[indexx] = url;
                                    },
                                  );
                                },
                                selector: (BuildContext context, ImageUploadProvider provider) {
                                  return mapItem?.imageUrls?[indexx] ?? '';
                                },
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                  Flexible(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        _Header(header: mapItem?.label ?? ''),
                        const SizedBox(height: Dimens.space_8),
                        GridView.builder(
                          padding: EdgeInsets.zero,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: videoList.length,
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
                          itemBuilder: (context, indexx) {
                            return StatefulBuilder(
                              builder: (BuildContext context, void Function(void Function()) setState) {
                                return GeneralVideoUploadCard(
                                  cardHeight: 100.0,
                                  cardWidth: 100.0,
                                  videoUrl: videoList[indexx],
                                  onMediaUploaded: (String? url, String? videoThumbnail) {
                                    setState(() {
                                      videoList[indexx] = VideoUrlData(url ?? "", videoThumbnail: videoThumbnail);
                                      mapItem?.videoUrls?[indexx] = url;
                                    });
                                  },
                                );
                              },
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              );
            },
            separatorBuilder: (context, child) {
              return const SizedBox(height: Dimens.space_4);
            },
            itemCount: mapData?.length ?? 0,
          ),
        ),
        const SizedBox(height: Dimens.space_8),
        CshCard(
            child: CshBigButton(
          text: l10n.done,
          onPressed: () => _onDone(context,l10n),
        )),
      ],
    );
  }

  void _onDone(BuildContext context,L10n l10n) {
    if(_checkAllMediaFileUploaded()){
      Navigator.pop(context, mapData);
    }
    else{
      CshSnackBar.error(context: context, message: l10n.pleaseUploadAllMediaFiles);
    }
  }

  bool _checkAllMediaFileUploaded() {
    bool result = false;
    mapData?.forEach((key, value) {
      var r1 = value.videoUrls?.any((element) => isEmpty(element)) ?? false;
      var r2 = value.imageUrls?.any((element) => isEmpty(element)) ?? false;

      if ((r1 && r2) == false) {
        result = false;
        return;
      } else {
        result = true;
      }
    });
    return result;
  }
}

class _Header extends StatelessWidget {
  final String header;

  const _Header({required this.header});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: Dimens.space_8, vertical: Dimens.space_6),
      decoration: BoxDecoration(color: theme.primaryColor, borderRadius: BorderRadius.circular(Dimens.space_4)),
      child: CshTextNew(
        header,
        textStyle: theme.textTheme.displayMedium?.copyWith(
          color: theme.colorScheme.background,
        ),
      ),
    );
  }
}
