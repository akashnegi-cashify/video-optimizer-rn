// Copyright 2013 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:async';
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/src/common/utils/file_util.dart';
import 'package:flutter_trc/src/common/video_compression_mixin.dart';
import 'package:video_player/video_player.dart';

class VideoRecorderWidget extends StatefulWidget {
  final bool isCompressionEnabled;

  const VideoRecorderWidget({Key? key, this.isCompressionEnabled = true}) : super(key: key);

  @override
  VideoRecorderWidgetState createState() => VideoRecorderWidgetState();
}

class VideoRecorderWidgetState extends State<VideoRecorderWidget> with VideoCompressionMixin {
  bool _isLoading = true;
  late CameraController _cameraController;

  @override
  void initState() {
    _initCamera();
    super.initState();
  }

  void _showError(String message) {
    CshSnackBar.error(context: context, message: message);
  }

  _initCamera() async {
    try {
      final cameras = await availableCameras();
      final backCamera = cameras.firstWhere((camera) => camera.lensDirection == CameraLensDirection.back);
      _cameraController = CameraController(backCamera, ResolutionPreset.medium,
          enableAudio: false, imageFormatGroup: ImageFormatGroup.nv21);

      await _cameraController.initialize();
      setState(() => _isLoading = false);
      Future.delayed(const Duration(milliseconds: 200), () {
        _startVideoRecording();
      });
    } on CameraException catch (e) {
      _handleException(e);
    }
  }

  _handleException(CameraException e) {
    switch (e.code) {
      case 'CameraAccessDenied':
        _showError('You have denied camera access.');
        break;
      case 'CameraAccessDeniedWithoutPrompt':
        // iOS only
        _showError('Please go to Settings app to enable camera access.');
        break;
      case 'CameraAccessRestricted':
        // iOS only
        _showError('Camera access is restricted.');
        break;
      case 'AudioAccessDenied':
        _showError('You have denied audio access.');
        break;
      case 'AudioAccessDeniedWithoutPrompt':
        // iOS only
        _showError('Please go to Settings app to enable audio access.');
        break;
      case 'AudioAccessRestricted':
        // iOS only
        _showError('Audio access is restricted.');
        break;
      default:
        _showError('Error: ${e.code}\n${e.description}');
        break;
    }
  }

  Future<File?> stopVideoRecording() async {
    try {
      final file = await _cameraController.stopVideoRecording();
      _cameraController.pausePreview();

      File(file.path).logFileSize();
      if (!widget.isCompressionEnabled) {
        return Future.value(File(file.path));
      }
      var completer = Completer<File>();

      CshLoading().showLoading(context);
      _getCompressedFile(file.path).then((compressedFile) {
        CshLoading().hideLoading(context);
        if (compressedFile != null) {
          compressedFile.logFileSize();
          completer.complete(compressedFile);
        }
      });

      return completer.future;
    } catch (e) {
      return Future.value(null);
    }
  }

  Future<File?> _getCompressedFile(String filePath) async {
    var completer = Completer<File?>();
    VideoPlayerController controller = VideoPlayerController.file(File(filePath));
    await controller.initialize();
    String videoConfig =
        '{"videoCodec":"libx264","videoPreset":"superfast","crf":30,"fontSize":24,"fontColor":"white","borderColor":"black","addTimeStamp":true,"isRemoveAudio":true}';
    compressVideo(filePath, controller.value.duration.inSeconds, config: videoConfig).then((compressedVideoPath) {
      completer.complete(File(compressedVideoPath));
    }, onError: (error) async {
      var file = File(filePath);
      if (file.path.contains(".temp")) {
        file = await _getRenamedFile(filePath);
      }
      completer.complete(file);
    });
    return completer.future;
  }

  _startVideoRecording() async {
    try {
      await _cameraController.prepareForVideoRecording();
      await _cameraController.startVideoRecording();
      // _startVideoTimer = Timer.periodic(const Duration(seconds: 1), (timer) async {
      //   setState(() => _startVideoTimerInSec--);
      //   if (_startVideoTimerInSec == 0) {
      //     timer.cancel();
      //     await _cameraController.prepareForVideoRecording();
      //     await _cameraController.startVideoRecording();
      //     _startVideoRecordingTimer();
      //   }
      // });
    } on CameraException catch (e) {
      _handleException(e);
    }
  }

  void onViewFinderTap(TapDownDetails details, BoxConstraints constraints) {
    final offset = Offset(
      details.localPosition.dx / constraints.maxWidth,
      details.localPosition.dy / constraints.maxHeight,
    );
    _cameraController.setExposurePoint(offset);
    _cameraController.setFocusPoint(offset);
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return Container(
        color: Colors.white,
        child: const Center(
          child: CircularProgressIndicator(),
        ),
      );
    } else {
      return Center(
        child: CameraPreview(
          _cameraController,
          child: LayoutBuilder(
            builder: (context, constraints) {
              return GestureDetector(
                onTapDown: (details) {
                  onViewFinderTap(details, constraints);
                },
              );
            },
          ),
        ),
      );
    }
  }

  Future<File> _getRenamedFile(String path) async {
    var file = File(path);
    String oldExtension = path.split('.').last;
    String newPath = path.replaceAll(oldExtension, "mp4");
    file = await file.rename(newPath);
    return file;
  }

  Future<void> disposeCamera() async {
    return await _cameraController.dispose();
  }
}
