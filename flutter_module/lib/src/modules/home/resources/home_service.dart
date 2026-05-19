import 'package:flutter_trc/src/services/trc_service.dart';

import '../models/logout_response.dart';

class HomeScreenService {
  static Stream<LogoutResponse?> userLogout() {
    return TrcService().post("/logout", LogoutResponse.fromJson);
  }
}
