import 'dart:convert';

import 'package:core_widgets/core_widgets.dart';

import 'image_optimiser_service.dart';
import 'models/media_acknowledge_response.dart';
import 'models/presigned_url_response.dart';

class MediaUploaderService {
  static Stream<PreSignedUrlResponse?> getPreSignedUrl(
      {required String fileName, required String fileFormat, BaseService? service}) {
    Map<String, dynamic> bodyData = {
      "fileName": fileName.trim(),
      "fileType": fileFormat.trim(),
      "source": "trc",
    };

    service ??= ImageOptimizerService();
    var headers = service.getHeaders(true);
    headers["content-type"] = "application/x-www-form-urlencoded";

    return service.post("/v1/initiateUpload", PreSignedUrlResponse.fromJson, body: bodyData, headers: headers);
  }

  static Stream<MediaAcknowledgeResponse?> getImageAcknowledged({required String transactionId, BaseService? service}) {
    Map<String, dynamic> bodyData = {
      "txnId": transactionId,
    };

    service ??= ImageOptimizerService();

    return service.post("/v1/acknowledge", MediaAcknowledgeResponse.fromJson, body: jsonEncode(bodyData));
  }
}
