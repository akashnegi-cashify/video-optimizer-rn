import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/src/common/widgets/shimmer_list_widget.dart';
import 'package:flutter_trc/src/modules/engineer/l10n.dart';
import 'package:flutter_trc/src/modules/engineer/models/engineer_device_list_response.dart';
import 'package:flutter_trc/src/modules/engineer/my_devices/all_devices/provider/all_devices_provider.dart';
import 'package:flutter_trc/src/modules/engineer/my_devices/all_devices/widget/item_all_devices_widget.dart';
import 'package:flutter_trc/src/modules/engineer/resources/engineer_api_service.dart';
import 'package:provider/provider.dart';

import '../../../../../utils/app_constants.dart';

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
            const _Header(),
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

class _Header extends StatelessWidget {
  const _Header({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    L10n l10n = L10n(context);
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: width * 0.08, vertical: Dimens.space_8),
          child: Row(
            children: [
              SizedBox(
                width: width * 0.16,
                child: CshTextNew.h5(l10n.action),
              ),
              SizedBox(
                width: width * 0.20,
                child: CshTextNew.h5(l10n.barcode),
              ),
              SizedBox(
                width: width * 0.28,
                child: CshTextNew.h5(l10n.productTitle),
              ),
              SizedBox(
                width: width * 0.16,
                child: CshTextNew.h5(l10n.status),
              ),
            ],
          ),
        ),
        Container(
          width: double.infinity,
          height: Dimens.space_2,
          color: Theme.of(context).colorScheme.primary,
        ),
      ],
    );
  }
}
