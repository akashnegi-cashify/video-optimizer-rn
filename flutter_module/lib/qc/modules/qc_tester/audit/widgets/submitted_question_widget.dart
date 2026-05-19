import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import '../l10n.dart';

class SubmittedQuestionWidget extends StatelessWidget {
  final int questionNumber;
  final String question;
  final String answeredQuestion;

  const SubmittedQuestionWidget({
    Key? key,
    required this.questionNumber,
    required this.question,
    required this.answeredQuestion,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var l10n = L10n(context);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: Dimens.space_20, horizontal: Dimens.space_16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const SizedBox(),
              Expanded(
                child: Text(
                  "${l10n.q}. ${questionNumber + 1} $question",
                  style: theme.primaryTextTheme.displaySmall,
                ),
              )
            ],
          ),
          const SizedBox(height: Dimens.space_18),
          Row(
            children: [
              const SizedBox(),
              Expanded(
                child: Text(
                  "${l10n.ans}. $answeredQuestion",
                  style: theme.primaryTextTheme.bodyLarge,
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
