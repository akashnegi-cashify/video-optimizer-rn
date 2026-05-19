// Copyright 2013 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:async';
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:core/core.dart';
import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/qc/modules/external_audit/widgets/timer_widget.dart';
import 'package:flutter_trc/src/common/utils/disk_util.dart';
import 'package:flutter_trc/src/common/video_compression_mixin.dart';
import 'package:flutter_trc/src/common/video_recording_error_handling_mixin.dart';
import 'package:flutter_trc/src/libraries/firebase/remote_config_helper.dart';
import 'package:flutter_trc/src/libraries/logging/logging_service.dart';
import 'package:wakelock_plus/wakelock_plus.dart';

const int _DEFAULT_VIDEO_TIMER = 600;

abstract interface class VideoRecordingListener {
  onVideoRecorded(File file);
}

class VideoRecorderArguments {
  bool isVideoCompressionEnabled;
  VideoRecordingListener listener;
  final String? barcode;

  VideoRecorderArguments(this.listener, {this.isVideoCompressionEnabled = true, this.barcode});
}

class VideoRecorderWidget extends StatefulWidget {
  static String route = "/video_recoder";

  const VideoRecorderWidget({Key? key}) : super(key: key);

  @override
  State<VideoRecorderWidget> createState() => _VideoRecorderWidgetState();
}

