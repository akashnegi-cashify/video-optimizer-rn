import 'package:core_widgets/core_widgets.dart';

class QCLoginService extends BaseService {
  final bool addAuthorization;

  QCLoginService({this.addAuthorization = false});

  @override
  ServiceGroups getServiceGroup() {
    return ServiceGroups.cas;
  }

  @override
  bool isToAddUserAuth() {
    return true;
  }

  @override
  Map<String, String> getHeaders(bool? isToAddAuth) {
    return {
      ...(isToAddAuth ?? isToAddUserAuth()) ? CoreHeaders.X_USER_AUTH : {},
    };
  }

  @override
  bool isToAddAuthorization() {
    return addAuthorization;
  }
}
