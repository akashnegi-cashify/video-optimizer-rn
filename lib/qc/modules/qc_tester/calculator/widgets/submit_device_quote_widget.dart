import 'dart:async';

import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/qc/modules/qc_tester/calculator/providers/submit_device_quote_provider.dart';
import 'package:flutter_trc/qc/modules/qc_tester/calculator/resources/manual_question_list_response.dart';
import 'package:flutter_trc/qc/modules/qc_tester/calculator/widgets/qc_alert_pop_widget.dart';
import 'package:flutter_trc/qc/modules/qc_tester/home/screens/qc_tester_home_screen.dart';
import 'package:flutter_trc/src/libraries/analytics/analytics_controller.dart';
import 'package:flutter_trc/src/libraries/analytics/events/additional_questions_view_event.dart';
import 'package:flutter_trc/src/libraries/analytics/events/color_selected_event.dart';
import 'package:flutter_trc/src/libraries/analytics/events/color_view_event.dart';
import 'package:flutter_trc/src/libraries/analytics/events/end_testing_session_event.dart';
import 'package:flutter_trc/src/libraries/shared_prefrences/app_prefrences.dart';
import 'package:flutter_trc/src/modules/trc_tester/trc_tester_screen.dart';
import 'package:provider/provider.dart';

class SubmitDeviceQuoteWidget extends StatelessWidget {
  const SubmitDeviceQuoteWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => SubmitDeviceQuoteProvider(),
      lazy: false,
      child: const SubmitDeviceQuoteWidgetBody(),
    );
  }
}

class SubmitDeviceQuoteWidgetBody extends StatefulWidget {
  const SubmitDeviceQuoteWidgetBody({super.key});

  @override
  State<SubmitDeviceQuoteWidgetBody> createState() => _SubmitDeviceQuoteWidgetState();
}

