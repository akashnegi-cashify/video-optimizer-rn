import 'package:builder_component/builder_component.dart';
import 'package:core_widgets/core_widgets.dart';
import 'package:csh_annotation/annotation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/src/app_builder/app_headers/general_app_header/models/none_config_model.dart';
import 'package:provider/provider.dart';

import '../../../app_builder/app_builder_groups/groups.dart';
import '../common_models/add_part_comp_param.dart';
import '../elss_trc/providers/add_part_list_provider_trc.dart';
import '../elss_trc/widgets/add_part_list_widget_trc.dart';

part 'add_part_component.g.dart';

@CshComponent(
    key: AddPartComponent.COMP_KEY,
    configModel: NoneConfigModel,
    componentGroup: ComponentGroup.addPartComponentKey,
    params: AddPartCompParamKey.values,
    paramModel: AddPartCompParam)
class AddPartComponent extends StatelessComponent<NoneConfigModel> {
  static const String COMP_KEY = "TRC_add_part_comp";

  const AddPartComponent(super.jsonConfig, {super.key});

  @override
  Widget buildView(BuildContext context, configModel) {
    var theme = Theme.of(context);

    return paramBuilder((param) {
      return ChangeNotifierProvider<AddPartListProviderTrc>(
        create: (_) => AddPartListProviderTrc(param.scannedBarcode ?? "", param.selectedPartList),
        lazy: false,
        builder: (BuildContext innerContext, __) {
          var provider = AddPartListProviderTrc.of(innerContext);

          return (provider.isPartListLoading)
              ? const Center(
                  child: SizedBox(
                    height: Dimens.space_30,
                    width: Dimens.space_30,
                    child: CircularProgressIndicator(),
                  ),
                )
              : (provider.isPartListLoading == false && provider.partDeviceListResponse == null)
                  ? Center(
                      child: Text(
                        "No Data Found",
                        style: theme.primaryTextTheme.headline3,
                      ),
                    )
                  : const _AddPartList();

          //   Scaffold(
          //   appBar: TrcHeader(l10n.addPart),
          //   body:
          // );
        },
      );
    });
  }

  @override
  Function(Map<String, dynamic> data)? fromConfig() {
    return NoneConfigModel.fromConfig;
  }
}

class _AddPartList extends StatefulWidget {
  const _AddPartList({Key? key}) : super(key: key);

  @override
  State<_AddPartList> createState() => _AddPartListState();
}

class _AddPartListState extends State<_AddPartList> {
  @override
  Widget build(BuildContext context) {
    return const AddPartListWidgetTrc();
  }
}
