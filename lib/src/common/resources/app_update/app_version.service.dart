import 'package:core_widgets/core_widgets.dart';

import 'app_version.response.dart';

class AppVersionService {
  static Stream<AppVersionResponse?> getAppVersion(String? clientId, String clientVersion, String appVersion) {
    Map<String, String?> body = {
      'client_id': clientId,
      'client_version': clientVersion,
      'app_version': appVersion,
    };

    return CasService().post('/v1/get-app-version', AppVersionResponse.fromJson, body: body);
  }
}
