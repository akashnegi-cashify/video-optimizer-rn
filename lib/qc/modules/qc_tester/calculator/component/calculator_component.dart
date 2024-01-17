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
import 'package:flutter_trc/src/app_builder/app_builder_groups/groups.dart';
import 'package:flutter_trc/src/app_builder/app_headers/general_app_header/models/none_config_model.dart';
import 'package:flutter_trc/src/libraries/shared_prefrences/app_prefrences.dart';
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
    return FutureBuilder<bool?>(
      builder: (_, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
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
            deviceId: "d_id",
            ruleExecutorServiceGroup: Validator.isTrue(snapshot.data) ? TRCServiceGroups.qc : TRCServiceGroups.trc,
            handleQuoteRequest: (QuoteRequestData requestData, String? partialQuoteId, String? udid) {
              if (calculatorResponse?.manualAuditQuestions != null) {
                _showDisputedQuestions(context, calculatorResponse?.manualAuditQuestions, requestData, partialQuoteId,
                    udid, snapshot.data);
              } else {
                var myRequest = MyQuoteRequestData(requestData: requestData);
                _moveToNextScreen(
                  context,
                  requestData: myRequest,
                  partialQuoteId: partialQuoteId,
                  udid: udid,
                  isLoginFromQC: snapshot.data,
                );
              }
              // exit(0);
            },
          );
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
      future: AppPreferences().getIsLoginFromQC(),
    );
  }

  void _moveToNextScreen(BuildContext context,
      {required MyQuoteRequestData requestData, String? partialQuoteId, String? udid, bool? isLoginFromQC}) {
    CalculatorDataHolderModel().quoteRequestData = requestData;

    bool isCaptureMediaMandatory;
    if (Validator.isTrue(isLoginFromQC)) {
      isCaptureMediaMandatory = CalculatorDataHolderModel().isCaptureMediaMandatoryInQC;
    } else {
      isCaptureMediaMandatory = CalculatorDataHolderModel().isCaptureMediaMandatoryInTRC;
    }

    if (CalculatorDataHolderModel().isDeviceTypeLob() || !isCaptureMediaMandatory) {
      Navigator.of(context).pushNamed(SubmitDeviceQuoteScreen.route);
    } else {
      Navigator.of(context).pushNamed(CalculatorMediaCaptureScreen.route);
    }
  }

  void _showDisputedQuestions(BuildContext context, List<ManualAuditQuestionItem>? manualAuditQuestions,
      QuoteRequestData requestData, String? partialQuoteId, String? udid, bool? isLoginFromQc) {
    DisputedQuestionScreen.pushNamed(
      context,
      disputedQuestionList: manualAuditQuestions,
      onComplete: (manualQuestions) {
        MyQuoteRequestData myQuoteRequestData =
            MyQuoteRequestData(manualAuditQuestion: manualQuestions, requestData: requestData);
        _moveToNextScreen(context,
            requestData: myQuoteRequestData, partialQuoteId: partialQuoteId, udid: udid, isLoginFromQC: isLoginFromQc);
      },
    );
  }

  @override
  Function(Map<String, dynamic> data)? fromConfig() {
    return NoneConfigModel.fromConfig;
  }
}
