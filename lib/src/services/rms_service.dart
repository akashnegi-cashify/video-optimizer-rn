import 'package:core_widgets/core_widgets.dart';
import 'package:flutter_trc/src/services/service_groups.dart';

class RmsService extends BaseService {
  final bool addAuthorization;

  RmsService({this.addAuthorization = false});

  @override
  ServiceGroupsMixin getServiceGroup() {
    return TRCServiceGroups.rms;
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
