import 'dart:async';

import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/qc/modules/qc_tester/calculator/providers/submit_device_quote_provider.dart';
import 'package:flutter_trc/qc/modules/qc_tester/calculator/widgets/qc_alert_pop_widget.dart';
import 'package:flutter_trc/qc/modules/qc_tester/home/screens/qc_tester_home_screen.dart';
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
    Future.delayed(const Duration(milliseconds: 500), () {
      var provider = SubmitDeviceQuoteProvider.of(context, listen: false);
      provider.setDeviceQuoteInterface(this);
      provider.getDeviceColors();
    });
  }

  @override
  Widget build(BuildContext context) {
    var provider = SubmitDeviceQuoteProvider.of(context);
    return Column(
      children: [
        CshStepper(
          key: UniqueKey(),
          stepDetails: provider.stepperDetails ?? [],
          isShowedButton: false,
        ),
        const SizedBox(height: Dimens.space_16),
        if (Validator.isTrue(provider.isShowCompleteState))
          CshBigButton(
            text: "Done",
            onPressed: () {
              AppPreferences().getIsLoginFromQC().then((value) {
                if (Validator.isTrue(value)) {
                  Navigator.popUntil(context, (route) => route.settings.name == QcTesterHomeScreen.route);
                } else {
                  Navigator.popUntil(context, (route) => route.settings.name == TrcTesterScreen.route);
                }
              });
            },
          ),
        if (Validator.isTrue(provider.isShowTryAgainState))
          Row(
            children: [
              Expanded(
                child: CshBigButton(
                  text: "Try Again",
                  onPressed: () {
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
                    Navigator.popUntil(context, (route) => route.settings.name == QcTesterHomeScreen.route);
                  },
                ),
              ),
            ],
          )
      ],
    );
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
      Navigator.popUntil(context, (route) => route.settings.name == QcTesterHomeScreen.route);
    }, buttonTitle: "Go Back");
  }

  void _showColorSelectionDialog(List<String> colors) {
    String? selectedColor;
    showCshBottomSheet(
      isDismissible: false,
      context: context,
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
                          Navigator.pop(context);
                          var provider = SubmitDeviceQuoteProvider.of(context, listen: false);
                          provider.onColorSelected(selectedColor!);
                        },
                ),
              )
            ],
          ),
        );
      }),
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
}

abstract interface class SubmitDeviceQuoteInterface {
  void onDeviceColorFetchedSuccess(List<String> colors);

  void onSubmitCalculatorSuccess(String? grade, String? cautionMessage);

  void onSubmitCalculatorError(String? errorMessage);

  void showLoading(bool isShow);

  void removeAllLoader();
}
