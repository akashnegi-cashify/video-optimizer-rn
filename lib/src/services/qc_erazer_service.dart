import 'package:flutter_trc/src/services/qc_service.dart';
import 'package:flutter_trc/src/services/service_groups.dart';

class QcErazerService extends QcService {
  @override
  TRCServiceGroups getServiceGroup() {
    return TRCServiceGroups.qcErazer;
  }
}


