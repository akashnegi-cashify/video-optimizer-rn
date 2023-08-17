import 'package:builder_component/builder_component.dart';
import 'package:core_widgets/core_widgets.dart';
import 'package:csh_annotation/annotation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../app_builder/app_builder_groups/groups.dart';
import '../l10n.dart';
import '../models/pq_status_change_comp_config.dart';
import '../models/pq_status_change_comp_param.dart';
import '../providers/part_status_provider.dart';
import '../widgets/qc_part_list_widget.dart';

part 'pq_status_change_comp.g.dart';

@CshComponent(
    key: PqStatusChangeComp.COMP_KEY,
    configModel: PqStatusChangeCompConfig,
    paramModel: PqStatusChangeCompParam,
    componentGroup: ComponentGroup.pqStatusChangeComponentKey,
    params: PqStatusChangeCompParamKeys.values)
class PqStatusChangeComp extends StatelessComponent<PqStatusChangeCompConfig> {
  static const String COMP_KEY = "TRC_pq_status_change";

  const PqStatusChangeComp(super.jsonConfig, {super.key});

  @override
  Widget buildView(BuildContext context, configModel) {
    var l10n = L10n(context);
    var theme = Theme.of(context);
    return paramBuilder(
      (param) {
        return ChangeNotifierProvider<PartStatusProvider>(
          create: (_) => PartStatusProvider(param.partDetails!.prid!),
          lazy: false,
          builder: (BuildContext innerContext, __) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: Dimens.space_12, horizontal: Dimens.space_8),
              child: Column(
                children: [
                  QcPartListItemWidget(dataModel: param.partDetails),
                  const Expanded(child: SizedBox.shrink()),
                  ComboButton(
                    firstBtnText: l10n.faultySpare.toUpperCase(),
                    secondBtnText: l10n.spareOk.toUpperCase(),
                    buttonType: ButtonType.mini,
                    isFirstPrimary: true,
                    firstBtnClick: () {
                      _showUnlinkModal(innerContext, theme, l10n, true);
                    },
                    secondBtnClick: () {
                      _showUnlinkModal(innerContext, theme, l10n, false);
                    },
                  )
                ],
              ),
            );
          },
        );
      },
    );
  }

  _showUnlinkModal(BuildContext context, ThemeData theme, L10n l10n, bool isFaulty) {
    showCshBottomSheet(
      context: context,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: Dimens.space_12, horizontal: Dimens.space_16),
        child: Column(
          children: [
            Text(
              isFaulty ? l10n.areYouSureYouWantToMarkPartAsFaulty : l10n.areYouSureYouWantToMarkPartAsOk,
              style: theme.primaryTextTheme.headline3,
            ),
            const SizedBox(height: Dimens.space_16),
            ComboButton(
              firstBtnText: l10n.no,
              secondBtnText: l10n.yes,
              buttonType: ButtonType.mini,
              isFirstPrimary: true,
              firstBtnClick: () {
                Navigator.of(context).pop();
              },
              secondBtnClick: () {
                Navigator.of(context).pop();
                _updatePartStatus(context, isFaulty, l10n);
              },
            )
          ],
        ),
      ),
    );
  }

  _updatePartStatus(BuildContext context, bool isFaulty, L10n l10n) {
    var provider = PartStatusProvider.of(context, listen: false);

    CshLoading().showLoading(context);

    provider.updatePartStatus(isFaulty).then((value) {
      CshLoading().hideLoading(context);
      if (value) {
        CshSnackBar.success(context: context, message: l10n.statusUpdatedSuccessfully);
        Navigator.of(context).pop();
      }
    }, onError: (error) {
      CshLoading().hideLoading(context);
      CshSnackBar.error(context: context, message: error);
    });
  }

  @override
  Function(Map<String, dynamic> data)? fromConfig() {
    return PqStatusChangeCompConfig.fromConfig;
  }
}
