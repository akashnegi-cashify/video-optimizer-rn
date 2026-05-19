import 'package:flutter_trc/shipex/shipex_service.dart';
import 'package:flutter_trc/src/common/resources/pii_decryption_response.dart';

class PiiService {
  static Stream<PiiDecryptionResponse?> getPiiInformation(String? pii) {
    return ShipexService().get("/app/pii/decrypt?key=$pii", PiiDecryptionResponse.fromJson, authorization: true);
  }
}
