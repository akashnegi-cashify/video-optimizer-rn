import 'dart:async';
import 'dart:io';

import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/shipex/modules/packaging/providers/packaging_provider.dart';
import 'package:flutter_trc/src/common/widgets/video_recoder_widget.dart';
import 'package:flutter_trc/src/utils/csh_tts_util.dart';

import '../l10n.dart';

class VideoCreationProcessWidget extends StatefulWidget {
  final bool isCCTVCameraSelected;

  const VideoCreationProcessWidget(this.isCCTVCameraSelected, {super.key});

  @override
  State<VideoCreationProcessWidget> createState() => VideoCreationProcessWidgetState();
}

class VideoCreationProcessWidgetState extends State<VideoCreationProcessWidget> {
  Timer? _timer;

  final TextEditingController _deviceBarcodeController = TextEditingController();

  final FocusNode _focusNode = FocusNode();

  final GlobalKey<VideoRecorderWidgetState> _videoRef = GlobalKey<VideoRecorderWidgetState>();

  Future<void> disposeCamera() async {
    return await _videoRef.currentState?.disposeCamera();
  }

  @override
  Widget build(BuildContext context) {
    var l10n = L10n(context);
    var provider = PackagingProvider.of(context);
    return Padding(
      padding: const EdgeInsets.all(Dimens.space_16),
      child: Column(
        children: [
          CshTextNew.subTitle1(l10n.packagingProcedure),
          const SizedBox(height: Dimens.space_8),
          CshTextNew.subTitle2(provider.scannedCount()),
          const SizedBox(height: Dimens.space_8),
          CshTextNew.subTitle2(l10n.scanBarcodeToStartRecording),
          const SizedBox(height: Dimens.space_8),
          Row(
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              Expanded(
                child: CshTextFormField(
                  controller: _deviceBarcodeController,
                  focusNode: _focusNode,
                  keyboardType: TextInputType.name,
                  hintText: l10n.enterDeviceBarcode,
                  autofocus: true,
                  maxLength: 100,
                  onChanged: (data) {
                    if (_timer?.isActive ?? false) _timer?.cancel();
                    _timer = Timer(
                      const Duration(milliseconds: kDebugMode ? 1500: 500),
                      () {
                        _onDeviceBarcodeScanned(provider, data);
                      },
                    );
                  },
                ),
              ),
              const SizedBox(width: Dimens.space_8),
              CshMediumButton(
                text: l10n.submit,
                onPressed: () {
                  _onDeviceBarcodeScanned(provider, _deviceBarcodeController.text);
                },
              )
            ],
          ),
          const SizedBox(height: Dimens.space_16),
          if (!widget.isCCTVCameraSelected)
            Expanded(child: VideoRecorderWidget(key: _videoRef)),
          const SizedBox(height: Dimens.space_16),
          CshBigButton(
              text: l10n.completePackaging,
              onPressed: provider.isAllDeviceScanned()
                  ? () async {
                      if (widget.isCCTVCameraSelected) {
                        _onCompletePackagingClicked(null, provider);
                      } else {
                        File? videoFile = await _videoRef.currentState?.stopVideoRecording();
                        if (videoFile != null) {
                          _onCompletePackagingClicked(videoFile, provider);
                        }
                      }
                    }
                  : null)
        ],
      ),
    );
  }

  _onDeviceBarcodeScanned(PackagingProvider provider, String deviceBarcode) {
    CshLoading().showLoading(context);
    provider.completeItemPackaging(deviceBarcode).then((value) {
      CshLoading().hideLoading(context);
    }, onError: (error) {
      CshLoading().hideLoading(context);
      CshTtsUtil().speak(error);
      // CshSnackBar.error(context: context, message: error);
    }).whenComplete(() {
      _deviceBarcodeController.text = "";
      _focusNode.requestFocus();
    });
  }

  void _onCompletePackagingClicked(File? videoFile, PackagingProvider provider) {
    CshLoading().showLoading(context);
    provider.onPackagingFinished(videoFile).then((value) async {
      CshLoading().hideLoading(context);
      CshSnackBar.success(context: context, message: "Packaging completed");
      if (!widget.isCCTVCameraSelected) {
        await _videoRef.currentState?.disposeCamera();
      }
      Navigator.pop(context);
    }, onError: (error) {
      CshLoading().hideLoading(context);
      CshSnackBar.error(context: context, message: error);
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}
