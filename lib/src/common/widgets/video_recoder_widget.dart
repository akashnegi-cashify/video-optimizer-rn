// Copyright 2013 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:async';
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:video_compress/video_compress.dart';

class VideoRecorderWidget extends StatefulWidget {
  final bool isCompressionEnabled;

  const VideoRecorderWidget({Key? key, this.isCompressionEnabled = true}) : super(key: key);

  @override
  VideoRecorderWidgetState createState() => VideoRecorderWidgetState();
}

class VideoRecorderWidgetState extends State<VideoRecorderWidget> {
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
      _cameraController = CameraController(backCamera, ResolutionPreset.medium, enableAudio: false);

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

      if (!widget.isCompressionEnabled) {
        return Future.value(File(file.path));
      }
      var completer = Completer<File>();

      CshLoading().showLoading(context);
      VideoCompress.compressVideo(file.path, deleteOrigin: true, includeAudio: false).then((value) {
        CshLoading().hideLoading(context);
        if (value?.file != null) {
          completer.complete(value?.file);
        }
      });
      return completer.future;
    } catch (e) {
      return Future.value(null);
    }
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
      return Center(child: CameraPreview(_cameraController));
    }
  }

  @override
  Future<void> dispose() async {
    super.dispose();
    if (Validator.isTrue(_cameraController.value.isRecordingVideo)) {
      await _cameraController.stopVideoRecording();
    }
    await _cameraController.dispose();
  }
}
