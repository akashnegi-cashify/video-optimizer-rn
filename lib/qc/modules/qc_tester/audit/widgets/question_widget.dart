import 'dart:io';

import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/qc/modules/qc_tester/audit/widgets/upload_image_cards.dart';
import '../l10n.dart';
import '../providers/audit_questions_provider.dart';

class AuditQuestionWidget extends StatefulWidget {
  final int questionNumber;
  final Function(int, String) onOptionSelected;

  const AuditQuestionWidget({
    Key? key,
    required this.onOptionSelected,
    required this.questionNumber,
  }) : super(key: key);

  @override
  State<AuditQuestionWidget> createState() => _AuditQuestionWidgetState();
}

class _AuditQuestionWidgetState extends State<AuditQuestionWidget> {
  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var provider = AuditQuestionsProvider.of(context);
    var l10n = L10n(context);
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(vertical: Dimens.space_20, horizontal: Dimens.space_16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (!Validator.isNullOrEmpty(provider.auditData!.questionList![widget.questionNumber].question))
            Row(
              children: [
                const SizedBox(),
                Expanded(
                  child: Text(
                    "${l10n.q}. ${(widget.questionNumber + 1)}  ${provider.auditData!.questionList![widget.questionNumber].question!}",
                    style: theme.primaryTextTheme.displayMedium,
                  ),
                )
              ],
            ),
          const SizedBox(height: Dimens.space_8),
          if (provider.auditData!.questionList![widget.questionNumber].options != null &&
              !Validator.isListNullOrEmpty(
                  provider.auditData!.questionList![widget.questionNumber].options?.values.toList())) ...[
            RadioListWidget(
              list: List.generate(
                provider.auditData!.questionList![widget.questionNumber].options!.values.toList().length,
                (index) => RadioListItem(
                    index.toString(),
                    provider.auditData!.questionList![widget.questionNumber].options!.values.toList()[index],
                    provider.auditData!.questionList![widget.questionNumber].selectedOption ==
                        provider.auditData!.questionList![widget.questionNumber].options!.values.toList()[index]),
              ),
              onItemSelected: (data) {
                widget.onOptionSelected(
                    provider.auditData!.questionList![widget.questionNumber].questionId!, data.label!);
                provider.auditData!.questionList![widget.questionNumber].selectedOption = data.label;
                setState(() {});
              },
            ),
            const SizedBox(height: Dimens.space_30),
            if (provider.auditData!.questionList![widget.questionNumber].imageCount != null &&
                provider.auditData!.questionList![widget.questionNumber].imageCount! == 1)
              Align(
                alignment: Alignment.center,
                child: UploadMediaCards(
                  selectedFile: provider.auditData!.questionList![widget.questionNumber].selectedImageFile,
                  onCrossedButtonTapped: () {
                    provider.auditData!.questionList![widget.questionNumber].s3url = null;
                    provider.auditData!.questionList![widget.questionNumber].selectedImageFile = null;
                  },
                  setFileForPersistence: (File imageFile) {
                    provider.auditData!.questionList![widget.questionNumber].selectedImageFile = imageFile;
                  },
                  s3UploadedImageUrlCallback: (String url) {
                    provider.auditData!.questionList![widget.questionNumber].s3url = url;
                  },
                ),
              )
          ]
        ],
      ),
    );
  }
}
