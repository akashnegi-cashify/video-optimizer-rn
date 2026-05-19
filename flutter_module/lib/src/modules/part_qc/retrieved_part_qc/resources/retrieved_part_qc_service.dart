import 'dart:convert';

import 'package:flutter_trc/src/services/trc_service.dart';

import '../models/qc_repost_response.dart';

class RetrievedPartQcService {
  static Stream<QcRepostResponse?> getQcReport({Map<String, dynamic>? bodyData}) {
    return TrcService()
        .get("/qc/parts/qc-report", QcRepostResponse.fromJson);
  }
}
