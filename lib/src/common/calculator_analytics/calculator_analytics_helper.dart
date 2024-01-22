import 'package:calculator/calculator.dart';
import 'package:calculator_ui/calculator_ui.dart';
import 'package:flutter_trc/src/common/calculator_analytics/calculator_question_answer_request.dart';
import 'package:flutter_trc/src/libraries/analytics/analytics_controller.dart';
import 'package:flutter_trc/src/libraries/analytics/events/calculator_answer_selected_event.dart';
import 'package:flutter_trc/src/libraries/analytics/events/calculator_finished_event.dart';
import 'package:flutter_trc/src/libraries/analytics/events/calculator_page_view_event.dart';
import 'package:flutter_trc/src/libraries/analytics/events/calculator_summary_view_event.dart';
import 'package:flutter_trc/src/libraries/analytics/events/move_to_previous_screen_event.dart';
import 'package:flutter_trc/src/libraries/analytics/events/re_calculate_event.dart';

class CalculatorAnalyticsHelper implements CshCalculatorAnalytics {
  String deviceBarcode;

  Map<int, List<CalculatorQuestionAnswerRequest>> onAnsweredMap = {};

  CalculatorAnalyticsHelper(this.deviceBarcode);

  @override
  void movingToNextPage(int newPageNo) {
    var questionAnswerList = onAnsweredMap[newPageNo - 1];
    AnalyticsController.logEvent(CalculatorAnswerSelectedEvent(deviceBarcode, newPageNo - 1, questionAnswerList));
  }

  @override
  void movingToPreviousScreen() {
    AnalyticsController.logEvent(MoveToPreviousScreenEvent(deviceBarcode));
  }

  @override
  void onFinished(QuoteRequestData quoteRequestData, String? partialQuoteId) {
    AnalyticsController.logEvent(CalculatorFinishedEvent(deviceBarcode, quoteRequestData));
  }

  @override
  void onPageViewed(int pageNo, List<Question> questionList) {
    AnalyticsController.logEvent(CalculatorPageViewEvent(deviceBarcode, pageNo, _getQuestionAnswerIds(questionList)));
  }

  @override
  void onQuestionAnswered(int pageNo, Question question, Option? selectedOption) {
    List<CalculatorQuestionAnswerRequest>? questionAnswerSet = [];
    if (onAnsweredMap[pageNo] != null) {
      questionAnswerSet = onAnsweredMap[pageNo];
    }
    questionAnswerSet
        ?.add(CalculatorQuestionAnswerRequest(question.questionId, selectedOption?.id, DateTime.now().toString()));
    onAnsweredMap[pageNo] = questionAnswerSet ?? [];
  }

  Map<String, List<int>> _getQuestionAnswerIds(List<Question> questionList) {
    Map<String, List<int>> questionAnswerMap = {};
    for (var question in questionList) {
      questionAnswerMap[question.questionId.toString()] = question.options?.map((e) => e.id!).toList() ?? [];
    }
    return questionAnswerMap;
  }

  @override
  void onCalculatorSummaryViewed() {
    AnalyticsController.logEvent(CalculatorSummaryViewEvent(deviceBarcode));
  }

  @override
  void onReCalculate() {
    AnalyticsController.logEvent(ReCalculateEvent(deviceBarcode));
  }
}
