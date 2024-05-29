// Copyright 2013 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:async';
import 'dart:io';

import 'package:calculator_ui/calculator_ui.dart';
import 'package:camera/camera.dart';
import 'package:core/core.dart';
import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/src/common/utils/disk_util.dart';
import 'package:flutter_trc/src/common/utils/video_util.dart';
import 'package:flutter_trc/src/libraries/firebase/remote_config_helper.dart';
import 'package:wakelock_plus/wakelock_plus.dart';

const int _DEFAULT_VIDEO_TIMER = 600;
const int _DEFAULT_START_TIMER = 3;

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
  _VideoRecorderWidgetState createState() => _VideoRecorderWidgetState();
}

class _VideoRecorderWidgetState extends State<VideoRecorderWidget> {
  bool _isLoading = true;
  bool _isRecording = false;
  bool _isCompressionStarted = false;
  late CameraController? _cameraController;
  Timer? _videoRecorderTimer;
  late int _videoRecorderTimeInSeconds;
  int _videoRecordedTime = 0;

  /// _startVideoTimer is used as a timer to start video recording
  Timer? _startVideoTimer;
  late int _startVideoTimerInSec;

  bool _isCompressionEnabled = true;

  int _compressionProgress = 0;

  _VideoRecorderWidgetState() {
    _videoRecorderTimeInSeconds = _DEFAULT_VIDEO_TIMER;
  }

  VideoRecordingListener? _listener;
  FocusNode _stopVideoFocusNode = FocusNode();

  @override
  void initState() {
    scheduleMicrotask(() {
      DiskUtil.getDeviceStorageInfo(isGb: true).then((value) {
        if ((value ?? 0) > 1) {
          _initCamera();
          WakelockPlus.enable();
        } else {
          _showInSufficientStorageDialog();
        }
      });
    });
    Future.delayed(const Duration(seconds: 5), () {
      FocusScope.of(context).requestFocus(_stopVideoFocusNode);
    });

    _getVideoRecordingTimerInSec();
    super.initState();
  }

  _getVideoRecordingTimerInSec() {
    _videoRecorderTimeInSeconds = RemoteConfigHelper().getInt(AppRemoteConfig.KEY_VIDEO_RECORD_DURATION_IN_SEC);
  }

  void _showError(String message) {
    CshSnackBar.error(context: context, message: message, snackBarPosition: SnackBarPosition.TOP);
  }

  _initCamera() async {
    try {
      final cameras = await availableCameras();
      final backCamera = cameras.firstWhere((camera) => camera.lensDirection == CameraLensDirection.back);
      _cameraController = CameraController(backCamera, ResolutionPreset.medium,
          imageFormatGroup: ImageFormatGroup.nv21, enableAudio: false);

      await _cameraController!.initialize();
      _startVideoRecording();
      setState(() => _isLoading = false);
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

  _resetTimers() {
    if (_videoRecorderTimer?.isActive == true) {
      _videoRecorderTimer?.cancel();
    }

    _videoRecorderTimer == null;
    _getVideoRecordingTimerInSec();
  }

  _stopVideoRecording() async {
    if (_cameraController != null && _isRecording) {
      final file = await _cameraController!.stopVideoRecording();
      _resetTimers();
      setState(() => _isRecording = false);
      _sendFileToListener(file);
    }
  }

  _startVideoRecording() async {
    if (_cameraController != null) {
      await _cameraController!.prepareForVideoRecording();
      await _cameraController!.startVideoRecording();
      _startVideoRecordingTimer();
      if (mounted) {
        setState(() => _isRecording = true);
      }
    }
  }

  _startVideoRecordingTimer() {
    _videoRecorderTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        _videoRecordedTime++;
        _videoRecorderTimeInSeconds--;
        if (_videoRecorderTimeInSeconds == 0) {
          timer.cancel();
          _stopVideoRecording();
        }
      });
    });
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
                      Text(
                        _getTimeString(_videoRecorderTimeInSeconds),
                        style: theme.primaryTextTheme.displayMedium?.copyWith(color: theme.colorScheme.error),
                      )
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
                    child: _buildProgressContainer(theme),
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
        VideoUtil.compressVideo(xFile.path, _videoRecordedTime, addTimeStamp: true, onProgress: (value) {
          Logger.debug('mydebug-----_VideoRecorderWidgetState._sendFileToListener onProgress', ['value: $value']);
          setState(() {
            _compressionProgress = value;
          });
        }).then((String? outputPath) {
          if (outputPath != null) {
            Navigator.pop(context);
            _listener?.onVideoRecorded(File(outputPath));
          }
        }, onError: (error) {
          Navigator.pop(context);
          CshSnackBar.error(context: context, message: error.toString());
        });
      } catch (e) {
        if (mounted) {
          CshSnackBar.error(context: context, message: e.toString());
          Navigator.of(context).pop();
        }
      }
    } else {
      File file = File(xFile.path);
      Navigator.pop(context);
      _listener?.onVideoRecorded(file);
    }
  }

  String _getTimeString(int seconds) {
    String res = "";

    int mins = seconds ~/ 60;
    int secs = seconds % 60;

    if (mins < 10) {
      res += "0$mins";
    } else {
      res += "$mins";
    }

    if (secs < 10) {
      res += ":0$secs";
    } else {
      res += ":$secs";
    }
    return res;
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
                CshTextNew.h3("Optimizing Video - $_compressionProgress%"),
                const SizedBox(height: Dimens.space_16),
                LinearProgressIndicator(
                  value: _compressionProgress / 100,
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

  _buildRecordButton(ThemeData theme) {
    return FloatingActionButton(
      backgroundColor: theme.colorScheme.error,
      focusNode: _stopVideoFocusNode,
      onPressed: () => _isRecording ? _stopVideoRecording() : null,
      child: Icon(_isRecording ? Icons.stop : Icons.circle),
    );
  }

  @override
  void dispose() {
    try {
      _cameraController?.dispose();
    } catch (e) {
      Logger.error('mydebug-----_VideoRecorderWidgetState.dispose', ['error: $e']);
    }

    if (_videoRecorderTimer?.isActive == true) {
      _videoRecorderTimer?.cancel();
    }

    WakelockPlus.disable();
    super.dispose();
  }

  void _showInSufficientStorageDialog() {
    showPopup(context,
        title: "Insufficient Storage",
        desc: "This device does not have enough storage to record video.",
        barrierDismissible: false,
        actions: [
          CshBigButton(
            text: "Ok",
            onPressed: () {
              Navigator.of(context).pop();
              Navigator.of(context).pop();
            },
          )
        ]);
  }
}
