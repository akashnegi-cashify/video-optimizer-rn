import 'dart:async';
import 'dart:io';

import 'package:core/core.dart';
import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/qc/modules/external_audit/models/external_audit_enum.dart';
import 'package:flutter_trc/qc/modules/external_audit/resources/external_audit_service.dart';
import 'package:flutter_trc/src/utils/media_upload/media_optimiser_utils.dart';
import 'package:flutter_trc/src/utils/media_upload/resource/media_content_type.dart';
import 'package:path/path.dart' as path;
import 'package:provider/provider.dart';

class ExternalAuditPerformProvider extends CshChangeNotifier {
  String? _uid_1;
  final List<String> _videoFilePathList = [];
  final List<String> _videoUrlList = [];
  String? _uid_2;
  final List<String> _imageUrlList = [];
  final ExternalAuditEnum auditType;

  ExternalAuditPerformProvider(this.auditType);

  set uid_1(String value) {
    _uid_1 = value;
  }

  set uid_2(String value) {
    _uid_2 = value;
  }

  static ExternalAuditPerformProvider of(BuildContext context, {bool listen = true}) {
    return Provider.of<ExternalAuditPerformProvider>(context, listen: listen);
  }

  void onVideoRecorded(String filesPath) {
    _videoFilePathList.add(filesPath);
  }

  void onVideoUploaded(List<String> filesPathList) {
    _videoUrlList.addAll(filesPathList);
  }

  Future<bool> callExternalAuditApi() async {
    var completer = Completer<bool>();

    if (_videoFilePathList.isNotEmpty) {
      var list = await _uploadVideoFilesAndGetUrls();
      if (list != null) {
        _videoUrlList.addAll(list);
      }
    }

    ExternalAuditService.submitExternalAudit(
      uid_1: _uid_1,
      videoUrlList: _videoUrlList,
      uid_2: _uid_2,
      imageUrlList: _imageUrlList,
      isReceiveReturn: _isReceiveReturn(),
      auditType: auditType.val,
    ).listen((event) {
      completer.complete(true);
    }, onError: (error) {
      completer.completeError(ApiErrorHelper.getErrorMessage(error).toString());
    });

    return completer.future;
  }

  bool _isReceiveReturn() {
    return auditType == ExternalAuditEnum.receiveReturn;
  }

  bool isAuditTypeDispatch() {
    return auditType == ExternalAuditEnum.dispatch;
  }

  Future<List<String>?> _uploadVideoFilesAndGetUrls() async {
    List<String> urlList = [];
    for (var element in _videoFilePathList) {
      String fileName = path.basename(element);
      try {
        String url = await MediaUploadUtil().uploadMediaWithType(
          mediaFile: File(element),
          fileName: fileName,
          contentType: MediaContentType.mp4,
        );
        urlList.add(url);
      } catch (e) {
        return null;
      }
    }
    return urlList;
  }

  void onImageUploaded(List<String> imageList) {
    _imageUrlList.addAll(imageList);
  }
}
