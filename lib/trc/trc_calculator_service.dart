import 'package:core_widgets/src/resources/services/base_service.dart';
import 'package:flutter_trc/qc/modules/qc_tester/calculator/resources/calculator_service.dart';
import 'package:flutter_trc/src/services/trc_service.dart';

class TrcCalculatorService extends CalculatorService {
  @override
  BaseService getService() {
    return TrcService();
  }
}
