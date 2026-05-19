import 'dart:async';

import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/qc/modules/d2c_video/providers/d2c_video_provider.dart';
import 'package:flutter_trc/qc/modules/d2c_video/screens/d2c_video_screen.dart';
import 'package:flutter_trc/src/common/utils/csh_ml_scanner_util.dart';
import 'package:image_picker/image_picker.dart';

class D2CVideoWidget extends StatefulWidget {
  const D2CVideoWidget({super.key});

  @override
  State<D2CVideoWidget> createState() => _D2CVideoWidgetState();
}

class _D2CVideoWidgetState extends State<D2CVideoWidget> {
  ViewType _viewType = ViewType.productDetail;

  @override
  void initState() {
    scheduleMicrotask(() {
      var provider = D2CVideoProvider.of(context, listen: false);
      provider.getDeviceDetails().then((value) {
        setState(() {
          _viewType = ViewType.productDetail;
        });
      }, onError: (error) {
        setState(() {
          _viewType = ViewType.productDetailFailed;
        });
      });
    });
    super.initState();
  }

  _createVideoRecording() {
    ImagePicker imagePicker = ImagePicker();
    imagePicker.pickVideo(source: ImageSource.camera).then((value) {
      if (value != null) {
        _compressVideo(value.path);
      }
    });
  }

  _compressVideo(String path) async {
    try {
      setState(() {
        _viewType = ViewType.compression;
      });
      var provider = D2CVideoProvider.of(context, listen: false);
      provider.compressVideo(path).then((outputPath) {
        _uploadVideo(outputPath);
      }, onError: (error) {
        CshSnackBar.error(context: context, message: error.toString());
      });
    } catch (e) {
      if (mounted) {
        CshSnackBar.error(context: context, message: e.toString());
        Navigator.of(context).pop();
      }
    }
  }

