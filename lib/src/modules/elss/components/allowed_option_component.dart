import 'package:builder_component/builder_component.dart';
import 'package:core_widgets/core_widgets.dart';
import 'package:csh_annotation/annotation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/src/app_builder/app_builder_groups/groups.dart';
import 'package:flutter_trc/src/app_builder/app_headers/general_app_header/models/none_config_model.dart';
import 'package:provider/provider.dart';

import '../common_models/allowed_option_comp_param.dart';
import '../elss_qc/providers/channel_option_provider.dart';
import '../elss_qc/widgets/channel_option_widget.dart';

part 'allowed_option_component.g.dart';

@CshComponent(
    key: AllowedOptionsComponent.COMP_KEY,
    configModel: NoneConfigModel,
    paramModel: AllowedOptionCompParam,
    params: AllowedOptionCompParamKeys.values,
    componentGroup: ComponentGroup.allowedOptionComponentKey)
class AllowedOptionsComponent extends StatelessComponent<NoneConfigModel> {
  static const String COMP_KEY = "TRC_allowed_option_comp";

  const AllowedOptionsComponent(super.jsonConfig, {super.key});

  @override
  Widget buildView(BuildContext context, configModel) {
    var theme = Theme.of(context);
    return paramBuilder((param) {
      return ChangeNotifierProvider<ChannelOptionProvider>(
        create: (_) => ChannelOptionProvider(param.arguments?.scannedBarcode ?? ""),
        lazy: false,
        builder: (BuildContext innerContext, __) {
          var provider = ChannelOptionProvider.of(innerContext);
          return (provider.isOptionDataLoading)
              ? const Center(
                  child: SizedBox(
                    height: Dimens.space_30,
                    width: Dimens.space_30,
                    child: CircularProgressIndicator(),
                  ),
                )
              : (provider.isOptionDataLoading == false && provider.channelOptionResponse == null)
                  ? Center(
                      child: Text(
                        (provider.errorOfChannel.isNotEmpty) ? provider.errorOfChannel : "No Data Found",
                        style: theme.primaryTextTheme.headline3,
                      ),
                    )
                  : ChannelOptionWidget(
                      param.arguments?.scannedBarcode ?? "",
                      detailsDataModel: param.arguments?.detailsDataModel,
                    );
          // return Scaffold(
          //   appBar: TrcHeader(
          //     l10n.channelOptions,
          //     showBackBtn: true,
          //   ),
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
