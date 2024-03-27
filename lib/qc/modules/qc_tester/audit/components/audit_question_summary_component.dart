import 'dart:async';

import 'package:builder_component/builder_component.dart';
import 'package:calculator_ui/calculator_ui.dart';
import 'package:core_widgets/core_widgets.dart';
import 'package:csh_annotation/annotation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/qc/modules/qc_tester/audit/resources/new_audit_response.dart';
import 'package:flutter_trc/qc/modules/qc_tester/home/screens/qc_tester_home_screen.dart';
import 'package:flutter_trc/src/app_builder/app_builder_groups/groups.dart';
import 'package:flutter_trc/src/app_builder/app_headers/general_app_header/models/none_config_model.dart';
import 'package:provider/provider.dart';

import '../l10n.dart';
import '../models/audit_question_summary_comp_param.dart';
import '../providers/audit_submission_provider.dart';
import '../screens/audit_barcode_scanner_screen.dart';
import '../widgets/submitted_question_widget.dart';

part 'audit_question_summary_component.g.dart';

@CshComponent(
    key: AuditQuestionSummaryComponent.COMP_KEY,
    configModel: NoneConfigModel,
    paramModel: AuditQuestionSummaryCompParam,
    params: AuditQuestionSummaryCompParamKeys.values,
    componentGroup: ComponentGroup.auditQuestionSummaryComponentKey)
class AuditQuestionSummaryComponent extends StatelessComponent<NoneConfigModel> {
  static const String COMP_KEY = "audit_question_summary";

  const AuditQuestionSummaryComponent(super.jsonConfig, {super.key});

  @override
  Widget buildView(BuildContext context, NoneConfigModel? configModel) {
    return paramBuilder((param) {
      return ChangeNotifierProvider<AuditQuestionSubmitProvider>(
        create: (_) => AuditQuestionSubmitProvider(),
        lazy: false,
        builder: (BuildContext innerContext, __) {
          var provider = AuditQuestionSubmitProvider.of(innerContext);
          return _AuditSummary(
            scannedBarcode: param.scannedBarcode ?? "",
            dataModel: param.questionDataModel,
          );
        },
      );
    });
  }

  // appBar: CshHeader(
  // l10n.auditSummary,
  // showBackBtn: true,
  // )

  @override
  Function(Map<String, dynamic> data)? fromConfig() {
    return NoneConfigModel.fromConfig;
  }
}

class _AuditSummary extends StatefulWidget {
  final AuditQuestionResponse? dataModel;

  final String scannedBarcode;

  const _AuditSummary({
    Key? key,
    required this.scannedBarcode,
    this.dataModel,
  }) : super(key: key);

  @override
  State<_AuditSummary> createState() => _AuditSummaryState();
}

