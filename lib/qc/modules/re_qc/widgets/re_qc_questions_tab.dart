import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/qc/modules/re_qc/providers/re_qc_question_tab_provider.dart';
import 'package:image_picker/image_picker.dart';

class ReQcQuestionsTab extends StatefulWidget {
  final Function(bool isMismatchMarked) onReQcSubmitted;

  const ReQcQuestionsTab({super.key, required this.onReQcSubmitted});

  @override
  State<ReQcQuestionsTab> createState() => _ReQcQuestionsTabState();
}

class _ReQcQuestionsTabState extends State<ReQcQuestionsTab> {
  int _currentPage = 0;
  final PageController pagerController = PageController(initialPage: 0, keepPage: true);

  @override
  Widget build(BuildContext context) {
    var provider = ReQcQuestionsProvider.of(context);

    return Container(
      padding: const EdgeInsets.all(Dimens.space_16),
      child: Column(
        children: [
          const SizedBox(height: Dimens.space_8),
          CshTextNew.h3("Tick the corresponding option to mark mismatch"),
          const SizedBox(height: Dimens.space_16),
          Expanded(
            child: PageView.builder(
              physics: const NeverScrollableScrollPhysics(),
              controller: pagerController,
              onPageChanged: (index) {
                setState(() {
                  _currentPage = index;
                });
              },
              itemBuilder: (_, index) {
                return _QuestionWidget(index: index, key: UniqueKey());
              },
              itemCount: provider.questionLength,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: CshBigButton(
                  text: "Previous",
                  onPressed: _currentPage > 0 ? () => _animateToPage(_currentPage - 1) : null,
                ),
              ),
              const SizedBox(width: Dimens.space_16),
              Expanded(
                child: CshBigButton(
                  text: _currentPage == (provider.questionLength - 1) ? "Done" : "Next",
                  onPressed: () async {
                    _onMoveToNextPage(provider, isLastPage: _currentPage == (provider.questionLength - 1));
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  _onMoveToNextPage(ReQcQuestionsProvider provider, {bool isLastPage = false}) async {
    if (provider.isImageRequired(_currentPage)) {
      var xFile = await ImagePicker().pickImage(
        source: ImageSource.camera,
        requestFullMetadata: false,
      );
      if (xFile != null) {
        CshLoading().showLoading(context);
        provider.uploadImage(xFile.path).then((value) {
          CshLoading().hideLoading(context);
          provider.setImageUrl(_currentPage, value);
          if (isLastPage) {
            _submitReQc(provider);
          } else {
            _animateToPage(_currentPage + 1);
          }
        }, onError: (error) {
          CshLoading().hideLoading(context);
          CshSnackBar.error(context: context, message: error);
        });
      }
    } else {
      if (isLastPage) {
        _submitReQc(provider);
      } else {
        _animateToPage(_currentPage + 1);
      }
    }
  }

  void _animateToPage(int index) {
    pagerController.animateToPage(index, duration: const Duration(milliseconds: 200), curve: Curves.easeIn);
  }

  void _submitReQc(ReQcQuestionsProvider provider) {
    _showRemarksDialog((String? remarks) {
      Navigator.pop(context); // dismiss dialog
      CshLoading().showLoading(context);
      provider.submitReQcData(remarks).then((value) {
        CshLoading().hideLoading(context);
        CshSnackBar.success(context: context, message: "ReQC submitted successfully");
        widget.onReQcSubmitted(provider.isMismatchMarked());
      }, onError: (error) {
        CshLoading().hideLoading(context);
        CshSnackBar.error(context: context, message: error);
      });
    });
  }

  void _showRemarksDialog(Function(String? remarks) onProceed) {
    String? remarks;
    showCshBottomSheet(
      isDismissible: false,
      context: context,
      child: Builder(builder: (innerContext) {
        return Container(
          padding: EdgeInsets.only(bottom: MediaQuery.of(innerContext).viewInsets.bottom),
          child: Padding(
            padding: const EdgeInsets.all(Dimens.space_20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CshTextNew.subTitle1("Enter Remarks (Optional)"),
                const SizedBox(height: Dimens.space_16),
                CshTextFormField(
                  hintText: "Enter Remarks",
                  maxLines: 2,
                  onChanged: (value) {
                    remarks = value;
                  },
                ),
                const SizedBox(height: Dimens.space_16),
                ComboButton(
                    firstBtnText: "Skip",
                    secondBtnText: "Submit",
                    firstBtnClick: () {
                      onProceed(remarks);
                    },
                    secondBtnClick: () {
                      onProceed(remarks);
                    }),
              ],
            ),
          ),
        );
      }),
    );
  }
}

class _QuestionWidget extends StatefulWidget {
  final int index;

  const _QuestionWidget({super.key, required this.index});

  @override
  State<_QuestionWidget> createState() => _QuestionWidgetState();
}

class _QuestionWidgetState extends State<_QuestionWidget> {
  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var provider = ReQcQuestionsProvider.of(context);
    var item = provider.deviceReportList![widget.index];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "${widget.index + 1})  ${item.label}",
          style: theme.textTheme.titleMedium?.copyWith(color: theme.primaryColor),
        ),
        const SizedBox(height: Dimens.space_16),
        RadioListWidget(
          list: List.generate(
            item.variation?.length ?? 0,
            (index) {
              String variantId = item.getVariantKey(index);
              return RadioListItem(
                item.getVariantKey(index),
                item.getVariantValue(variantId),
                item.isSelected(variantId),
              );
            },
          ),
          isShowedInCard: true,
          onItemSelected: (data) {
            provider.setUserSelectedVariantId(widget.index, data.id!);
          },
        ),
      ],
    );
  }
}
