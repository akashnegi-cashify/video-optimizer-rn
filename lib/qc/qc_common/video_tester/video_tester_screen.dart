import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/qc/qc_common/video_tester/video_preview.dart';
import 'package:flutter_trc/src/common/utils/csh_video_picker.dart';

class VideoTesterScreen extends StatelessWidget {
  const VideoTesterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Video Tester"),
      ),
      body: Center(
        child: CshBigButton(
          text: 'Video Tester',
          onPressed: () {
            CshVideoPicker(context).pickVideo((file) {
              Navigator.push(context, MaterialPageRoute(
                builder: (context) {
                  return VideoPreview(filePath: file.path);
                },
              ));
            });
          },
        ),
      ),
    );
  }
}
