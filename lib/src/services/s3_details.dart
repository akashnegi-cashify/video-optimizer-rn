import 'package:flutter_trc/src/services/trc_service.dart';

import '../resources/models/s3_details_response.dart';

class S3DetailsService {
  static Stream<S3DetailsResponse?> fetchS3Details() {
    return TrcService().get("/s3/details", S3DetailsResponse.fromJson);
  }
}
