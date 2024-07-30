import 'dart:async';

import 'package:calculator_ui/calculator_ui.dart';
import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/qc/modules/external_audit/providers/external_audit_perform_provider.dart';
import 'package:flutter_trc/qc/modules/external_audit/widgets/multiple_image_video_upload_widget.dart';
import 'package:flutter_trc/qc/modules/external_audit/widgets/scan_barcode_widget.dart';
import 'package:flutter_trc/src/app_builder/app_headers/qc_general_header/widgets/qc_general_header.dart';
import 'package:flutter_trc/src/common/dialogs/csh_no_internet_dialog.dart';
import 'package:flutter_trc/src/common/utils/csh_video_picker.dart';
import 'package:flutter_trc/src/common/video_upload_exception.dart';
import 'package:flutter_trc/src/utils/connectivity_util.dart';

import '../l10n.dart';

class ExternalAuditPerformWidget extends StatefulWidget {
  const ExternalAuditPerformWidget({super.key});

  @override
  State<ExternalAuditPerformWidget> createState() => _ExternalAuditPerformWidgetState();
}

class _ExternalAuditPerformWidgetState extends State<ExternalAuditPerformWidget> {
  int _currentPage = 0;
  ExternalAuditPerformProvider? provider;
  final PageController _pageController = PageController(initialPage: 0, keepPage: false);
  int _counter = 0;

  @override
  Widget build(BuildContext context) {
    var l10n = L10n(context);
    provider ??= ExternalAuditPerformProvider.of(context, listen: false);
    String heading = _getHeading(l10n);
    return WillPopScope(
      onWillPop: () {
        if (_currentPage == 0) {
          return Future.value(true);
        } else {
          if (_counter == 1) {
            return Future.value(true);
          } else {
            CshSnackBar.show(context: context, message: "All Progress will be lost");
            _counter++;
            Future.delayed(const Duration(milliseconds: 1500), () {
              _counter = 0;
            });
          }
          return Future.value(false);
        }
      },
      child: Scaffold(
        appBar: QcGeneralHeader(heading, showBackBtn: true),
        body: PageView.builder(
          itemBuilder: (context, index) {
            switch (index) {
              case 0:
                return ScanBarcodeWidget(
                    step: l10n.step1,
                    onScanDetected: (String scannedData) {
                      _onScanFirstUid(scannedData);
                    });
              case 1:
                return MultipleImageVideoUploadWidget(
                  onMediaUploaded: (imageList, videoList) {
                    provider?.onVideoUploaded(videoList);
                    provider?.onImageUploaded(imageList);
                    _pageController.jumpToPage(2);
                  },
                );
              case 2:
                return ScanBarcodeWidget(
                    step: l10n.step4,
                    onScanDetected: (String scannedData) {
                      _onScanSecondUid(scannedData);
                    });
              default:
                return const SizedBox.shrink();
            }
          },
          onPageChanged: (value) {
            setState(() {
              _currentPage = value;
            });
          },
          itemCount: 4,
          physics: const NeverScrollableScrollPhysics(),
          controller: _pageController,
        ),
      ),
    );
  }

  void _onScanSecondUid(String scannedData) {
    provider?.uid_2 = scannedData;
    _callExternalAuditApi();
  }

  void _onScanFirstUid(String scannedData) {
    provider?.uid_1 = scannedData;
    CshVideoPicker(context).pickVideo((file) {
      provider?.onVideoRecorded(file.path);
      if (provider?.isAuditTypeDispatch() == true) {
        _callExternalAuditApi();
      } else {
        _pageController.jumpToPage(1);
      }
    });
  }

  _callExternalAuditApi() async {
    var isConnected = await ConnectivityUtil.checkConnectivity();
    if (isConnected == false && context.mounted) {
      showNoInternetDialog(
        context,
        onRetry: () {
          Navigator.pop(context);
          _callExternalAuditApi();
        },
      );
      return;
    }
    _showUploadDialog(provider?.fileUploadProgressStream);
    provider?.callExternalAuditApi().then((value) {
      Navigator.pop(context); // dismiss dialog
      CshSnackBar.success(context: context, message: "Request Submitted Successfully");
      Navigator.pop(context);
    }, onError: (error) {
      Navigator.pop(context); // dismiss dialog
      if (error is VideoUploadException) {
        _showRetryUploadVideoDialog(error.message, onRetry: () {
          Navigator.pop(context); // dismiss dialog
          _callExternalAuditApi();
        });
      } else {
        CshSnackBar.error(context: context, message: error);
      }
    });
  }

  _showRetryUploadVideoDialog(String errorMessage, {required VoidCallback onRetry}) {
    showPopup(
      context,
      title: "Video Uploading Failed!",
      desc: errorMessage,
      barrierDismissible: false,
      actions: [
        CshMediumButton(
          text: "Retry",
          onPressed: () {
            onRetry();
          },
        )
      ],
    );
  }

  _showUploadDialog(StreamController<double>? fileUploadProgressStream) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) {
        var theme = Theme.of(context);
        return PopScope(
          canPop: false,
          child: StreamBuilder<double>(
            stream: fileUploadProgressStream?.stream,
            builder: (context, snapshot) {
              return AlertDialog(
                title: Text("Uploading Videos - ${(snapshot.data ?? 0).toInt()}%", style: theme.textTheme.titleMedium),
                content: LinearProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(theme.primaryColor),
                  backgroundColor: theme.primaryColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(Dimens.space_6),
                  value: (snapshot.data ?? 0) / 100,
                ),
              );
            },
          ),
        );
      },
    );
  }

  String _getHeading(L10n l10n) {
    switch (_currentPage) {
      case 0:
        return l10n.scanUniqueIdentifier;
      case 1:
        return l10n.addImagesAndVideos;
      case 2:
      default:
        return l10n.scanUniqueIdentifier;
    }
  }
}
