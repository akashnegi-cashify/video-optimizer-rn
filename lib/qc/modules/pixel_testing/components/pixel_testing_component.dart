import 'package:builder_component/builder_component.dart';
import 'package:calculator/calculator.dart';
import 'package:calculator_ui/calculator_ui.dart';
import 'package:core/core.dart';
import 'package:core_widgets/core_widgets.dart';
import 'package:csh_annotation/annotation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/qc/modules/qc_actions/qc_action_screen.dart';
import 'package:flutter_trc/qc/modules/qc_tester/calculator/models/calculator_data_holder_model.dart';
import 'package:flutter_trc/qc/modules/qc_tester/calculator/resources/qc_calculator_service.dart';
import 'package:flutter_trc/src/common/utils/csh_ml_scanner_util.dart';
import 'package:flutter_trc/src/services/service_groups.dart';
import 'package:provider/provider.dart';

import '../../../../src/app_builder/app_builder_groups/qc_groups.dart';
import '../../../../src/app_builder/app_headers/general_app_header/models/none_config_model.dart';
import '../models/pixel_testing_param_model.dart';
import '../screens/pixel_testing_screen.dart';

part 'pixel_testing_component.g.dart';

@CshComponent(
  key: PixelTestingComponent.COMP_KEY,
  configModel: NoneConfigModel,
  componentGroup: QcComponentGroup.qcPixelTestingComponentKey,
  paramModel: PixelTestingParamModel,
  params: PixelTestingParamKeys.values,
)
class PixelTestingComponent extends StatelessComponent<NoneConfigModel> {
  static const String COMP_KEY = "QC_pixel_testing_component";

  const PixelTestingComponent(super.jsonConfig, {super.key});

  @override
  Widget buildView(BuildContext context, NoneConfigModel? configModel) {
    var calculatorResponse = CalculatorDataHolderModel().calculatorResponse;
    var deviceBarcode = CalculatorDataHolderModel().deviceBarcode;

    return CalculatorScreen(
      CalculatorScreenArgs(
          isCurrentDevice: 0,
          pickupMode: '',
          exppt: '',
          serviceId: '',
          sourceId: '',
          calculatorResponse: calculatorResponse,
          preSelection: calculatorResponse?.userSelection,
          deviceBarcode: deviceBarcode,
          showHint: false),
      showSummary: true,
      deviceId: "d_id",
      ruleExecutorServiceGroup: TRCServiceGroups.qcConsole,
      handleQuoteRequest: (QuoteRequestData requestData, String? partialQuoteId, String? udid) {
        _moveToNextScreen(context, requestData: requestData, deviceBarcode: deviceBarcode);
      },
    );
  }

  void _moveToNextScreen(BuildContext context, {required QuoteRequestData requestData, String? deviceBarcode}) {
    CshLoading().showLoading(context);
    QcCalculatorService().submitPixelCalculatorResponse(requestData, deviceBarcode).listen((event) {
      CshLoading().hideLoading(context);
      _showSuccessBottomSheet(context);
    }, onError: (error) {
      CshLoading().hideLoading(context);
      String errorMessage = ApiErrorHelper.getErrorMessage(error).toString();
      CshSnackBar.error(context: context, message: errorMessage);
    });
  }

  _showSuccessBottomSheet(context) {
    showCshBottomSheet(
        context: context,
        isDismissible: false,
        child: Padding(
          padding: EdgeInsets.all(Dimens.space_24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CshTextNew.subTitle1("Response successfully submitted."),
              const SizedBox(height: Dimens.space_16),
              ComboButton(
                firstBtnText: "Done",
                secondBtnText: "Scan Another",
                isFirstPrimary: false,
                firstBtnClick: () {
                  Navigator.pop(context); // dismiss bottom sheet
                  Navigator.popUntil(context, (route) => route.settings.name == QcActionScreen.route);
                },
                secondBtnClick: () {
                  Navigator.pop(context); // dismiss bottom sheet
                  CshMlScannerUtil().openScanner(
                    context,
                    onScanned: (scannedData, controller) {
                      Navigator.pop(context); // dismiss scanner
                      _getCalculator(context, scannedData);
                    },
                  );
                },
              )
            ],
          ),
        ));
  }

  _getCalculator(BuildContext context, String deviceBarcode) {
    CshLoading().showLoading(context);
    QcCalculatorService().getPixelCalculator(deviceBarcode).listen((event) {
      CshLoading().hideLoading(context);
      CalculatorDataHolderModel().startCalculatorJourney(event, deviceBarcode);
      Navigator.pushNamedAndRemoveUntil(
          context, PixelTestingScreen.route, (route) => route.settings.name == QcActionScreen.route,
          arguments: PixelTestingScreenArgs(deviceBarcode));
    }, onError: (error) {
      CshLoading().hideLoading(context);
      var errorMessage = ApiErrorHelper.getErrorMessage(error).toString();
      CshSnackBar.error(context: context, message: errorMessage);
    });
  }

  @override
  Function(Map<String, dynamic> data)? fromConfig() {
    return NoneConfigModel.fromConfig;
  }
}