class _SubmitDeviceQuoteWidgetState extends State<SubmitDeviceQuoteWidgetBody> implements SubmitDeviceQuoteInterface {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 500), () async {
      var provider = SubmitDeviceQuoteProvider.of(context, listen: false);
      provider.setDeviceQuoteInterface(this);
      var isLoginFromQc = await provider.isLoginFromQC();
      if (Validator.isTrue(isLoginFromQc)) {
        provider.getManualQuestions();
      } else {
        provider.getDeviceColors();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var provider = SubmitDeviceQuoteProvider.of(context);
    return PopScope(
      canPop: false,
      child: Column(
        children: [
          CshStepper(
            key: UniqueKey(),
            stepDetails: provider.stepperDetails,
            isShowedButton: false,
          ),
          const SizedBox(height: Dimens.space_16),
          if (Validator.isTrue(provider.isShowCompleteState))
            CshBigButton(
              text: "Done",
              onPressed: () {
                AnalyticsController.logEvent(EndTestingSessionEvent(provider.deviceBarcode, provider.gradeObtained));
                _moveToHomeScreen();
              },
            ),
          if (Validator.isTrue(provider.isShowTryAgainState))
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: Dimens.space_16),
              child: Row(
                children: [
                  Expanded(
                    child: CshBigButton(
                      text: "Try Again",
                      onPressed: () {
                        CshLoading().isLoading = false;
                        CshLoading().showLoading(context);
                        provider.getDeviceStatus();
                      },
                    ),
                  ),
                  const SizedBox(width: Dimens.space_16),
                  Expanded(
                    child: CshBigButton(
                      text: "Go back",
                      onPressed: () {
                        _moveToHomeScreen();
                      },
                    ),
                  ),
                ],
              ),
            )
        ],
      ),
    );
  }

  _moveToHomeScreen() {
    AppPreferences().getIsLoginFromQC().then((value) {
      if (Validator.isTrue(value)) {
        Navigator.popUntil(context, (route) => route.settings.name == QcTesterHomeScreen.route);
      } else {
        Navigator.pushNamedAndRemoveUntil(context, TrcTesterScreen.route, (route) => false);
      }
    });
  }

  @override
  void onDeviceColorFetchedSuccess(List<String> colors) {
    _showColorSelectionDialog(colors);
  }

  @override
  void onSubmitCalculatorSuccess(String? grade, String? cautionMessage) {
    String message;
    if (Validator.isNullOrEmpty(grade)) {
      message = cautionMessage ?? "";
    } else {
      message = "${cautionMessage ?? ""} - Device Grade - $grade";
    }

    qcAlertPopDialog(context, message, onButtonPressed: () {
      Navigator.pop(context);
    }, buttonTitle: "OK");
  }

  @override
  void onSubmitCalculatorError(String? errorMessage) {
    qcAlertPopDialog(context, errorMessage ?? "", onButtonPressed: () {
      _moveToHomeScreen();
    }, buttonTitle: "Go Back");
  }

  void _showColorSelectionDialog(List<String> colors) {
    var provider = SubmitDeviceQuoteProvider.of(context, listen: false);
    AnalyticsController.logEvent(ColorViewEvent(provider.deviceBarcode));
    String? selectedColor;
    showCshBottomSheet(
      isDismissible: false,
      context: context,
      child: PopScope(
        canPop: false,
        child: StatefulBuilder(builder: (_, setState) {
          return Padding(
            padding: const EdgeInsets.all(Dimens.space_16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CshTextNew.h4("Select Color"),
                const SizedBox(height: Dimens.space_16),
                ListView.separated(
                  itemCount: colors.length,
                  shrinkWrap: true,
                  itemBuilder: (_, index) {
                    var item = colors[index];
                    return CshRadio<String>(
                      value: item,
                      groupValue: selectedColor,
                      title: CshTextNew.subTitle1(item),
                      onChanged: (value) {
                        setState(() {
                          selectedColor = value;
                        });
                      },
                    );
                  },
                  separatorBuilder: (BuildContext context, int index) {
                    return const SizedBox(height: Dimens.space_8);
                  },
                ),
                Center(
                  child: CshBigButton(
                    text: "Proceed",
                    onPressed: selectedColor == null
                        ? null
                        : () {
                            Navigator.pop(context); // dismiss color dialog
                            var provider = SubmitDeviceQuoteProvider.of(context, listen: false);
                            AnalyticsController.logEvent(ColorSelectedEvent(provider.deviceBarcode, selectedColor));
                            provider.onColorSelected(selectedColor!);
                          },
                  ),
                )
              ],
            ),
          );
        }),
      ),
    );
  }

  @override
  void showLoading(bool isShow) {
    if (isShow) {
      CshLoading().showLoading(context);
    } else {
      CshLoading().hideLoading(context);
    }
  }

  @override
  void removeAllLoader() {
    Navigator.popUntil(context, (route) => route is PageRoute);
  }

  @override
  void onManualQuestionFetchedSuccess(List<ManualQuestionListData> questionList) {
    var provider = SubmitDeviceQuoteProvider.of(context, listen: false);
    AnalyticsController.logEvent(AdditionalQuestionsViewEvent(provider.deviceBarcode));
    showCshBottomSheet(
      isDismissible: false,
      context: context,
      child: PopScope(
        canPop: false,
        child: StatefulBuilder(builder: (_, setState) {
          return Container(
            height: MediaQuery.of(context).size.height * 0.8,
            padding: const EdgeInsets.all(Dimens.space_16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CshTextNew.h4("Select one or more options"),
                const SizedBox(height: Dimens.space_24),
                Expanded(
                  child: ListView.separated(
                    itemCount: questionList.length,
                    itemBuilder: (_, index) {
                      var item = questionList[index];
                      return CshCheckbox(
                        title: CshTextNew.subTitle1(item.question ?? ""),
                        isSelected: item.value == 1,
                        onChanged: (value) {
                          setState(() {
                            item.value = Validator.isTrue(value) ? 1 : -1;
                          });
                        },
                      );
                    },
                    separatorBuilder: (BuildContext context, int index) {
                      return const SizedBox(height: Dimens.space_16);
                    },
                  ),
                ),
                const SizedBox(height: Dimens.space_16),
                Center(
                  child: CshBigButton(
                    text: "Proceed",
                    onPressed: _isAnyOptionSelected(questionList)
                        ? () {
                            Navigator.pop(context); // Dismiss dialog
                            provider.onManualQuestionAnswered(questionList);
                          }
                        : null,
                  ),
                )
              ],
            ),
          );
        }),
      ),
    );
  }

  bool _isAnyOptionSelected(List<ManualQuestionListData> questionList) {
    for (var question in questionList) {
      if (question.value == 1) {
        return true;
      }
    }
    return false;
  }

  @override
  void showTrcRemarksDialog() {
    TextEditingController controller = TextEditingController();
    showCshBottomSheet(
      isDismissible: false,
        context: context,
        child: PopScope(
          canPop: false,
          child: Container(
            height: MediaQuery.of(context).size.height * 0.7,
            padding: const EdgeInsets.all(Dimens.space_16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: Dimens.space_8),
                CshTextNew.h4("Enter Testing Remarks"),
                const SizedBox(height: Dimens.space_16),
                CshTextFormField(
                  minLines: 5,
                  maxLines: 5,
                  hintText: "Enter Testing Remarks",
                  contentPadding: const EdgeInsets.all(Dimens.space_16),
                  backgroundColor: Colors.grey.shade50,
                  controller: controller,
                ),
                const Expanded(child: SizedBox()),
                CshBigButton(
                  text: "Submit",
                  onPressed: () {
                    String? remarks = controller.text;
                    if (Validator.isNullOrEmpty(remarks)) {
                      CshSnackBar.error(
                        context: context,
                        message: "Please enter remarks",
                        snackBarPosition: SnackBarPosition.TOP,
                      );
                      return;
                    }
                    var provider = SubmitDeviceQuoteProvider.of(context, listen: false);
                    Navigator.pop(context); // Dismiss dialog
                    provider.submitTrcRemarks(remarks);
                  },
                )
              ],
            ),
          ),
        ));
  }
}

abstract interface class SubmitDeviceQuoteInterface {
  void onDeviceColorFetchedSuccess(List<String> colors);

  void onSubmitCalculatorSuccess(String? grade, String? cautionMessage);

  void onSubmitCalculatorError(String? errorMessage);

  void showLoading(bool isShow);

  void removeAllLoader();

  void onManualQuestionFetchedSuccess(List<ManualQuestionListData> questionList);

  void showTrcRemarksDialog();
}
