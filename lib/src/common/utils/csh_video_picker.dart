import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_trc/qc/modules/external_audit/widgets/video_recoder_widget.dart';

class CshVideoPicker implements VideoRecordingListener {
  // create factory methods
  CshVideoPicker._private();

  static final CshVideoPicker _instance = CshVideoPicker._private();

  late BuildContext mContext;
  late Function(File file) mOnVideoRecorded;

  factory CshVideoPicker(BuildContext context) {
    _instance.mContext = context;
    return _instance;
  }

  void pickVideo(Function(File file) onVideoRecorded) {
    _instance.mOnVideoRecorded = onVideoRecorded;
    Navigator.pushNamed(mContext, VideoRecorderWidget.route, arguments: VideoRecorderArguments(this));
  }

  @override
  onVideoRecorded(File file) {
    mOnVideoRecorded(file);
  }
}
