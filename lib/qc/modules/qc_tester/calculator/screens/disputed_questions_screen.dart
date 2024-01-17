import 'package:builder_project/builder_project.dart';
import 'package:csh_annotation/annotation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/qc/modules/qc_tester/calculator/models/disputed_question_comp_param.dart';
import 'package:flutter_trc/qc/modules/qc_tester/calculator/resources/my_calculator_response.dart';
import 'package:flutter_trc/src/app_builder/app_builder_groups/groups.dart';

part 'disputed_questions_screen.g.dart';

@CshPage(
    key: DisputedQuestionScreen.pageKey,
    pageGroup: PageGroup.disputedQuestionsPageKey,
    params: DisputedQuestionParamKeys.values)
class DisputedQuestionsScreenArguments extends BaseArguments {
  final List<ManualAuditQuestionItem>? disputedQuestionList;

  DisputedQuestionsScreenArguments({
    this.disputedQuestionList,
  }) : super(DisputedQuestionScreen.pageKey);

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = {};
    data[DisputedQuestionParamKeys.disputedQuestionList.value] = disputedQuestionList;
    return data;
  }
}

class DisputedQuestionScreen extends BaseScreen<DisputedQuestionsScreenArguments> {
  static const String pageKey = "disputed_questions";
  static const String route = "/disputed-question";

  const DisputedQuestionScreen({super.key});

  @override
  Widget buildView(BuildContext context) {
    var args = getArguments(context);
    return PageWidget(
      pageKey: pageKey,
      initialValue: args?.toJson(),
    );
  }

  static pushNamed(
    BuildContext context, {
    required List<ManualAuditQuestionItem>? disputedQuestionList,
    required Function(List<int> manualQuestions) onComplete,
  }) {
    var args = DisputedQuestionsScreenArguments(disputedQuestionList: disputedQuestionList);
    Navigator.pushNamed(context, route, arguments: args).then((value) {
      if (value != null) {
        if (value is List<int>) {
          onComplete(value);
        }
      }
    });
  }
}
