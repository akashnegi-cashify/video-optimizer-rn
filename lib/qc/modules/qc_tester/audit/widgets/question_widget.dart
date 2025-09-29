import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/src/utils/media_upload/widgets/image_upload_widget.dart';

import '../l10n.dart';
import '../providers/audit_questions_provider.dart';

class AuditQuestionWidget extends StatefulWidget {
  final int questionNumber;
  final Function(int, String) onOptionSelected;

  const AuditQuestionWidget({
    super.key,
    required this.onOptionSelected,
    required this.questionNumber,
  });

  @override
  State<AuditQuestionWidget> createState() => _AuditQuestionWidgetState();
}

class _AuditQuestionWidgetState extends State<AuditQuestionWidget> {
  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var provider = AuditQuestionsProvider.of(context);
    var l10n = L10n(context);
    var auditQuestionList = provider.auditData!.auditQuestionList;
    var auditQuestionData = auditQuestionList![widget.questionNumber];
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(vertical: Dimens.space_20, horizontal: Dimens.space_16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (!Validator.isNullOrEmpty(auditQuestionData.question))
            Row(
              children: [
                const SizedBox(),
                Expanded(
                  child: Text(
                    "${l10n.q}. ${(widget.questionNumber + 1)}  ${auditQuestionData.question!}",
                    style: theme.primaryTextTheme.displayMedium,
                  ),
                )
              ],
            ),
          const SizedBox(height: Dimens.space_8),
          if (!Validator.isListNullOrEmpty(auditQuestionData.options?.values.toList())) ...[
            RadioListWidget(
              // key: Key(auditQuestionData.selectedOption ?? ""),
              list: List.generate(
                auditQuestionData.options!.values.toList().length,
                (index) => RadioListItem(
                  index.toString(),
                  auditQuestionData.options!.values.toList()[index],
                  auditQuestionData.selectedOption == auditQuestionData.options!.values.toList()[index],
                ),
              ),
              onItemSelected: (data) {
                widget.onOptionSelected(auditQuestionData.questionId!, data.label!);
                auditQuestionData.selectedOption = data.label;
                setState(() {});
              },
            ),
            const SizedBox(height: Dimens.space_30),
            if (auditQuestionData.imageCount != null && auditQuestionData.imageCount! == 1)
              Align(
                alignment: Alignment.center,
                child: ImageUploadOptimizerCard(
                  onMediaUploaded: (String? url) {
                    auditQuestionData.s3url = url;
                  },
                ),
              ),
          ]
        ],
      ),
    );
  }
}
