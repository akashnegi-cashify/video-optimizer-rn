import 'dart:convert';

import 'package:flutter_trc/src/services/qc_service.dart';

import '../models/dispute_image_capture_submit_success_response.dart';
import '../models/disputed_media_data_response.dart';

class DisputeImageCaptureService {
  static Stream<DisputedMediaDataResponse?> fetchDisputeImageCaptureData(String barcode) {
    return QcService().get("/source/audit/$barcode", DisputedMediaDataResponse.fromJson);
  }

  static Stream<DisputeImageCaptureSubmitSuccessResponse?> submitDisputeMediaData(
      {required String barcode, required Map<String, dynamic> bodyData}) {
    Map<String, List<String>> query = {
      "qrCode": [barcode],
    };

    return QcService().post("/source/audit/$barcode", DisputeImageCaptureSubmitSuccessResponse.fromJson,
        params: query, body: jsonEncode(bodyData));
  }
}
