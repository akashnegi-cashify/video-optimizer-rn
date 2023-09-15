import 'dart:io';

import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/qc/modules/external_audit/external_audit_perform_screen.dart';
import 'package:flutter_trc/qc/modules/external_audit/models/external_audit_enum.dart';
import 'package:flutter_trc/qc/modules/external_audit/providers/external_audit_perform_provider.dart';
import 'package:flutter_trc/qc/modules/external_audit/widgets/scan_barcode_widget.dart';
import 'package:flutter_trc/qc/modules/external_audit/widgets/video_recoder_widget.dart';

import '../l10n.dart';

class ExternalAuditPerformWidget extends StatefulWidget {
  final ExternalAuditPerformScreenArguments? args;

  const ExternalAuditPerformWidget(this.args, {super.key});

  @override
  State<ExternalAuditPerformWidget> createState() => _ExternalAuditPerformWidgetState();
}

class _ExternalAuditPerformWidgetState extends State<ExternalAuditPerformWidget> implements VideoRecordingListener {
  int _currentPage = 0;
  ExternalAuditPerformProvider? provider;
  final PageController _pageController = PageController(initialPage: 0, keepPage: false);

  @override
  Widget build(BuildContext context) {
    var l10n = L10n(context);
    provider ??= ExternalAuditPerformProvider.of(context, listen: false);
    return PageView.builder(
      itemBuilder: (context, index) {
        switch (index) {
          case 1:
            return ScanBarcodeWidget(onScanDetected: (String scannedData) {
              _onScanFirstUUid(scannedData);
            });
          case 2:
          case 3:
          case 4:
            return ScanBarcodeWidget(onScanDetected: (String scannedData) {
              print(scannedData);
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
    );
  }

  void _onScanFirstUUid(String scannedData) {
    provider?.uid_1 = scannedData;
    Navigator.pushNamed(context, VideoRecorderWidget.route, arguments: VideoRecorderArguments(this));
  }

  @override
  onVideoRecorded(File file) {
    provider?.onVideoRecorded(file);
    if (widget.args?.externalAuditEnum == ExternalAuditEnum.dispatch) {
      CshLoading().showLoading(context);
      provider?.callExternalAuditApi().then((value) {
        CshLoading().hideLoading(context);
        CshSnackBar.success(context: context, message: "Success");
      }, onError: (error) {
        CshLoading().hideLoading(context);
        CshSnackBar.error(context: context, message: error);
      });
      Navigator.pop(context);
    } else {
      _pageController.jumpToPage(1);
    }
  }
}