class _AuditSummaryState extends State<_AuditSummary> {
  @override
  void initState() {
    if (!Validator.isListNullOrEmpty(widget.dataModel?.manualAuditQuestionList)) {
      scheduleMicrotask(() {
        _openManualAuditQuestionModal(widget.dataModel!.manualAuditQuestionList!);
      });
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var l10n = L10n(context);
    var theme = Theme.of(context);
    return (widget.dataModel != null && !Validator.isListNullOrEmpty(widget.dataModel!.auditQuestionList))
        ? Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemBuilder: (context, index) {
                    return SubmittedQuestionWidget(
                      questionNumber: index,
                      question: widget.dataModel!.auditQuestionList![index].question ?? "",
                      answeredQuestion: widget.dataModel!.auditQuestionList![index].selectedOption ?? "",
                    );
                  },
                  itemCount: widget.dataModel!.auditQuestionList!.length,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: Dimens.space_20, horizontal: Dimens.space_16),
                child: SizedBox(
                  width: double.infinity,
                  child: CshMediumButton(
                    text: l10n.done,
                    onPressed: () {
                      Map<String, dynamic> data = _createPostDataMap();
                      _submitQuestionsResults(l10n, context, data);
                    },
                  ),
                ),
              )
            ],
          )
        : Center(
            child: Text(
              l10n.noSummaryFound,
              style: theme.primaryTextTheme.displaySmall,
            ),
          );
  }

  _createPostDataMap() {
    Map<String, dynamic> postDataMap = {};
    if (!Validator.isListNullOrEmpty(widget.dataModel?.auditQuestionList)) {
      for (var element in widget.dataModel!.auditQuestionList!) {
        if (element.selectedOption != null && !Validator.isListNullOrEmpty(element.options!.values.toList())) {
          String key = element.options!.keys
              .firstWhere((item) => element.options![item] == element.selectedOption, orElse: () => "");

          if (!Validator.isNullOrEmpty(key)) {
            postDataMap[element.questionId?.toString() ?? ""] = {
              "vi": int.parse(key),
              "iurl": element.s3url,
            };
          }
        }
      }
    }
    print("post data map response $postDataMap");
    return postDataMap;
  }

  _submitQuestionsResults(L10n l10n, BuildContext context, Map<String, dynamic> dataMap) {
    var provider = AuditQuestionSubmitProvider.of(context, listen: false);
    CshLoading().showLoading(context);
    provider.submitAuditQuestion(widget.scannedBarcode, dataMap).then((value) {
      CshLoading().hideLoading(context);
      CshSnackBar.success(
        context: context,
        message: l10n.dataSubmittedSuccessfully,
        snackBarPosition: SnackBarPosition.TOP,
      );
      _getDeviceStatus(provider, context);
    }, onError: (error) {
      CshLoading().hideLoading(context);
      CshSnackBar.error(context: context, message: error);
    });
  }

  _getDeviceStatus(AuditQuestionSubmitProvider provider, BuildContext context) {
    CshLoading().showLoading(context);
    provider.getDeviceStatus(widget.scannedBarcode).then((value) {
      CshLoading().hideLoading(context);
      _showDeviceStatusDialog(context, value);
    }, onError: (e) {
      CshLoading().hideLoading(context);
      _showRetryDialog(context, provider, e.toString());
    });
  }

  _showDeviceStatusDialog(BuildContext context, String deviceStatus) {
    showAlertDialog(context, title: "Channel", desc: deviceStatus, onPosBtnPressed: (_) {
      Navigator.pop(context); // dismiss dialog
      Navigator.of(context).pushNamedAndRemoveUntil(
          AuditBarcodeScannerScreen.route, (route) => route.settings.name == QcTesterHomeScreen.route);
    });
  }

  _showRetryDialog(BuildContext context, AuditQuestionSubmitProvider provider, String errorMessage) {
    showCshBottomSheet(
        context: context,
        child: Padding(
          padding: const EdgeInsets.all(Dimens.space_20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              CshTextNew.subTitle1("Error!!"),
              const SizedBox(height: Dimens.space_20),
              CshTextNew.subTitle2(errorMessage),
              const SizedBox(height: Dimens.space_20),
              ComboButton(
                firstBtnText: "Go back",
                secondBtnText: "Retry",
                isFirstPrimary: true,
                firstBtnClick: () {
                  Navigator.pop(context); // dismiss dialog
                  Navigator.of(context).pushNamedAndRemoveUntil(AuditBarcodeScannerScreen.route, (route) => false);
                },
                secondBtnClick: () {
                  Navigator.pop(context); // dismiss dialog
                  _getDeviceStatus(provider, context);
                },
              )
            ],
          ),
        ));
  }

  void _openManualAuditQuestionModal(List<ManualAuditQuestionItem> questionList) {
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
                CshTextNew.h4("Verify these questions"),
                const SizedBox(height: Dimens.space_24),
                Expanded(
                  child: ListView.separated(
                    itemCount: questionList.length,
                    itemBuilder: (_, index) {
                      var item = questionList[index];
                      return CshCheckbox(
                        title: CshTextNew.subTitle1(item.question ?? ""),
                        isSelected: item.isSelected ?? false,
                        onChanged: (value) {
                          setState(() {
                            item.isSelected = value;
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
                    onPressed: () {
                      var provider = AuditQuestionSubmitProvider.of(context, listen: false);
                      Navigator.pop(context); // Dismiss dialog
                      provider.onManualQuestionAnswered(questionList);
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
}
