import 'package:builder_component/builder_component.dart';
import 'package:core_widgets/core_widgets.dart';
import 'package:csh_annotation/annotation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/src/app_builder/app_builder_groups/groups.dart';
import 'package:flutter_trc/src/app_builder/app_headers/general_app_header/models/none_config_model.dart';
import 'package:provider/provider.dart';

import '../l10n.dart';
import '../models/return_item_status_comp_param.dart';
import '../providers/return_item_status_provider.dart';
import '../widgets/return_list_item_widget.dart';

part 'return_item_status_component.g.dart';

@CshComponent(
    key: ReturnItemStatusComponent.COMP_KEY,
    configModel: NoneConfigModel,
    paramModel: ReturnItemStatusCompParam,
    params: ReturnItemStatusCompParamKeys.values,
    componentGroup: ComponentGroup.returnItemStatusComponentKey)
class ReturnItemStatusComponent extends StatelessComponent<NoneConfigModel> {
  static const String COMP_KEY = "TRC_return_item_status_comp";

  const ReturnItemStatusComponent(super.jsonConfig, {super.key});

  @override
  Widget buildView(BuildContext context, configModel) {
    var l10n = L10n(context);
    var theme = Theme.of(context);
    return paramBuilder((param) {
      return ChangeNotifierProvider<ReturnItemStatusProvider>(
        create: (_) => ReturnItemStatusProvider(param.detailsModel?.prid),
        lazy: false,
        builder: (BuildContext innerContext, __) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: Dimens.space_16, vertical: Dimens.space_12),
            child: Column(
              children: [
                ReturnListItemWidget(dataModel: param.detailsModel),
                const Expanded(
                  child: SizedBox.shrink(),
                ),
                Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          _changeReturnItemStatus(innerContext, true, l10n);
                        },
                        child: Container(
                          height: Dimens.space_40,
                          color: theme.errorColor,
                          alignment: Alignment.center,
                          child: Text(
                            l10n.faultySpare,
                            style: theme.primaryTextTheme.headline6?.copyWith(color: theme.cardColor),
                            textAlign: TextAlign.center,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: Dimens.space_16),
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          _changeReturnItemStatus(innerContext, false, l10n);
                        },
                        child: Container(
                          height: Dimens.space_40,
                          color: theme.primaryColor,
                          alignment: Alignment.center,
                          child: Text(
                            l10n.sendPartBackToInventory,
                            style: theme.primaryTextTheme.headline6?.copyWith(color: theme.cardColor),
                            textAlign: TextAlign.center,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
          );
        },
      );
    });
  }

  _changeReturnItemStatus(BuildContext context, bool isFaulty, L10n l10n) {
    var provider = ReturnItemStatusProvider.of(context, listen: false);
    CshLoading().showLoading(context);
    provider.updateReturnPartItemStatus(isFaulty).then((value) {
      CshLoading().hideLoading(context);
      if (value) {
        CshSnackBar.success(context: context, message: l10n.statusChangedSuccessfully);
        Navigator.of(context).pop();
      }
    }, onError: (error) {
      CshLoading().hideLoading(context);
      CshSnackBar.error(context: context, message: error);
    });
  }

  @override
  Function(Map<String, dynamic> data)? fromConfig() {
    return NoneConfigModel.fromConfig;
  }
}
