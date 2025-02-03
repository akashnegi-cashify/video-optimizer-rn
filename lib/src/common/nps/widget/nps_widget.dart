import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/src/common/nps/provider/nps_provider.dart';
import 'package:flutter_trc/src/common/nps/resources/nps_question_response.dart';
import 'package:flutter_trc/src/common/nps/widget/nps_rating_question.dart';
import 'package:flutter_trc/src/common/nps/widget/nps_test_question.dart';
import 'package:provider/provider.dart';

class NpsWidget extends StatelessWidget {
  final NpsResponseData _questionResponseData;

  const NpsWidget(this._questionResponseData, {super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => NpsProvider(
        _questionResponseData.transactionId,
        _questionResponseData.pageNo,
        _questionResponseData.questionList?.length,
      ),
      child: _NpsQuestionList(_questionResponseData.questionList),
    );
  }
}

class _NpsQuestionList extends StatelessWidget {
  final List<NpsQuestionData>? npsQuestionList;

  const _NpsQuestionList(this.npsQuestionList, {super.key});

  @override
  Widget build(BuildContext context) {
    final provider = NpsProvider.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        ...List.generate(
          npsQuestionList?.length ?? 0,
          (index) {
            return _getQuestionWidget(npsQuestionList![index], context);
          },
        ),
        SizedBox(height: Dimens.space_16),
        Padding(
          padding: const EdgeInsets.all(Dimens.space_16),
          child: ComboButton(
            firstBtnText: "Cancel",
            secondBtnText: "Submit",
            firstBtnClick: () {
              Navigator.of(context).pop();
            },
            secondBtnClick: () {
              CshLoading().showLoading(context);
              provider.onSubmit().then((value) {
                CshLoading().hideLoading(context);
                Navigator.of(context).pop();
              }, onError: (error) {
                CshLoading().hideLoading(context);
                CshSnackBar.error(context: context, message: error, snackBarPosition: SnackBarPosition.TOP);
              });
            },
          ),
        ),
      ],
    );
  }

  Widget _getQuestionWidget(NpsQuestionData npsQuestionData, BuildContext context) {
    var provider = NpsProvider.of(context, listen: false);
    switch (npsQuestionData.questionTypeKey) {
      case 'RATING':
        return NpsRatingQuestion(
          npsQuestionData,
          contentPadding: EdgeInsets.all(Dimens.space_16),
          onValueSelected: (selectedRating) {
            provider.setNpsRating(selectedRating);
          },
        );
      case 'TEXT':
        return NpsTestQuestion(
          npsQuestionData,
          contentPadding: EdgeInsets.all(Dimens.space_16),
          onValueChanged: (String value) {
            provider.setNpsText(npsQuestionData.questionId!, value);
          },
        );

      default:
        return SizedBox.shrink();
    }
  }
}
