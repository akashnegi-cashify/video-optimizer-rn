import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/src/common/nps/resources/nps_question_response.dart';

class NpsTestQuestion extends StatefulWidget {
  final NpsQuestionData? questionData;
  final EdgeInsets contentPadding;
  final Function(String value) onValueChanged;

  const NpsTestQuestion(this.questionData,
      {super.key, this.contentPadding = EdgeInsets.zero, required this.onValueChanged});

  @override
  State<NpsTestQuestion> createState() => _NpsTestQuestionState();
}

class _NpsTestQuestionState extends State<NpsTestQuestion> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: widget.contentPadding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          CshTextNew.subTitle1(widget.questionData?.statement ?? ""),
          SizedBox(height: Dimens.space_16),
          CshTextFormField(
            hintText: 'Enter your answer here',
            contentPadding: EdgeInsets.all(Dimens.space_12),
            minLines: 3,
            maxLines: 4,
            onChanged: (value) {
              widget.onValueChanged(value);
            },
          ),
        ],
      ),
    );
  }
}
