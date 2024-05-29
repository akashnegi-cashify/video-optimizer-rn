import 'dart:async';
import 'dart:io';

import 'package:core/core.dart';
import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/qc/qc_common/video_tester/video_preview.dart';
import 'package:flutter_trc/src/common/utils/file_util.dart';
import 'package:flutter_trc/src/common/utils/video_util.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_player/video_player.dart';

class D2CVideoWidget extends StatefulWidget {
  const D2CVideoWidget({super.key});

  @override
  State<D2CVideoWidget> createState() => _D2CVideoWidgetState();
}

class _D2CVideoWidgetState extends State<D2CVideoWidget> {
  int _videoCompressionProgress = 0;
  bool _startVideoCompression = false;

  @override
  void initState() {
    scheduleMicrotask(() {
      ImagePicker imagePicker = ImagePicker();
      imagePicker.pickVideo(source: ImageSource.camera).then((value) {
        if (value != null) {
          _compressVideo(value.path);
        }
      });
    });
    super.initState();
  }

  _compressVideo(String path) async {
    try {
      setState(() {
        _startVideoCompression = true;
      });
      CshLoading().showLoading(context);
      File(path).logFileSize();
      VideoPlayerController videoPlayerController = VideoPlayerController.file(File(path));
      await videoPlayerController.initialize();
      VideoUtil.compressVideo(path, videoPlayerController.value.duration.inSeconds, onProgress: (value) {
        Logger.debug('mydebug-----_VideoRecorderWidgetState._sendFileToListener onProgress', ['value: $value']);
        setState(() {
          _videoCompressionProgress = value;
        });
      }).then((String? outputPath) {
        CshLoading().hideLoading(context);
        if (outputPath != null) {
          File(outputPath).logFileSize();
          // TODO: upload video instead of preview video
          Navigator.push(context, MaterialPageRoute(
            builder: (context) {
              return VideoPreview(filePath: outputPath);
            },
          ));
          // _uploadVideo(outputPath);
        }
      }, onError: (error) {
        CshSnackBar.error(context: context, message: error.toString());
      }).whenComplete(() {
        setState(() {
          _startVideoCompression = false;
        });
      });
    } catch (e) {
      if (mounted) {
        setState(() {
          _startVideoCompression = false;
        });
        CshSnackBar.error(context: context, message: e.toString());
        Navigator.of(context).pop();
      }
    }
  }

  _uploadVideo(String filePath) {
    // TODO: upload file and then call api to save this data
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    if (_startVideoCompression) {
      return _buildProgressContainer(theme);
    }
    return const Center(child: Text("Video Uploading module"));
  }

  Widget _buildProgressContainer(ThemeData theme) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CshCard(
            padding: const EdgeInsets.all(Dimens.space_24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CshTextNew.h3("Optimizing Video - $_videoCompressionProgress%"),
                const SizedBox(height: Dimens.space_16),
                LinearProgressIndicator(
                  value: _videoCompressionProgress / 100,
                  valueColor: AlwaysStoppedAnimation<Color>(theme.primaryColor),
                  backgroundColor: theme.primaryColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(Dimens.space_6),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
