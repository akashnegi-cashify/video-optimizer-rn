import 'dart:async';
import 'dart:io';

import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/qc/modules/external_audit/models/external_audit_enum.dart';
import 'package:flutter_trc/qc/modules/external_audit/resources/external_audit_service.dart';
import 'package:provider/provider.dart';

class ExternalAuditPerformProvider extends CshChangeNotifier {
  String? _uid_1;
  final List<String> _videoUrlList = [];
  String? _uid_2;
  final List<String> _imageUrlList = [];
  final ExternalAuditEnum returnType;

  ExternalAuditPerformProvider(this.returnType);

  set uid_1(String value) {
    _uid_1 = value;
  }

  set uid_2(String value) {
    _uid_2 = value;
  }

  static ExternalAuditPerformProvider of(BuildContext context, {bool listen = true}) {
    return Provider.of<ExternalAuditPerformProvider>(context, listen: listen);
  }

  void onVideoRecorded(File file) {
    _videoUrlList.add(file.path);
  }

  Future<bool> callExternalAuditApi({bool? isReceiveReturn}) {
    var completer = Completer<bool>();
    ExternalAuditService.submitExternalAudit(
      uid_1: _uid_1,
      videoUrlList: _videoUrlList,
      uid_2: _uid_2,
      imageUrlList: _imageUrlList,
      isReceiveReturn: isReceiveReturn,
      returnType: returnType.val,
    ).listen((event) {
      completer.complete(true);
    }, onError: (error) {
      completer.completeError(ApiErrorHelper.getErrorMessage(error).toString());
    });

    return completer.future;
  }
}
