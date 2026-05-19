import 'package:core_widgets/src/resources/services/base_service.dart';
import 'package:flutter_trc/qc/modules/qc_tester/calculator/resources/calculator_service.dart';
import 'package:flutter_trc/src/services/qc_service.dart';

class QcCalculatorService extends CalculatorService {
  @override
  BaseService getService() {
    return QcService();
  }
}
