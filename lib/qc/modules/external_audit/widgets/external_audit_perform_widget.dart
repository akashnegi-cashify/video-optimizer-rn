import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/qc/modules/external_audit/providers/external_audit_perform_provider.dart';
import 'package:flutter_trc/qc/modules/external_audit/widgets/multiple_image_video_upload_widget.dart';
import 'package:flutter_trc/qc/modules/external_audit/widgets/scan_barcode_widget.dart';
import 'package:flutter_trc/src/app_builder/app_headers/qc_general_header/widgets/qc_general_header.dart';
import 'package:flutter_trc/src/common/utils/csh_video_picker.dart';

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

  @override
  Widget build(BuildContext context) {
    var l10n = L10n(context);
    provider ??= ExternalAuditPerformProvider.of(context, listen: false);
    return Scaffold(
      appBar: const QcGeneralHeader("Unique Identifier", showBackBtn: true),
      body: PageView.builder(
        itemBuilder: (context, index) {
          switch (index) {
            case 0:
              return ScanBarcodeWidget(step: l10n.step1, onScanDetected: (String scannedData) {
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
              return ScanBarcodeWidget(step: l10n.step4, onScanDetected: (String scannedData) {
                _onScanSecondUid(scannedData);
              });
            default:
              return const SizedBox.shrink();
          }
        },
        onPageChanged: (value) {
          _currentPage = value;
        },
        itemCount: 4,
        physics: const NeverScrollableScrollPhysics(),
        controller: _pageController,
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

  _callExternalAuditApi() {
    CshLoading().showLoading(context);
    provider?.callExternalAuditApi().then((value) {
      CshLoading().hideLoading(context);
      CshSnackBar.success(context: context, message: "Request Submitted Successfully");
      Navigator.pop(context);
    }, onError: (error) {
      CshLoading().hideLoading(context);
      CshSnackBar.error(context: context, message: error);
    });
  }
}
