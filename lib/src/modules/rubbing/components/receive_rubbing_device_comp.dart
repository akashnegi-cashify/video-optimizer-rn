import 'package:builder_component/builder_component.dart';
import 'package:core_widgets/core_widgets.dart';
import 'package:csh_annotation/annotation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/src/app_builder/app_builder_groups/groups.dart';
import 'package:provider/provider.dart';

import '../../../common/widgets/searchbar_widget.dart';
import '../l10n.dart';
import '../model/receive_rubbing_device_comp_config.dart';
import '../model/received_rubbing_device_comp_param.dart';
import '../providers/received_devices_provider.dart';
import '../widgets/received_devices_list_widget.dart';

part 'receive_rubbing_device_comp.g.dart';

@CshComponent(
    key: ReceiveRubbingDeviceComp.COMP_KEY,
    configModel: ReceiveRubbingDeviceCompConfig,
    componentGroup: ComponentGroup.receiveRubbingDeviceComponentKey,
    params: ReceivedRubbingDeviceCompParamKeys.values,
    paramModel: ReceivedRubbingDeviceCompParam)
class ReceiveRubbingDeviceComp extends StatelessComponent<ReceiveRubbingDeviceCompConfig> {
  static const String COMP_KEY = "TRC_receive_rubbing_device_comp";

  const ReceiveRubbingDeviceComp(super.jsonConfig, {super.key});

  @override
  Widget buildView(BuildContext context, configModel) {
    var l10n = L10n(context);
    return paramBuilder(
      (param) {
        return ChangeNotifierProvider<ReceivedDevicesProvider>(
          create: (context) => ReceivedDevicesProvider(query: param.searchQuery),
          builder: (context, widget) {
            ReceivedDevicesProvider provider = Provider.of<ReceivedDevicesProvider>(context);

            return Column(
              children: [
                Container(
                  margin: const EdgeInsets.all(Dimens.space_16),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(Dimens.space_4),
                      border: Border.all(color: Theme.of(context).secondaryHeaderColor)),
                  child: SearchbarWidget(
                    initialText: param.searchQuery,
                    hint: l10n.searchBarCode,
                    onQuery: (query) {
                      provider.searchQuery = query;
                    },
                  ),
                ),
                Selector<ReceivedDevicesProvider, String?>(builder: (context, query, widget) {
                  return Expanded(child: ReceivedDevicesListWidget(key: UniqueKey()));
                }, selector: (context, provider) {
                  return provider.searchQuery;
                })
              ],
            );
          },
        );
      },
    );
  }

  @override
  Function(Map<String, dynamic> data)? fromConfig() {
    return ReceiveRubbingDeviceCompConfig.fromConfig;
  }
}
