import 'dart:convert';

import 'package:core_widgets/core_widgets.dart';
import 'package:flutter_trc/src/services/qc_service.dart';

import '../models/dispute_image_capture_submit_success_response.dart';
import '../models/disputed_media_data_response.dart';

class DisputeImageCaptureService {
  static Stream<DisputedMediaDataResponse?> fetchDisputeImageCaptureData(String barcode) {
    return QcService().get("/source/audit/app/$barcode", DisputedMediaDataResponse.fromJson);
  }

  static Stream<BaseResponse?> submitDisputeMediaData(
      {required String barcode, required Map<String, dynamic> bodyData}) {
    return QcService().post(
      "/source/audit/app/$barcode",
      BaseResponse.fromJson,
      body: jsonEncode(bodyData),
    );
  }
}
