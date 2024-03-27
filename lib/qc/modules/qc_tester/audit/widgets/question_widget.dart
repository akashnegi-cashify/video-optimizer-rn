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
    var auditQuestionList = provider.auditData!.auditQuestionList;
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(vertical: Dimens.space_20, horizontal: Dimens.space_16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (!Validator.isNullOrEmpty(auditQuestionList![widget.questionNumber].question))
            Row(
              children: [
                const SizedBox(),
                Expanded(
                  child: Text(
                    "${l10n.q}. ${(widget.questionNumber + 1)}  ${auditQuestionList[widget.questionNumber].question!}",
                    style: theme.primaryTextTheme.displayMedium,
                  ),
                )
              ],
            ),
          const SizedBox(height: Dimens.space_8),
          if (auditQuestionList[widget.questionNumber].options != null &&
              !Validator.isListNullOrEmpty(
                  auditQuestionList[widget.questionNumber].options?.values.toList())) ...[
            RadioListWidget(
              list: List.generate(
                auditQuestionList[widget.questionNumber].options!.values.toList().length,
                (index) => RadioListItem(
                    index.toString(),
                    auditQuestionList[widget.questionNumber].options!.values.toList()[index],
                    auditQuestionList[widget.questionNumber].selectedOption ==
                        auditQuestionList[widget.questionNumber].options!.values.toList()[index]),
              ),
              onItemSelected: (data) {
                widget.onOptionSelected(
                    auditQuestionList[widget.questionNumber].questionId!, data.label!);
                auditQuestionList[widget.questionNumber].selectedOption = data.label;
                setState(() {});
              },
            ),
            const SizedBox(height: Dimens.space_30),
            if (auditQuestionList[widget.questionNumber].imageCount != null &&
                auditQuestionList[widget.questionNumber].imageCount! == 1)
              Align(
                alignment: Alignment.center,
                child: UploadMediaCards(
                  selectedFile: auditQuestionList[widget.questionNumber].selectedImageFile,
                  onCrossedButtonTapped: () {
                    auditQuestionList[widget.questionNumber].s3url = null;
                    auditQuestionList[widget.questionNumber].selectedImageFile = null;
                  },
                  setFileForPersistence: (File imageFile) {
                    auditQuestionList[widget.questionNumber].selectedImageFile = imageFile;
                  },
                  s3UploadedImageUrlCallback: (String url) {
                    auditQuestionList[widget.questionNumber].s3url = url;
                  },
                ),
              )
          ]
        ],
      ),
    );
  }
}
