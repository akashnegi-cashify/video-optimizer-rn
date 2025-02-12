import 'package:builder_component/builder_component.dart';
import 'package:calculator/calculator.dart';
import 'package:calculator_ui/calculator_ui.dart';
import 'package:csh_annotation/annotation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/qc/modules/qc_tester/calculator/models/calculator_data_holder_model.dart';
import 'package:flutter_trc/qc/modules/qc_tester/calculator/resources/my_calculator_response.dart';
import 'package:flutter_trc/qc/modules/qc_tester/calculator/resources/my_quote_request_data.dart';
import 'package:flutter_trc/qc/modules/qc_tester/calculator/screens/disputed_questions_screen.dart';
import 'package:flutter_trc/qc/modules/qc_tester/calculator_media_capture/calculator_media_capture_screen.dart';
import 'package:flutter_trc/src/app_builder/app_builder_groups/groups.dart';
import 'package:flutter_trc/src/app_builder/app_headers/general_app_header/models/none_config_model.dart';
import 'package:flutter_trc/src/common/calculator_analytics/calculator_analytics_helper.dart';
import 'package:flutter_trc/src/libraries/shared_preferences/app_preferences.dart';
import 'package:flutter_trc/src/modules/login/resources/login_types.dart';
import 'package:flutter_trc/src/services/service_groups.dart';

part 'calculator_component.g.dart';

@CshComponent(
    key: CalculatorComponent.COMP_KEY,
    configModel: NoneConfigModel,
    componentGroup: ComponentGroup.calculatorComponentKey)
class CalculatorComponent extends StatelessComponent<NoneConfigModel> {
  static const String COMP_KEY = "calculator_component";

  const CalculatorComponent(super.jsonConfig, {super.key});

  @override
  Widget buildView(BuildContext context, NoneConfigModel? configModel) {
    var calculatorResponse = CalculatorDataHolderModel().calculatorResponse;
    var deviceBarcode = CalculatorDataHolderModel().deviceBarcode;

    var loginTypeEnum = LoginTypes.fromValue(AppPreferences.app.getLoginType() ?? LoginTypes.qcLogin.value);
    var isQcLogin = loginTypeEnum == LoginTypes.qcLogin;
    return CalculatorScreen(
      CalculatorScreenArgs(
          isCurrentDevice: 0,
          pickupMode: '',
          exppt: '',
          serviceId: '',
          sourceId: '',
          calculatorResponse: calculatorResponse,
          preSelection: null,
          deviceBarcode: deviceBarcode,
          showHint: false),
      showSummary: true,
      calculatorAnalytics: isQcLogin ? CalculatorAnalyticsHelper(deviceBarcode ?? "") : null,
      deviceId: "d_id",
      ruleExecutorServiceGroup: isQcLogin ? TRCServiceGroups.qc : TRCServiceGroups.trc,
      handleQuoteRequest: (QuoteRequestData requestData, String? partialQuoteId, String? udid) {
        if (calculatorResponse?.manualAuditQuestions != null) {
          _showDisputedQuestions(
              context, calculatorResponse?.manualAuditQuestions, requestData, partialQuoteId, udid, isQcLogin);
        } else {
          var myRequest = MyQuoteRequestData(requestData: requestData);
          _moveToNextScreen(context, requestData: myRequest);
        }
        // exit(0);
      },
    );
  }

  void _moveToNextScreen(BuildContext context, {required MyQuoteRequestData requestData}) {
    CalculatorDataHolderModel().quoteRequestData = requestData;
    CalculatorMediaCaptureScreen.navigateTo(context, CalculatorDataHolderModel().deviceBarcode!,
        isComingFromCalculatorJourney: true);
  }

  void _showDisputedQuestions(BuildContext context, List<ManualAuditQuestionItem>? manualAuditQuestions,
      QuoteRequestData requestData, String? partialQuoteId, String? udid, bool? isLoginFromQc) {
    DisputedQuestionScreen.pushNamed(
      context,
      disputedQuestionList: manualAuditQuestions,
      onComplete: (manualQuestions) {
        MyQuoteRequestData myQuoteRequestData =
            MyQuoteRequestData(manualAuditQuestion: manualQuestions, requestData: requestData);
        _moveToNextScreen(context, requestData: myQuoteRequestData);
      },
    );
  }

  @override
  Function(Map<String, dynamic> data)? fromConfig() {
    return NoneConfigModel.fromConfig;
  }
}
