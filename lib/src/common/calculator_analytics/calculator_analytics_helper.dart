import 'package:calculator/calculator.dart';
import 'package:calculator_ui/calculator_ui.dart';
import 'package:flutter_trc/src/libraries/analytics/analytics_controller.dart';
import 'package:flutter_trc/src/libraries/analytics/events/calculator_page_view_event.dart';

class CalculatorAnalyticsHelper implements CshCalculatorAnalytics {
  @override
  void movingToNextPage() {
    // TODO: implement movingToNextPage
  }

  @override
  void movingToPreviousScreen() {
    // TODO: implement movingToPreviousScreen
  }

  @override
  void onFinished(QuoteRequestData quoteRequestData, String? partialQuoteId) {
    // TODO: implement onFinished
  }

  @override
  void onPageViewed(int pageNo, List<Question> questionList) {
    AnalyticsController.logEvent(CalculatorPageViewEvent(pageNo, _getQuestionAnswerIds(questionList)));
  }

  @override
  void onQuestionAnswered(int pageNo, Question question, Option? selectedOption) {
    // TODO: implement onQuestionAnswered
  }


  Map<String, List<int>> _getQuestionAnswerIds(List<Question> questionList) {
    Map<String, List<int>> questionAnswerMap = {};
    questionList.map((question) {
      questionAnswerMap[question.questionId!] = question.options?.map((e) => e.id!).toList() ?? [];
    });
    return questionAnswerMap;
  }

}
