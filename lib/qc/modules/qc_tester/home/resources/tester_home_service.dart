import 'package:flutter_trc/qc/modules/qc_tester/home/resources/testing_count_response.dart';
import 'package:flutter_trc/src/services/qc_service.dart';

class TesterHomeService {
  static Stream<TestingCountResponse?> getTestingCount() {
    return QcService().get("/testing/count", TestingCountResponse.fromJson);
  }
}
