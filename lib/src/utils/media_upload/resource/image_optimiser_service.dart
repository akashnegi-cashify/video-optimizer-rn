import 'package:core_widgets/core_widgets.dart';
import 'package:flutter_trc/src/services/service_groups.dart';

class ImageOptimizerService extends BaseService {
  final bool isAuthNeeded;

  ImageOptimizerService({this.isAuthNeeded = true});

  @override
  bool isToAddAuthorization() {
    return isAuthNeeded;
  }

  @override
  Map<String, String> getHeaders(bool? isToAddAuth) {
    return {
      ...(isToAddAuth ?? isToAddUserAuth()) ? CoreHeaders.X_USER_AUTH : {},
    };
  }

  @override
  ServiceGroupsMixin getServiceGroup() {
    return TRCServiceGroups.imageOptimiser;
  }
}
