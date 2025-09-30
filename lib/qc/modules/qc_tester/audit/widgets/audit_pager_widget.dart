import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/qc/modules/qc_tester/audit/screens/audit_question_summary_screen.dart';
import 'package:flutter_trc/qc/modules/qc_tester/audit/widgets/question_widget.dart';

import '../l10n.dart';
import '../providers/audit_questions_provider.dart';

class AuditQuestionBuilder extends StatefulWidget {
  final String barcode;

  const AuditQuestionBuilder({
    Key? key,
    required this.barcode,
  }) : super(key: key);

  @override
  State<AuditQuestionBuilder> createState() => _AuditQuestionBuilderState();
}

class _AuditQuestionBuilderState extends State<AuditQuestionBuilder> {
  int _currentPage = 0;
  final PageController pagerController = PageController(initialPage: 0);
  final Map<int, List<String>> _pageSelectedSubVariations = {};
  final Map<int, Map<String, String?>> _pageSubVariationImages = {};

  @override
  Widget build(BuildContext context) {
    var provider = AuditQuestionsProvider.of(context);
    var l10n = L10n(context);
    var auditQuestionList = provider.auditData!.auditQuestionList;

    return WillPopScope(
      onWillPop: () {
        if (_currentPage > 0) {
          pagerController.previousPage(duration: const Duration(milliseconds: 200), curve: Curves.easeOut);
          return Future.value(false);
        } else {
          return Future.value(true);
        }
      },
      child: Column(
        children: [
          Expanded(
            child: PageView.builder(
              physics: const NeverScrollableScrollPhysics(),
              controller: pagerController,
              pageSnapping: true,
              itemBuilder: (context, index) {
                return AuditQuestionWidget(
                  key: ValueKey(_currentPage.toString()),
                  onOptionSelected: (int qId, String selectedOption) {
                    provider.onQuestionOptionSelected(qId, selectedOption);
                  },
                  onSubVariationsChanged: (selected) {
                    setState(() {
                      _pageSelectedSubVariations[index] = selected;
                    });
                  },
                  onSubVariationStateChanged: (selected, images) {
                    setState(() {
                      _pageSelectedSubVariations[index] = selected;
                      _pageSubVariationImages[index] = images;
                    });
                  },
                  questionNumber: index,
                );
              },
              itemCount: auditQuestionList!.length,
              onPageChanged: (pageNumber) {
                setState(() {
                  _currentPage = pageNumber;
                });
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: Dimens.space_8, horizontal: Dimens.space_16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CshMediumButton(
                  text: l10n.back,
                  onPressed: _currentPage == 0
                      ? null
                      : () {
                          pagerController.previousPage(
                              duration: const Duration(milliseconds: 200), curve: Curves.easeIn);
                        },
                ),
                CshMediumButton(
                  text: _currentPage == (auditQuestionList.length - 1) ? l10n.submit : l10n.next,
                  onPressed: (!Validator.isNullOrEmpty(auditQuestionList[_currentPage].selectedOption) &&
                          (!_requiresSubVariation(auditQuestionList[_currentPage]) ||
                              _isSubVariationImageSatisfied(_currentPage)))
                      ? () {
                          if (auditQuestionList[_currentPage].imageCount != null &&
                              auditQuestionList[_currentPage].imageCount == 1 &&
                              Validator.isNullOrEmpty(auditQuestionList[_currentPage].s3url)) {
                            CshSnackBar.error(context: context, message: l10n.pleaseUploadRequiredImage);
                            return;
                          }

                          if (_currentPage == (auditQuestionList.length - 1)) {
                            // print("Submit button pressed for barcode: ${widget.barcode}");
                            AuditQuestionSummaryArguments args = AuditQuestionSummaryArguments(
                                questionDataModel: provider.auditData, scannedBarcode: widget.barcode);
                            Navigator.of(context).pushNamed(AuditQuestionSummaryScreen.route, arguments: args);
                          } else {
                            pagerController.nextPage(duration: const Duration(milliseconds: 200), curve: Curves.easeIn);
                          }
                        }
                      : null,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  bool _requiresSubVariation(auditQuestionListItem) {
    try {
      final has = !(auditQuestionListItem?.subVariations?[auditQuestionListItem?.selectedOption] ?? const <String>[]).isEmpty;
      return has;
    } catch (_) {
      return false;
    }
  }

  bool _isSubVariationImageSatisfied(int pageIndex) {
    final selected = _pageSelectedSubVariations[pageIndex] ?? const <String>[];
    if (selected.isEmpty) return false;
    final images = _pageSubVariationImages[pageIndex] ?? const <String, String?>{};
    for (final label in selected) {
      final url = images[label];
      if (url == null || url.isEmpty) return false;
    }
    return true;
  }
}
