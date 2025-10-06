import 'dart:convert';

import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/src/utils/media_upload/widgets/image_upload_widget.dart';

import '../l10n.dart';
import '../providers/audit_questions_provider.dart';

class AuditQuestionWidget extends StatefulWidget {
  final int questionNumber;
  final Function(int, String) onOptionSelected;
  final void Function(List<String> selected)? onSubVariationsChanged;
  final void Function(List<String> selected, Map<String, String?> images)? onSubVariationStateChanged;

  const AuditQuestionWidget({
    super.key,
    required this.onOptionSelected,
    required this.questionNumber,
    this.onSubVariationsChanged,
    this.onSubVariationStateChanged,
  });

  @override
  State<AuditQuestionWidget> createState() => _AuditQuestionWidgetState();
}

class _AuditQuestionWidgetState extends State<AuditQuestionWidget> {
  final Set<String> _selectedSubVariations = {};
  final Map<String, String> _subVariationRemarks = {};
  final Map<String, String?> _subVariationImageUrls = {};
  bool _hydrated = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final provider = AuditQuestionsProvider.of(context, listen: false);
      final auditQuestionList = provider.auditData?.auditQuestionList;
      if (auditQuestionList != null && widget.questionNumber < auditQuestionList.length) {
        final auditQuestionData = auditQuestionList[widget.questionNumber];
        _hydrateFromModel(auditQuestionData);
      }
    });
  }

  void _hydrateFromModel(auditQuestionData) {
    if (_hydrated) return;
    final savedSelected = auditQuestionData.selectedSubVariations ?? const <String>[];
    final savedImages = auditQuestionData.selectedSubVariationImageUrls ?? const <String, String?>{};
    if (savedSelected.isNotEmpty || savedImages.isNotEmpty) {
      _selectedSubVariations
        ..clear()
        ..addAll(savedSelected);
      _subVariationImageUrls
        ..clear()
        ..addAll(savedImages);
      widget.onSubVariationsChanged?.call(savedSelected);
      widget.onSubVariationStateChanged?.call(savedSelected, Map<String, String?>.from(savedImages));
      setState(() {});
    }
    _hydrated = true;
  }
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
                auditQuestionData.options!.entries.length,
                (index) {
                  final e = auditQuestionData.options!.entries.toList()[index];
                  return RadioListItem(
                    e.key,
                    e.value,
                    auditQuestionData.selectedOption == e.key,
                  );
                },
              ),
              onItemSelected: (data) {
                widget.onOptionSelected(auditQuestionData.questionId!, data.id!);
                auditQuestionData.selectedOption = data.id;
                _selectedSubVariations.clear();
                _subVariationRemarks.clear();
                _subVariationImageUrls.clear();
                auditQuestionData.selectedSubVariations = [];
                auditQuestionData.selectedSubVariationImageUrls = {};
                widget.onSubVariationsChanged?.call(const []);
                widget.onSubVariationStateChanged?.call(const [], const {});
                setState(() {});
              },
            ),
            
            
            const SizedBox(height: Dimens.space_30),
            if (auditQuestionData.imageCount != null && auditQuestionData.imageCount! == 1)
              Align(
                alignment: Alignment.center,
                child: ImageUploadOptimizerCard(
                  initialUrl: auditQuestionData.s3url,
                  onMediaUploaded: (String? url) {
                    auditQuestionData.s3url = url;
                  },
                ),
              ),
          ],

          if (!Validator.isNullOrEmpty(auditQuestionData.selectedOption)) ...[
              Builder(
                builder: (_) {
                  final List<String> svList =
                      (auditQuestionData.subVariations?[auditQuestionData.selectedOption!] ?? []).cast<String>();
                  if (Validator.isListNullOrEmpty(svList)) {
                    return const SizedBox.shrink();
                  }
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: Dimens.space_12),
                      Text(
                        "Select Sub Variation",
                        style: theme.primaryTextTheme.titleSmall,
                      ),
                      const SizedBox(height: Dimens.space_8),
                      // 1) Render all checkboxes first
                      ...svList.map((label) => CheckboxListTile(
                            contentPadding: EdgeInsets.zero,
                            dense: true,
                            controlAffinity: ListTileControlAffinity.leading,
                            title: Text(label, style: theme.primaryTextTheme.bodyMedium),
                            value: _selectedSubVariations.contains(label),
                            onChanged: (checked) {
                              setState(() {
                                if (checked == true) {
                                  _selectedSubVariations.add(label);
                                  _subVariationRemarks.putIfAbsent(label, () => "");
                                  _subVariationImageUrls.putIfAbsent(label, () => null);
                                } else {
                                  _selectedSubVariations.remove(label);
                                  _subVariationRemarks.remove(label);
                                  _subVariationImageUrls.remove(label);
                                }
                                auditQuestionData.selectedSubVariations = _selectedSubVariations.toList();
                                auditQuestionData.selectedSubVariationImageUrls = Map<String, String?>.from(_subVariationImageUrls);
                                widget.onSubVariationsChanged?.call(auditQuestionData.selectedSubVariations!);
                                widget.onSubVariationStateChanged?.call(
                                  auditQuestionData.selectedSubVariations!,
                                  Map<String, String?>.from(_subVariationImageUrls),
                                );
                              });
                            },
                          )),
                      const SizedBox(height: Dimens.space_12),
                      // 2) Then render the containers for selected items
                      ...svList
                          .where((label) => _selectedSubVariations.contains(label))
                          .map((label) => Container(
                                width: double.infinity,
                                padding: const EdgeInsets.all(Dimens.space_12),
                                margin: const EdgeInsets.only(bottom: Dimens.space_12),
                                decoration: BoxDecoration(
                                  color: Theme.of(context).cardColor,
                                  borderRadius: BorderRadius.circular(Dimens.space_8),
                                  border: Border.all(color: Theme.of(context).dividerColor),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Text("$label - Image", style: theme.primaryTextTheme.titleSmall),
                                        const SizedBox(width: 4),
                                        Text("*",
                                            style: theme.primaryTextTheme.titleSmall
                                                ?.copyWith(color: theme.colorScheme.error)),
                                      ],
                                    ),
                                    const SizedBox(height: Dimens.space_8),
                                    Align(
                                      alignment: Alignment.center,
                                      child: ImageUploadOptimizerCard(
                                        initialUrl: auditQuestionData.selectedSubVariationImageUrls?[label],
                                        onMediaUploaded: (String? url) {
                                          setState(() {
                                            _subVariationImageUrls[label] = url;
                                            auditQuestionData.selectedSubVariationImageUrls = Map<String, String?>.from(_subVariationImageUrls);
                                            widget.onSubVariationStateChanged?.call(
                                              _selectedSubVariations.toList(),
                                              Map<String, String?>.from(_subVariationImageUrls),
                                            );
                                          });
                                        },
                                      ),
                                    ),
                                    // const SizedBox(height: Dimens.space_12),
                                    // Text("$label - Remarks", style: theme.primaryTextTheme.titleSmall),
                                    // const SizedBox(height: Dimens.space_8),
                                    // TextFormField(
                                    //   initialValue: _subVariationRemarks[label] ?? "",
                                    //   maxLines: 3,
                                    //   decoration: const InputDecoration(
                                    //       hintText: "Enter remarks",
                                    //     border: OutlineInputBorder(),
                                    //   ),
                                    //   onChanged: (value) {
                                    //     _subVariationRemarks[label] = value;
                                    //   },
                                    // ),
                                  ],
                                ),
                              )),
                      const SizedBox(height: Dimens.space_20),
                    ],
                  );
                },
              ),
            ],
        ],
      ),
    );
  }
}
