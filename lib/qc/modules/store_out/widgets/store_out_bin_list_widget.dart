import 'package:components/components.dart';
import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/qc/modules/store_out/resources/store_out_bin_list_response.dart';
import 'package:flutter_trc/qc/modules/store_out/widgets/index.dart';
import 'package:flutter_trc/src/libraries/shared_preferences/app_preferences.dart';
import 'package:flutter_trc/src/modules/login/resources/login_types.dart';
import 'package:flutter_trc/src/services/service_groups.dart';

import '../l10n.dart';

class StoreOutBinListWidget extends StatefulWidget {
  final Function(String? lotName, int? lotId)? onItemClick;

  const StoreOutBinListWidget({super.key, this.onItemClick});

  @override
  State<StoreOutBinListWidget> createState() => _StoreOutBinListWidgetState();
}

class _StoreOutBinListWidgetState extends State<StoreOutBinListWidget> with AutomaticKeepAliveClientMixin {
  final CshListController _listController = CshListController();

  /// Returns the appropriate service group based on login type
  TRCServiceGroups _getServiceGroup() {
    var loginTypeEnum = LoginTypes.fromValue(AppPreferences.app.getLoginType() ?? "");
    return loginTypeEnum == LoginTypes.qcLogin
        ? TRCServiceGroups.qcConsole
        : TRCServiceGroups.unifyTrc;
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    var l10n = L10n(context);

    return CshApiList<StoreOutBinListItem>(
      apiConfig: ListApiConfig(apiUrl: "/bin/lot/store-out/list?", serviceGroup: _getServiceGroup()),
      controller: _listController,
      shimmerLoaderWidget: const CshShimmer(height: Dimens.space_60),
      itemFromJson: StoreOutBinListItem.fromJson,
      getRowWidget: (item, index) {
        final data = item!;
        return cshGestureDetector(
          child: ListItemWidget(
            l10n.lotName,
            lotValue: data.lotName,
            noOfDevices: data.counter?.toString(),
          ),
          onTap: () => widget.onItemClick?.call(data.lotName, data.lotId),
        );
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}