class _VideoRecorderWidgetState extends State<VideoRecorderWidget>
    with VideoRecordingErrorHandlingMixin, VideoCompressionMixin {
  final StreamController<bool> _recordingController = StreamController.broadcast();

  bool _isLoading = true;
  String? barcode;
  bool _isCompressionStarted = false;
  late CameraController _cameraController;
  late int _videoRecorderTimeInSeconds;
  final GlobalKey<TimerWidgetState> timerWidgetKey = GlobalKey<TimerWidgetState>();

  bool _isCompressionEnabled = true;

  _VideoRecorderWidgetState() {
    _videoRecorderTimeInSeconds = _DEFAULT_VIDEO_TIMER;
  }

  VideoRecordingListener? _listener;

  @override
  void initState() {
    _videoRecorderTimeInSeconds = RemoteConfigHelper().getInt(AppRemoteConfig.KEY_VIDEO_RECORD_DURATION_IN_SEC);
    scheduleMicrotask(() {
      DiskUtil.getDeviceStorageInfo(isGb: true).then((value) {
        _logs("Available space is $value GB", LogType.info);
        if ((value ?? 0) > 1) {
          _logs("Comes in available space", LogType.info);
          Future.delayed(const Duration(milliseconds: 500), () => _getAvailableCamera());
          WakelockPlus.enable();
        } else {
          _logs("Comes in not available space", LogType.error);
          showInSufficientStorageDialog(context, onProceed: () {
            Navigator.of(context).pop(); // dismiss dialog
            Navigator.of(context).pop(); // back to previous screen
          });
        }
      });
    });
    super.initState();
  }

  void _getAvailableCamera() {
    availableCameras().then((cameras) {
      _logs("availableCameras successfully initialized", LogType.success);
      final backCamera = cameras.firstWhere((camera) => camera.lensDirection == CameraLensDirection.back);
      _cameraController = CameraController(
        backCamera,
        ResolutionPreset.medium,
        imageFormatGroup: ImageFormatGroup.nv21,
        enableAudio: false,
      );
      _logs("Camera controller successfully created", LogType.success);
      _cameraController.addListener(() => _recordingController.add(_cameraController.value.isRecordingVideo));
      _initCamera();
    }).catchError((error) {
      _logs("Error in availableCameras $error", LogType.error);
      showCameraNotAvailableDialog(context, message: error.toString(), onTryAgain: () {
        Navigator.of(context).pop(); // dismiss dialog
        _getAvailableCamera();
      });
      // return "";
    });
  }

  _initCamera() {
    _cameraController.initialize().then((value) {
      _logs("Camera controller successfully initialized", LogType.success);
      Future.delayed(const Duration(seconds: 1), () => _startVideoRecording());
      setState(() => _isLoading = false);
    }).catchError((error) {
      _logs("Error in Camera controller initialized $error", LogType.error);
      showCameraInitializationErrorDialog(context, message: error.toString(), onTryAgain: () {
        Navigator.of(context).pop(); // dismiss dialog
        _initCamera();
      });
    });
  }

  _resetTimers() {
    timerWidgetKey.currentState?.reset();
  }

  _stopVideoRecording() async {
    _logs("Calling _stopVideoRecording isRecordingVideo- ${_cameraController.value.isRecordingVideo}", LogType.info);
    if (_cameraController.value.isRecordingVideo == true) {
      _cameraController.stopVideoRecording().then((file) {
        _logs("StopVideoRecording successfully called", LogType.success);
        _cameraController.pausePreview();
        _logs("PausePreview successfully called", LogType.success);
        _resetTimers();
        _sendFileToListener(file);
      }).catchError((error) {
        _logs("Error in stopVideoRecording $error", LogType.error);
        showStopVideoErrorDialog(context, message: error.toString(), onTryAgain: () {
          Navigator.of(context).pop(); // dismiss dialog
          _stopVideoRecording();
        });
      });
    } else {
      _logs("Else part of isRecordingVideo  ${_cameraController.value.isRecordingVideo}", LogType.error);
      showStopVideoErrorDialog(
        context,
        message: "Recording is already closed. Please create new video",
        onTryAgain: () {
          Navigator.of(context).pop(); // dismiss dialog
          Navigator.of(context).pop(); // back to previous screen
        },
      );
    }
  }

  _startVideoRecording() async {
    try {
      await _cameraController.prepareForVideoRecording();
      _logs("PrepareForVideoRecording successfully initialized", LogType.success);
      await _cameraController.startVideoRecording();
      _logs("StartVideoRecording successfully initialized", LogType.success);
      timerWidgetKey.currentState?.startTimer();
    } on CameraException catch (e) {
      _logs("CameraException in startVideoRecording $e", LogType.error);
      handleException(context, error: e, onRetry: _startVideoRecording);
    } catch (e) {
      _logs("Catch error in startVideoRecording $e", LogType.error);
      if (mounted) {
        showCameraPrepareErrorDialog(context, title: "Video Recording Error!!", message: e.toString(), onTryAgain: () {
          Navigator.pop(context);
          _startVideoRecording();
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    VideoRecorderArguments? arg = ModalRoute.of(context)?.settings.arguments as VideoRecorderArguments?;
    barcode = arg?.barcode;
    ThemeData theme = Theme.of(context);
    assert(arg != null);
    _listener ??= arg!.listener;
    _isCompressionEnabled = arg!.isVideoCompressionEnabled;
    if (_isLoading) {
      return Container(
        color: Colors.white,
        child: const Center(
          child: CircularProgressIndicator(),
        ),
      );
    } else {
      return PopScope(
        canPop: (_cameraController.value.isRecordingVideo || _isCompressionStarted) ? false : true,
        onPopInvoked: (didPop) {
          if (!didPop) {
            if (_cameraController.value.isRecordingVideo) {
              CshSnackBar.error(
                  context: context, message: "Video Recording is in progress", snackBarPosition: SnackBarPosition.TOP);
            }
            if (_isCompressionStarted) {
              CshSnackBar.error(
                  context: context, message: "Video Optimizing is in progress", snackBarPosition: SnackBarPosition.TOP);
            }
          }
        },
        child: Scaffold(
          appBar: const CshHeader("Video Recorder", showBackBtn: true),
          body: Center(
            child: Stack(
              children: [
                CameraPreview(
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
                Positioned(
                  top: Dimens.space_24,
                  left: 0,
                  right: 0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TimerWidget(_videoRecorderTimeInSeconds, barcode: barcode, key: timerWidgetKey, onTimerEnd: () {
                        _stopVideoRecording();
                      }),
                    ],
                  ),
                ),
                Positioned(bottom: Dimens.space_24, left: 0, right: 0, child: _buildRecordButton(theme)),
                if (_isCompressionStarted)
                  Positioned(
                    bottom: 0,
                    top: 0,
                    left: Dimens.space_16,
                    right: Dimens.space_16,
                    child: buildProgressContainer(theme),
                  ),
              ],
            ),
          ),
        ),
      );
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

  _sendFileToListener(XFile xFile) async {
    if (_isCompressionEnabled) {
      try {
        setState(() {
          _isCompressionStarted = true;
        });

        _logs("Compression started", LogType.info);
        compressVideo(xFile.path, timerWidgetKey.currentState!.getVideoTimeInSec()).then((compressedVideoPath) {
          _logs("Compression successfully completed", LogType.success);
          Navigator.pop(context);
          _listener?.onVideoRecorded(File(compressedVideoPath));
        }, onError: (error) async {
          _logs("Error in Compression $error", LogType.error);
          var file = File(xFile.path);
          if (xFile.path.contains(".temp")) {
            file = await _getRenamedFile(xFile.path);
          }
          Navigator.pop(context);
          _listener?.onVideoRecorded(file);
        });
      } catch (e) {
        _logs("Catch in Compression $e", LogType.error);
        if (mounted) {
          var file = File(xFile.path);
          if (xFile.path.contains(".temp")) {
            file = await _getRenamedFile(xFile.path);
          }
          Navigator.of(context).pop();
          CshSnackBar.error(context: context, message: e.toString());
          _listener?.onVideoRecorded(file);
        }
      }
    } else {
      File file = File(xFile.path);
      Navigator.pop(context);
      _listener?.onVideoRecorded(file);
    }
  }

  _buildRecordButton(ThemeData theme) {
    return StreamBuilder<bool>(
      stream: _recordingController.stream,
      builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
        bool isRecording = snapshot.data ?? false;
        return FloatingActionButton(
          backgroundColor: theme.colorScheme.error,
          onPressed: _isCompressionStarted ? null : () => isRecording ? _stopVideoRecording() : _startVideoRecording(),
          child: Icon((isRecording || _isCompressionStarted) ? Icons.stop : Icons.play_arrow),
        );
      },
    );
  }

  @override
  void dispose() {
    try {
      _cameraController.dispose();
    } catch (e) {
      Logger.error('mydebug-----_VideoRecorderWidgetState.dispose', ['error: $e']);
    }

    WakelockPlus.disable();
    super.dispose();
  }

  Future<File> _getRenamedFile(String path) async {
    var file = File(path);
    String oldExtension = path.split('.').last;
    String newPath = path.replaceAll(oldExtension, "mp4");
    file = await file.rename(newPath);
    return file;
  }

  _logs(String log, LogType type) {
    LoggingService.log(log, barcode: barcode, type: type);
  }
}
