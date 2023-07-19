import 'package:core_widgets/core_widgets.dart';
import 'package:flutter_trc/src/services/service_groups.dart';

class QcService extends BaseService {
  final bool addAuthorization;

  QcService({this.addAuthorization = false});

  @override
  TRCServiceGroups getServiceGroup() {
    return TRCServiceGroups.qc;
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
