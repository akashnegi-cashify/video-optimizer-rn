import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/src/common/widgets/shimmer_list_widget.dart';
import 'package:flutter_trc/src/modules/engineer/models/engineer_device_list_response.dart';
import 'package:flutter_trc/src/modules/engineer/my_devices/all_devices/provider/all_devices_provider.dart';
import 'package:flutter_trc/src/modules/engineer/my_devices/all_devices/widget/item_all_devices_widget.dart';
import 'package:flutter_trc/src/modules/engineer/resources/engineer_api_service.dart';
import 'package:provider/provider.dart';

class AllDevicesWidget extends StatefulWidget {
  const AllDevicesWidget({Key? key}) : super(key: key);

  @override
  State<AllDevicesWidget> createState() => _AllDevicesWidgetState();
}

class _AllDevicesWidgetState extends State<AllDevicesWidget> with AutomaticKeepAliveClientMixin {
  late Stream<EngineerDeviceListResponse?> stream;

  @override
  void initState() {
    stream = EngineerAPIService.getAllDevices();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<AllDevicesProvider>(
      create: (_) => AllDevicesProvider(),
      lazy: false,
      builder: (BuildContext insideContext, __) {
        var provider = AllDevicesProvider.of(insideContext);
        provider.refreshAllDeviceList = refreshList;
        return Column(
          children: [
            Expanded(
              child: StreamBuilder<EngineerDeviceListResponse?>(
                builder: (context, asyncSnapshot) {
                  if (asyncSnapshot.connectionState == ConnectionState.waiting) {
                    return const ShimmerListWidget(
                      itemHeight: Dimens.space_60,
                    );
                  }
                  if (asyncSnapshot.hasData && asyncSnapshot.data != null) {
                    var list = asyncSnapshot.data!.deviceList;
                    if (list != null) {
                      return CshList(
                        rowCount: list.length,
                        onRefresh: refreshList,
                        getRowWidget: (index) {
                          return ItemAllDevicesWidget(list[index]);
                        },
                      );
                    }
                  }
                  return const SizedBox.shrink();
                },
                stream: stream,
              ),
            )
          ],
        );
      },
    );
  }

  refreshList() {
    setState(() {
      stream = EngineerAPIService.getAllDevices();
    });
  }

  @override
  bool get wantKeepAlive => true;
}
