import 'dart:async';

import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/qc/modules/qc_tester/disputed_image_capture/models/disputed_media_data_response.dart';
import 'package:flutter_trc/src/utils/media_upload/providers/image_upload_provider.dart';
import 'package:flutter_trc/src/utils/media_upload/widgets/general_image_upload_card.dart';
import 'package:flutter_trc/src/utils/media_upload/widgets/general_video_upload_card.dart';
import 'package:provider/provider.dart';

class MultipleImageVideoUploadWidget extends StatefulWidget {
  final Function(List<String> imageList, List<String> videoList) onMediaUploaded;

  const MultipleImageVideoUploadWidget({super.key, required this.onMediaUploaded});

  @override
  State<MultipleImageVideoUploadWidget> createState() => _MultipleImageVideoUploadWidgetState();
}

class _MultipleImageVideoUploadWidgetState extends State<MultipleImageVideoUploadWidget> {
  List<String> _imageList = [""];
  List<VideoUrlData> _videoList = [VideoUrlData("", videoThumbnail: "")];
  final FocusNode _nextButtonFocus = FocusNode();

  @override
  void initState() {
    scheduleMicrotask(() {
      FocusScope.of(context).requestFocus(_nextButtonFocus);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(Dimens.space_16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: Dimens.space_24),
          CshTextNew.subTitle1("Add Images"),
          const SizedBox(height: Dimens.space_16),
          SizedBox(
            height: 110,
            child: ListView.separated(
                itemBuilder: (context, index) {
                  var item = _imageList[index];
                  return ChangeNotifierProvider(
                    create: (_) => ImageUploadProvider(),
                    child: GeneralImageUploadCard(
                      cardHeight: 100,
                      cardWidth: 100,
                      imageUrl: item,
                      onMediaUploadingStarted: () {
                        setState(() {
                          if (_imageList.length < 10 && index == _imageList.length - 1) {
                            _imageList.add("");
                          }
                        });
                      },
                      onMediaUploaded: (url) {
                        setState(() {
                          _imageList[index] = url!;
                        });
                      },
                    ),
                  );
                },
                separatorBuilder: (context, index) {
                  return const SizedBox(width: Dimens.space_16);
                },
                itemCount: _imageList.length,
                scrollDirection: Axis.horizontal),
          ),
          const SizedBox(height: Dimens.space_24),
          CshTextNew.subTitle1("Add Videos"),
          const SizedBox(height: Dimens.space_16),
          SizedBox(
            height: 110,
            child: ListView.separated(
                itemBuilder: (context, index) {
                  var item = _videoList[index];
                  return GeneralVideoUploadCard(
                    cardHeight: 100.0,
                    cardWidth: 100.0,
                    videoUrl: item,
                    isCustomCameraVideo: true,
                    onMediaUploaded: (String? url, String? videoThumbnail) {
                      setState(() {
                        _videoList[index] = VideoUrlData(url ?? "", videoThumbnail: videoThumbnail);
                      });
                    },
                    onMediaUploadingStarted: () {
                      setState(() {
                        if (_videoList.length < 10 && index == _videoList.length - 1) {
                          _videoList.add(VideoUrlData("", videoThumbnail: ""));
                        }
                      });
                    },
                  );
                },
                separatorBuilder: (context, index) {
                  return const SizedBox(width: Dimens.space_16);
                },
                itemCount: _videoList.length,
                scrollDirection: Axis.horizontal),
          ),
          const SizedBox(height: Dimens.space_16),
          const Expanded(child: SizedBox.shrink()),
          TextButton(
            focusNode: _nextButtonFocus,
            onPressed: () {
              _imageList.removeWhere((element) => element.isEmpty);
              var videoUrlList = _videoList.map((e) => e.videoUrl).toList();
              videoUrlList.removeWhere((element) => element.isEmpty);
              widget.onMediaUploaded(_imageList, videoUrlList);
            },
            style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Theme.of(context).primaryColor)),
            child: Text(
              "Next",
              style: Theme.of(context).primaryTextTheme.displaySmall?.copyWith(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