  _uploadVideo(String filePath) {
    setState(() {
      _viewType = ViewType.uploading;
    });
    var provider = D2CVideoProvider.of(context, listen: false);
    provider.uploadMedia(filePath).then((value) {
      _updateData();
    }, onError: (error) {
      setState(() {
        _viewType = ViewType.uploadingFailed;
      });
      CshSnackBar.error(context: context, message: error.toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    if (_viewType == ViewType.compression) {
      return _buildCompressionProgressContainer(theme);
    }
    if (_viewType == ViewType.uploading) {
      return _buildUploadingProgressContainer(theme);
    }

    if (_viewType == ViewType.uploadingFailed) {
      return _buildUploadingFailed();
    }

    if (_viewType == ViewType.completed) {
      return _buildCompletedState();
    }

    if (_viewType == ViewType.productDetail) {
      return _buildProductDetailState();
    }

    if (_viewType == ViewType.productDetailFailed) {
      return _buildProductDetailFailedState(theme);
    }

    return _buildProductDetailState();
  }

  Widget _buildProductDetailFailedState(ThemeData theme) {
    var provider = D2CVideoProvider.of(context, listen: false);
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CshCard(
            padding: const EdgeInsets.all(Dimens.space_24),
            margin: const EdgeInsets.all(Dimens.space_16),
            child: Column(
              children: [
                CshTextNew.h3("Failed to get device details"),
                const SizedBox(height: Dimens.space_12),
                CshTextNew.subTitle1("Device Barcode - ${provider.deviceBarcode}"),
                const SizedBox(height: Dimens.space_12),
                Text(
                  provider.deviceError ?? "Unknown Error",
                  textAlign: TextAlign.center,
                  style: theme.primaryTextTheme.titleMedium?.copyWith(color: theme.colorScheme.error),
                ),
                const SizedBox(height: Dimens.space_16),
                CshBigButton(
                  text: "Retry",
                  onPressed: () {
                    var provider = D2CVideoProvider.of(context, listen: false);
                    CshLoading().showLoading(context);
                    provider.getDeviceDetails().then((value) {
                      CshLoading().hideLoading(context);
                      setState(() {
                        _viewType = ViewType.productDetail;
                      });
                    }, onError: (error) {
                      CshLoading().hideLoading(context);
                      setState(() {
                        _viewType = ViewType.productDetailFailed;
                      });
                    });
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProductDetailState() {
    var provider = D2CVideoProvider.of(context, listen: false);
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CshCard(
            padding: const EdgeInsets.all(Dimens.space_24),
            margin: const EdgeInsets.all(Dimens.space_16),
            child: Column(
              children: [
                CshTextNew.subTitle1("Device Barcode -  ${provider.deviceBarcode}"),
                const SizedBox(height: Dimens.space_8),
                CshTextNew.subTitle1("Device Name -  ${provider.deviceName ?? "NA"}"),
                const SizedBox(height: Dimens.space_16),
                CshBigButton(
                  text: "Start Recording",
                  onPressed: () {
                    _createVideoRecording();
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCompletedState() {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CshCard(
            padding: const EdgeInsets.all(Dimens.space_24),
            margin: const EdgeInsets.all(Dimens.space_16),
            child: Column(
              children: [
                CshTextNew.h3("Video Submitted Successfully"),
                const SizedBox(height: Dimens.space_16),
                CshBigButton(
                  text: "Next Recording",
                  onPressed: () {
                    CshMlScannerUtil().openScanner(
                      context,
                      onScanned: (scannedData, controller) {
                        Navigator.pop(context); // dismiss dialog
                        D2CVideoScreen.replace(context, scannedData);
                      },
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildUploadingFailed() {
    var provider = D2CVideoProvider.of(context, listen: false);
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CshCard(
            padding: const EdgeInsets.all(Dimens.space_24),
            margin: const EdgeInsets.all(Dimens.space_16),
            child: Column(
              children: [
                CshTextNew.h3("Uploading Failed"),
                const SizedBox(height: Dimens.space_16),
                CshBigButton(
                  text: "Retry",
                  onPressed: () {
                    _uploadVideo(provider.compressedFilePath!);
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildUploadingProgressContainer(ThemeData theme) {
    var provider = D2CVideoProvider.of(context, listen: false);
    return StreamBuilder<int>(
      stream: provider.fileUploadProgressStream.stream,
      builder: (context, snapshot) {
        return Center(
          child: CshCard(
            padding: const EdgeInsets.all(Dimens.space_24),
            margin: const EdgeInsets.all(Dimens.space_16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text("Uploading Videos - ${(snapshot.data ?? 0).toInt()}%", style: theme.textTheme.titleMedium),
                const SizedBox(height: Dimens.space_16),
                LinearProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(theme.primaryColor),
                  backgroundColor: theme.primaryColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(Dimens.space_6),
                  value: (snapshot.data ?? 0) / 100,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildCompressionProgressContainer(ThemeData theme) {
    var provider = D2CVideoProvider.of(context, listen: false);
    return StreamBuilder(
      stream: provider.fileCompressProgressStream.stream,
      builder: (_, snapshot) {
        var progress = snapshot.data;
        if ((progress ?? 0) > 100) {
          progress = 100;
        }
        return Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CshCard(
                padding: const EdgeInsets.all(Dimens.space_24),
                margin: const EdgeInsets.all(Dimens.space_16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CshTextNew.h3("Optimizing Video - ${progress ?? 0}%"),
                    const SizedBox(height: Dimens.space_16),
                    LinearProgressIndicator(
                      value: (progress ?? 0) / 100,
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
      },
    );
  }

  void _updateData() {
    var provider = D2CVideoProvider.of(context, listen: false);
    CshLoading().showLoading(context);
    provider.updateData().then((value) {
      CshLoading().hideLoading(context);
      CshSnackBar.success(context: context, message: "Video Submitted Successfully");
      setState(() {
        _viewType = ViewType.completed;
      });
    }, onError: (error) {
      CshLoading().hideLoading(context);
      CshSnackBar.error(context: context, message: error.toString());
    });
  }
}

enum ViewType { productDetail, productDetailFailed, compression, uploading, uploadingFailed, completed }
