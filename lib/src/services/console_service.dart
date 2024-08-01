import 'package:core_widgets/core_widgets.dart';

class ConsoleService extends BaseService {
  final bool addAuthorization;

  ConsoleService({this.addAuthorization = true});

  @override
  ServiceGroupsMixin getServiceGroup() {
    return ServiceGroups.console;
  }

  @override
  bool isToAddUserAuth() {
    return true;
  }

  @override
  Map<String, String> getHeaders(bool? isToAddAuth) {
    return {
      ...(isToAddAuth ?? isToAddUserAuth()) ? CoreHeaders.xSSOToken : {},
    };
  }

  @override
  bool isToAddAuthorization() {
    return addAuthorization;
  }
}
