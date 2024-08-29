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
import 'package:wakelock_plus/wakelock_plus.dart';

const int _DEFAULT_VIDEO_TIMER = 600;
const int _VIDEO_NOT_INITIALIZED_TIMER = 3;

abstract interface class VideoRecordingListener {
  onVideoRecorded(File file);
}

class VideoRecorderArguments {
  bool isVideoCompressionEnabled;
  VideoRecordingListener listener;

  VideoRecorderArguments(this.listener, {this.isVideoCompressionEnabled = true});
}

class VideoRecorderWidget extends StatefulWidget {
  static String route = "/video_recoder";

  const VideoRecorderWidget({Key? key}) : super(key: key);

  @override
  State<VideoRecorderWidget> createState() => _VideoRecorderWidgetState();
}

class _VideoRecorderWidgetState extends State<VideoRecorderWidget>
    with VideoRecordingErrorHandlingMixin, VideoCompressionMixin {
  bool _isLoading = true;
  bool _isRecording = false;
  bool _isCompressionStarted = false;
  late CameraController? _cameraController;
  late int _videoRecorderTimeInSeconds;
  final GlobalKey<TimerWidgetState> timerWidgetKey = GlobalKey<TimerWidgetState>();

  bool _isCompressionEnabled = true;

  _VideoRecorderWidgetState() {
    _videoRecorderTimeInSeconds = _DEFAULT_VIDEO_TIMER;
  }

  VideoRecordingListener? _listener;
  final FocusNode _stopVideoFocusNode = FocusNode(); // used for physical scanner button

  @override
  void initState() {
    _videoRecorderTimeInSeconds = RemoteConfigHelper().getInt(AppRemoteConfig.KEY_VIDEO_RECORD_DURATION_IN_SEC);
    scheduleMicrotask(() {
      DiskUtil.getDeviceStorageInfo(isGb: true).then((value) {
        if ((value ?? 0) > 1) {
          Future.delayed(const Duration(milliseconds: 500), () => _getAvailableCamera());
          WakelockPlus.enable();
        } else {
          showInSufficientStorageDialog(context, onProceed: () {
            Navigator.of(context).pop(); // dismiss dialog
            Navigator.of(context).pop(); // back to previous screen
          });
        }
      });
    });
    Future.delayed(const Duration(seconds: 5), () {
      if (mounted) {
        FocusScope.of(context).requestFocus(_stopVideoFocusNode);
      }
    });
    super.initState();
  }

  void _getAvailableCamera() {
    availableCameras().then((cameras) {
      final backCamera = cameras.firstWhere((camera) => camera.lensDirection == CameraLensDirection.back);
      _cameraController = CameraController(backCamera, ResolutionPreset.medium,
          imageFormatGroup: ImageFormatGroup.nv21, enableAudio: false);
      _initCamera();
    }).catchError((error) {
      showCameraNotAvailableDialog(context, message: error.toString(), onTryAgain: () {
        Navigator.of(context).pop(); // dismiss dialog
        _getAvailableCamera();
      });
      // return "";
    });
  }

  _initCamera() {
    _cameraController!.initialize().then((value) {
      _startVideoRecording();
      setState(() => _isLoading = false);
    }).catchError((error) {
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
    if (_cameraController?.value.isRecordingVideo == true) {
      _cameraController!.stopVideoRecording().then((file) {
        _cameraController!.pausePreview();
        _resetTimers();
        setState(() => _isRecording = false);
        _sendFileToListener(file);
      }).catchError((error) {
        showStopVideoErrorDialog(context, message: error.toString(), onTryAgain: () {
          Navigator.of(context).pop(); // dismiss dialog
          _stopVideoRecording();
        });
      });
    } else {
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
    if (_cameraController != null) {
      try {
        await _cameraController!.prepareForVideoRecording();
        await _cameraController!.startVideoRecording();
        timerWidgetKey.currentState?.startTimer();
        if (mounted) {
          setState(() => _isRecording = true);
        }
      } on CameraException catch (e) {
        handleException(context, error: e, onRetry: _startVideoRecording);
      } catch (e) {
        if (mounted) {
          showCameraPrepareErrorDialog(context, title: "Video Recording Error!!", message: e.toString(),
              onTryAgain: () {
            Navigator.pop(context);
            _startVideoRecording();
          });
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    VideoRecorderArguments? arg = ModalRoute.of(context)?.settings.arguments as VideoRecorderArguments?;
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
        canPop: (_isRecording || _isCompressionStarted) ? false : true,
        onPopInvoked: (didPop) {
          if (!didPop) {
            if (_isRecording) {
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
                if (_cameraController != null)
                  CameraPreview(
                    _cameraController!,
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
                      TimerWidget(_videoRecorderTimeInSeconds, key: timerWidgetKey, onTimerEnd: () {
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
    _cameraController?.setExposurePoint(offset);
    _cameraController?.setFocusPoint(offset);
  }

  _sendFileToListener(XFile xFile) async {
    if (_isCompressionEnabled) {
      try {
        setState(() {
          _isCompressionStarted = true;
        });

        compressVideo(xFile.path, timerWidgetKey.currentState!.getVideoTimeInSec()).then((compressedVideoPath) {
          Navigator.pop(context);
          _listener?.onVideoRecorded(File(compressedVideoPath));
        }, onError: (error) async {
          var file = File(xFile.path);
          if (xFile.path.contains(".temp")) {
            file = await _getRenamedFile(xFile.path);
          }
          Navigator.pop(context);
          _listener?.onVideoRecorded(file);
        });
      } catch (e) {
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
    return FloatingActionButton(
      backgroundColor: theme.colorScheme.error,
      focusNode: _stopVideoFocusNode,
      onPressed: _isCompressionStarted ? null : () => _isRecording ? _stopVideoRecording() : _startVideoRecording(),
      child: Icon((_isRecording || _isCompressionStarted) ? Icons.stop : Icons.play_arrow),
    );
  }

  @override
  void dispose() {
    try {
      _cameraController?.dispose();
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
}
