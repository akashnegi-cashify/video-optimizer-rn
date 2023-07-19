import 'package:builder_component/builder_component.dart';
import 'package:core_widgets/core_widgets.dart';
import 'package:csh_annotation/annotation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/qc/resources/qc_common_config.dart';
import 'package:flutter_trc/src/app_builder/app_builder_groups/groups.dart';
import 'package:provider/provider.dart';

import '../l10n.dart';
import '../models/disputed_question_comp_param.dart';
import '../providers/disputed_question_provider.dart';

part 'disputed_question_component.g.dart';

@CshComponent(
    key: DisputedQuestionsComponent.COMP_KEY,
    componentGroup: ComponentGroup.disputedQuestionsComponentKey,
    configModel: QcCommonConfigModel,
    paramModel: DisputedQuestionParam,
    params: DisputedQuestionParamKeys.values)
class DisputedQuestionsComponent extends StatelessComponent<QcCommonConfigModel> {
  static const String COMP_KEY = "disputed_questions";

  const DisputedQuestionsComponent(super.jsonConfig, {super.key});

  @override
  Widget buildView(BuildContext context, QcCommonConfigModel? configModel) {
    var l10n = L10n(context);
    return paramBuilder((param) {
      return ChangeNotifierProvider(
        create: (_) => DisputedQuestionProvider(param.disputedQuestionList),
        builder: (builderContext, _) {
          var provider = DisputedQuestionProvider.of(builderContext);
          return Padding(
            padding: const EdgeInsets.all(Dimens.space_16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CshTextNew.h4(l10n.pleaseSelectTheIssuesInTheDevice),
                const SizedBox(height: Dimens.space_16),
                Expanded(
                  child: CshCard(
                      padding: EdgeInsets.zero,
                      child: ListView.separated(
                          itemBuilder: (_, index) {
                            var item = provider.disputedQuestionList![index];
                            return CheckboxListTile(
                              value: item.isSelected ?? false,
                              controlAffinity: ListTileControlAffinity.leading,
                              onChanged: (value) {
                                provider.updateQuestionList(index, value);
                              },
                              title: Text(
                                item.question ?? "",
                                maxLines: 2,
                                style: Theme.of(context).textTheme.headlineMedium,
                              ),
                            );
                          },
                          separatorBuilder: (_, index) {
                            return const SizedBox(height: Dimens.space_4);
                          },
                          itemCount: provider.disputedQuestionList?.length ?? 0)),
                ),
                const SizedBox(height: Dimens.space_16),
                SizedBox(
                  width: double.infinity,
                  child: CshBigButton(
                    text: l10n.submit,
                    onPressed: () {
                      Navigator.pop(context, provider.getSelectedQuestionList());
                    },
                  ),
                )
              ],
            ),
          );
        },
      );
    });
  }

  @override
  Function(Map<String, dynamic> data)? fromConfig() {
    return QcCommonConfigModel.fromConfig;
  }
}
