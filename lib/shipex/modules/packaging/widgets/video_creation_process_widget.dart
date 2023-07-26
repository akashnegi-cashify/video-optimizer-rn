import 'dart:async';
import 'dart:io';

import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/shipex/modules/packaging/providers/packaging_provider.dart';
import 'package:flutter_trc/shipex/modules/shipex_home/screens/shipex_home_screen.dart';
import 'package:flutter_trc/src/common/widgets/video_recoder_widget.dart';

import '../l10n.dart';

class VideoCreationProcessWidget extends StatelessWidget {
  VideoCreationProcessWidget({super.key});

  Timer? _timer;
  final TextEditingController _deviceBarcodeController = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  final GlobalKey<VideoRecorderWidgetState> _videoRef = GlobalKey<VideoRecorderWidgetState>();

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
                  hintText: l10n.enterAwbNo,
                  autofocus: true,
                  maxLength: 100,
                  onChanged: (data) {
                    if (_timer?.isActive ?? false) _timer?.cancel();
                    _timer = Timer(
                      const Duration(milliseconds: 500),
                      () {
                        _onDeviceBarcodeScanned(context, provider, data);
                      },
                    );
                  },
                ),
              ),
              const SizedBox(width: Dimens.space_8),
              CshMediumButton(
                text: "Submit",
                onPressed: () {
                  _onDeviceBarcodeScanned(context, provider, _deviceBarcodeController.text);
                },
              )
            ],
          ),
          const SizedBox(height: Dimens.space_16),
          Expanded(child: VideoRecorderWidget(key: _videoRef, isCompressionEnabled: true)),
          const SizedBox(height: Dimens.space_16),
          CshBigButton(
              text: "Complete Packaging",
              onPressed: provider.isAllDeviceScanned()
                  ? () async {
                      File? videoFile = await _videoRef.currentState?.stopVideoRecording();
                      if (videoFile != null) {
                        _onCompletePackagingClicked(context, videoFile, provider);
                      }
                    }
                  : null)
        ],
      ),
    );
  }

  _onDeviceBarcodeScanned(BuildContext context, PackagingProvider provider, String deviceBarcode) {
    CshLoading().showLoading(context);
    provider.completeItemPackaging(deviceBarcode).then((value) {
      CshLoading().hideLoading(context);
    }, onError: (error) {
      CshLoading().hideLoading(context);
      CshSnackBar.error(context: context, message: error);
    }).whenComplete(() => _focusNode.requestFocus());
  }

  void _onCompletePackagingClicked(BuildContext context, File videoFile, PackagingProvider provider) {
    CshLoading().showLoading(context);
    provider.onPackagingFinished(videoFile).then((value) {
      CshLoading().hideLoading(context);
      CshSnackBar.success(context: context, message: "Packaging completed");
      Navigator.popUntil(context, (route) => route.settings.name == ShipexHomeScreen.route);
    }, onError: (error) {
      CshLoading().hideLoading(context);
      CshSnackBar.error(context: context, message: error);
    });
  }
}
