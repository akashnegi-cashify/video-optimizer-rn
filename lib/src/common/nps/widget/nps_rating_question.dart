import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/src/common/nps/resources/nps_question_response.dart';

class NpsRatingQuestion extends StatefulWidget {
  final NpsQuestionData npsQuestionData;
  final EdgeInsets contentPadding;
  final Function(NpsQuestionData selectedRating) onValueSelected;

  const NpsRatingQuestion(
    this.npsQuestionData, {
    required this.onValueSelected,
    this.contentPadding = EdgeInsets.zero,
    super.key,
  });

  @override
  State<NpsRatingQuestion> createState() => _NpsRatingQuestionState();
}

class _NpsRatingQuestionState extends State<NpsRatingQuestion> {
  NpsQuestionData? _selectedRating;

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Padding(
      padding: widget.contentPadding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CshTextNew.subTitle1(widget.npsQuestionData.statement ?? ""),
          SizedBox(height: Dimens.space_16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: List.generate(
              6,
              (index) {
                var item = widget.npsQuestionData.questionOptions![index];
                bool isSelected = _selectedRating?.id == item.id;
                return Flexible(
                  flex: 1,
                  fit: FlexFit.tight,
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedRating = item;
                      });
                      widget.onValueSelected(item);
                    },
                    child: Container(
                      padding: EdgeInsets.all(Dimens.space_12),
                      width: Dimens.space_50,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: isSelected ? theme.primaryColor : theme.dividerColor,
                        border: Border.all(color: isSelected ? theme.primaryColor : Colors.grey.shade300),
                        shape: BoxShape.circle,
                      ),
                      child: Text("${index + 1}",
                          style: theme.primaryTextTheme.titleSmall?.copyWith(color: isSelected ? Colors.white : null)),
                    ),
                  ),
                );
              },
            ),
          ),
          SizedBox(height: Dimens.space_12),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: List.generate(
              4,
              (index) {
                index = index + 6;
                var item = widget.npsQuestionData.questionOptions![index];
                bool isSelected = _selectedRating?.id == item.id;
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedRating = item;
                    });
                    widget.onValueSelected(item);
                  },
                  child: Container(
                    padding: EdgeInsets.all(Dimens.space_12),
                    margin: EdgeInsets.symmetric(horizontal: Dimens.space_4),
                    width: Dimens.space_54,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: isSelected ? theme.primaryColor : theme.dividerColor,
                      border: Border.all(color: isSelected ? theme.primaryColor : Colors.grey.shade300),
                      shape: BoxShape.circle,
                    ),
                    child: Text("${index + 1}",
                        style: theme.primaryTextTheme.titleSmall?.copyWith(color: isSelected ? Colors.white : null)),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
