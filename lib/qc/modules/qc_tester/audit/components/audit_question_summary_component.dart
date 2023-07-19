import 'package:builder_component/builder_component.dart';
import 'package:core_widgets/core_widgets.dart';
import 'package:csh_annotation/annotation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/qc/resources/qc_common_config.dart';
import 'package:flutter_trc/src/app_builder/app_builder_groups/groups.dart';
import 'package:provider/provider.dart';

import '../l10n.dart';
import '../models/audit_question_response.dart';
import '../models/audit_question_summary_comp_param.dart';
import '../providers/audit_submission_provider.dart';
import '../screens/audit_barcode_scanner_screen.dart';
import '../widgets/submitted_question_widget.dart';

part 'audit_question_summary_component.g.dart';

@CshComponent(
    key: AuditQuestionSummaryComponent.COMP_KEY,
    configModel: QcCommonConfigModel,
    paramModel: AuditQuestionSummaryCompParam,
    params: AuditQuestionSummaryCompParamKeys.values,
    componentGroup: ComponentGroup.auditQuestionSummaryComponentKey)
class AuditQuestionSummaryComponent extends StatelessComponent<QcCommonConfigModel> {
  static const String COMP_KEY = "audit_question_summary";

  const AuditQuestionSummaryComponent(super.jsonConfig, {super.key});

  @override
  Widget buildView(BuildContext context, QcCommonConfigModel? configModel) {
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
    return QcCommonConfigModel.fromConfig;
  }
}

class _AuditSummary extends StatelessWidget {
  final AuditQuestionResponse? dataModel;

  final String scannedBarcode;

  const _AuditSummary({
    Key? key,
    required this.scannedBarcode,
    this.dataModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var l10n = L10n(context);
    var theme = Theme.of(context);
    var provider = AuditQuestionSubmitProvider.of(context);
    return (dataModel != null && !Validator.isListNullOrEmpty(dataModel!.questionList))
        ? Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemBuilder: (context, index) {
                    return SubmittedQuestionWidget(
                      questionNumber: index,
                      question: dataModel!.questionList![index].question ?? "",
                      answeredQuestion: dataModel!.questionList![index].selectedOption ?? "",
                    );
                  },
                  itemCount: dataModel!.questionList!.length,
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
    if (!Validator.isListNullOrEmpty(dataModel?.questionList)) {
      for (var element in dataModel!.questionList!) {
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
    provider.submitAuditQuestion(scannedBarcode, dataMap).then((value) {
      CshLoading().hideLoading(context);
      CshSnackBar.success(context: context, message: l10n.dataSubmittedSuccessfully);
      Navigator.of(context).pushNamedAndRemoveUntil(AuditBarcodeScannerScreen.route, (route) => false);
    }, onError: (error) {
      CshLoading().hideLoading(context);
      CshSnackBar.error(context: context, message: error);
    });
  }
}
