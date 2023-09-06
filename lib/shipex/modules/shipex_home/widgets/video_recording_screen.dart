import 'dart:async';
import 'dart:io';

import 'package:core/core.dart';
import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/src/common/utils/file_util.dart';
import 'package:flutter_trc/src/common/widgets/video_recoder_widget.dart';
import 'package:flutter_trc/src/utils/media_upload/media_optimiser_utils.dart';
import 'package:flutter_trc/src/utils/media_upload/resource/media_content_type.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import 'package:video_compress/video_compress.dart';

class VideoRecordingScreen extends StatefulWidget {
  VideoRecordingScreen({super.key});

  @override
  State<VideoRecordingScreen> createState() => _VideoRecordingScreenState();
}

class _VideoRecordingScreenState extends State<VideoRecordingScreen> {
  final GlobalKey<VideoRecorderWidgetState> _videoRef = GlobalKey<VideoRecorderWidgetState>();

  Timer? _timer;
  int _seconds = 0;

  @override
  void initState() {
    // _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
    //   setState(() {
    //     _seconds++;
    //   });
    // });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CshHeader("Video Recording"),
      body: Column(
        children: [
          CshTextNew.subTitle1(_seconds.toString()),
          // Expanded(child: VideoRecorderWidget(isCompressionEnabled: true, key: _videoRef)),
          CshBigButton(
              text: "Stop Recording",
              onPressed: () async {
                _timer?.cancel();
                // File? videoFile = await _videoRef.currentState?.stopVideoRecording();

                var videoFile = await ImagePicker().pickVideo(source: ImageSource.gallery);

                File(videoFile!.path).logFileSize();
                var date1 = DateTime.now();

                var compressedFile = await VideoCompress.compressVideo(
                  videoFile!.path,
                  deleteOrigin: true,
                  includeAudio: false,
                  frameRate: 30,
                  quality: VideoQuality.MediumQuality,
                );
                // var compressedFile = await NativeCommunication.compressVideo(videoFile!.path,
                //     deleteOrigin: true, includeAudio: false, frameRate: 30, frameInterval: 3);

                if (compressedFile != null) {
                  compressedFile.file!.logFileSize();
                  String fileName = path.basename(compressedFile.path!);
                  MediaUploadUtil()
                      .uploadMediaWithType(
                          mediaFile: compressedFile.file!, fileName: fileName, contentType: MediaContentType.mp4)
                      .then((value) {
                    Logger.debug('mydebug-----_VideoRecordingScreenState.build', [value]);
                  }, onError: (e) {
                    Logger.debug('mydebug-----_VideoRecordingScreenState.build--error', [e]);
                  });
                }
              }),
        ],
      ),
    );
  }
}
