import 'package:builder_component/builder_component.dart';
import 'package:calculator/calculator.dart';
import 'package:calculator_ui/calculator_ui.dart';
import 'package:core_widgets/core_widgets.dart';
import 'package:csh_annotation/annotation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/qc/modules/qc_tester/calculator/models/calculator_data_holder_model.dart';
import 'package:flutter_trc/qc/modules/qc_tester/calculator/resources/my_calculator_response.dart';
import 'package:flutter_trc/qc/modules/qc_tester/calculator/resources/my_quote_request_data.dart';
import 'package:flutter_trc/qc/modules/qc_tester/calculator/screens/disputed_questions_screen.dart';
import 'package:flutter_trc/qc/modules/qc_tester/calculator/screens/submit_device_quote_screen.dart';
import 'package:flutter_trc/qc/modules/qc_tester/calculator_media_capture/calculator_media_capture_screen.dart';
import 'package:flutter_trc/qc/resources/qc_common_config.dart';
import 'package:flutter_trc/src/app_builder/app_builder_groups/groups.dart';


part 'calculator_component.g.dart';

@CshComponent(
    key: CalculatorComponent.COMP_KEY,
    configModel: QcCommonConfigModel,
    componentGroup: ComponentGroup.calculatorComponentKey)
class CalculatorComponent extends StatelessComponent<QcCommonConfigModel> {
  static const String COMP_KEY = "calculator_component";

  const CalculatorComponent(super.jsonConfig, {super.key});

  @override
  Widget buildView(BuildContext context, QcCommonConfigModel? configModel) {
    var _calculatorResponse = CalculatorDataHolderModel().calculatorResponse;
    return CalculatorScreen(
      CalculatorScreenArgs(
          isCurrentDevice: 0,
          pickupMode: '',
          exppt: '',
          serviceId: '',
          sourceId: '',
          calculatorResponse: _calculatorResponse,
          preSelection: null,
          mode: CalculatorMode.defaultMode,
          showHint: false),
      showSummary: true,
      deviceId: "d_id",
      ruleExecutorServiceGroup: ServiceGroups.qc,
      handleQuoteRequest: (QuoteRequestData requestData, String? partialQuoteId, String? udid) {
        if (_calculatorResponse?.manualAuditQuestions != null) {
          _showDisputedQuestions(context, _calculatorResponse?.manualAuditQuestions, requestData, partialQuoteId, udid);
        } else {
          var myRequest = MyQuoteRequestData(requestData: requestData);
          _moveToNextScreen(context, myRequest, partialQuoteId, udid);
        }
        // exit(0);
      },
    );
  }

  void _moveToNextScreen(BuildContext context, MyQuoteRequestData requestData, String? partialQuoteId, String? udid) {
    CalculatorDataHolderModel().quoteRequestData = requestData;

    if (CalculatorDataHolderModel().isDeviceTypeLob() || !CalculatorDataHolderModel().isCaptureMediaMandatory) {
      Navigator.of(context).pushReplacementNamed(SubmitDeviceQuoteScreen.route);
    } else {
      Navigator.of(context).pushReplacementNamed(CalculatorMediaCaptureScreen.route);
    }
  }

  void _showDisputedQuestions(BuildContext context, List<ManualAuditQuestionItem>? manualAuditQuestions,
      QuoteRequestData requestData, String? partialQuoteId, String? udid) {
    DisputedQuestionsScreenArguments args =
        DisputedQuestionsScreenArguments(disputedQuestionList: manualAuditQuestions);
    Navigator.pushNamed(context, DisputedQuestionScreen.route, arguments: args).then(
      (value) {
        if (value != null) {
          if (value is List<int>) {
            MyQuoteRequestData myQuoteRequestData =
                MyQuoteRequestData(manualAuditQuestion: value, requestData: requestData);
            _moveToNextScreen(context, myQuoteRequestData, partialQuoteId, udid);
          }
        }
      },
    );
  }

  @override
  Function(Map<String, dynamic> data)? fromConfig() {
    return QcCommonConfigModel.fromConfig;
  }
}
