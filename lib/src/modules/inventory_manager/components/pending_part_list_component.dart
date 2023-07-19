import 'package:builder_component/builder_component.dart';
import 'package:core_widgets/core_widgets.dart';
import 'package:csh_annotation/annotation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../app_builder/app_builder_groups/groups.dart';
import '../models/pending_device_list_response.dart';
import '../models/pending_part_list_comp.config.dart';
import '../models/pending_part_list_comp_param.dart';
import '../providers/pending_part_list_provider.dart';
import '../widgets/pending_delivery_item_widget.dart';
import '../widgets/pending_part_list_item_widget.dart';

part 'pending_part_list_component.g.dart';

@CshComponent(
    key: PendingPartListComponent.COMP_KEY,
    configModel: PendingPartListCompConfig,
    params: PendingPartListCompParamKeys.values,
    paramModel: PendingPartListCompParam,
    componentGroup: ComponentGroup.pendingPartListComponentKey)
class PendingPartListComponent extends StatelessComponent<PendingPartListCompConfig> {
  static const String COMP_KEY = "TRC_pending_part_list";

  const PendingPartListComponent(super.jsonConfig, {super.key});

  @override
  Widget buildView(BuildContext context, configModel) {
    var theme = Theme.of(context);
    return paramBuilder(
      (param) {
        return ChangeNotifierProvider<PendingPartListProvider>(
          create: (_) => PendingPartListProvider(param.arguments?.did ?? 0),
          lazy: false,
          builder: (BuildContext insideContext, __) {
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(Dimens.space_8, Dimens.space_8, Dimens.space_8, 0),
                  child: PendingDeliveryListItemWidget(
                    index: 0,
                    dataModel: param.arguments?.detailsModelData,
                    showIndexingNumber: false,
                  ),
                ),
                const SizedBox(height: Dimens.space_16),
                Expanded(
                  child: _getWidget(insideContext, theme, param.arguments?.detailsModelData),
                )
              ],
            );
          },
        );
      },
    );
  }

  Widget _getWidget(BuildContext context, ThemeData theme, PendingDeviceDetailData? detailsModelData) {
    var provider = PendingPartListProvider.of(context);
    if (provider.isDataLoading) {
      return const Center(
        child: SizedBox(
          height: Dimens.space_30,
          width: Dimens.space_30,
          child: CircularProgressIndicator(),
        ),
      );
    } else if (provider.isDataLoading && !Validator.isNullOrEmpty(provider.errorMessage)) {
      return Center(
        child: Row(
          children: [
            const SizedBox.shrink(),
            Expanded(
              child: Text(
                provider.errorMessage,
                style: theme.primaryTextTheme.headline3,
              ),
            )
          ],
        ),
      );
    } else {
      if (!Validator.isListNullOrEmpty(provider.pendingPartListResponse?.partDataList)) {
        return ListView.separated(
            padding: const EdgeInsets.symmetric(vertical: Dimens.space_16, horizontal: Dimens.space_8),
            itemBuilder: (context, index) {
              return PendingPartListItemWidget(
                dataModel: provider.pendingPartListResponse!.partDataList![index],
                detailsModelData: detailsModelData,
              );
            },
            separatorBuilder: (context, index) {
              return const SizedBox(height: Dimens.space_8);
            },
            itemCount: provider.pendingPartListResponse!.partDataList!.length);
      } else {
        return const SizedBox();
      }
    }
  }

  @override
  Function(Map<String, dynamic> data)? fromConfig() {
    return PendingPartListCompConfig.fromConfig;
  }
}
