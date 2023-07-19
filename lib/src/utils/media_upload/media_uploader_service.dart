import 'dart:convert';

import 'image_optimiser_service.dart';
import 'models/media_acknowledge_response.dart';
import 'models/presigned_url_response.dart';

class MediaUploaderService {
  static Stream<PreSignedUrlResponse?> getPreSignedUrl({required String fileName, required String fileFormat}) {
    Map<String, dynamic> bodyData = {
      "fileName": fileName.trim(),
      "fileType": fileFormat.trim(),
      "source": "trc",
    };

    return ImageOptimizerService().post("/v1/initiateUpload", PreSignedUrlResponse.fromJson, body: bodyData);
  }

  static Stream<MediaAcknowledgeResponse?> getImageAcknowledged({required String transactionId}) {
    Map<String, dynamic> bodyData = {
      "txnId": transactionId,
    };
    var headers = ImageOptimizerService().getHeaders(true);
    headers["content-type"] = "application/json";

    return ImageOptimizerService()
        .post("/v1/acknowledge", MediaAcknowledgeResponse.fromJson, body: jsonEncode(bodyData), headers: headers);
  }
}
