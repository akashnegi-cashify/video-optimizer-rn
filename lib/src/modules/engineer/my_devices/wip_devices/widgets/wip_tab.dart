import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/src/modules/engineer/l10n.dart';
import 'package:flutter_trc/src/modules/engineer/models/engineer_device_info.dart';
import 'package:flutter_trc/src/modules/engineer/models/engineer_device_list_response.dart';
import 'package:flutter_trc/src/modules/engineer/my_devices/wip_devices/widgets/wip_detail_screen.dart';
import 'package:visibility_detector/visibility_detector.dart';

import '../../../../../common/widgets/shimmer_list_widget.dart';
import '../../../resources/engineer_api_service.dart';

class WIPTab extends StatefulWidget {
  const WIPTab({Key? key}) : super(key: key);

  @override
  State<WIPTab> createState() => _WIPTabState();
}

class _WIPTabState extends State<WIPTab> {
  Stream<EngineerDeviceListResponse?>? stream;

  @override
  Widget build(BuildContext context) {
    return VisibilityDetector(
      key: const Key('wip_widget'),
      child: StreamBuilder<EngineerDeviceListResponse?>(
        builder: (context, asyncSnapshot) {
          if (asyncSnapshot.connectionState == ConnectionState.waiting) return const ShimmerListWidget();

          if (asyncSnapshot.hasData && asyncSnapshot.data != null) {
            var list = asyncSnapshot.data!.deviceList;
            if (list != null) {
              return CshList(
                rowCount: list.length,
                onRefresh: _refreshStream,
                getRowWidget: (index) {
                  return SizedBox(width: double.infinity, child: _ItemWIP(deviceData: list[index]));
                },
              );
            }
          }
          return const SizedBox.shrink();
        },
        stream: stream,
      ),
      onVisibilityChanged: (visibilityInfo) async {
        // this sort of onResume callback, as we need to refresh list whenever user comes again here.
        if (visibilityInfo.visibleFraction == 1) {
          print("fraction is 1");
          _refreshStream();
        }
      },
    );
  }

  void _refreshStream() {
    setState(() {
      stream = EngineerAPIService.getAllWIPDevices();
    });
  }
}

class _ItemWIP extends StatelessWidget {
  final EngineerDeviceInfo deviceData;

  const _ItemWIP({Key? key, required this.deviceData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    L10n l10n = L10n(context);
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, WIPDetailScreen.route, arguments: deviceData);
      },
      child: CshCard(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CshTextNew.h3("${l10n.deviceBarcode} - ${deviceData.deviceBarcode}"),
            Container(
              height: Dimens.space_2,
              width: Dimens.space_28,
              color: Theme.of(context).colorScheme.onBackground,
            ),
            const SizedBox(
              height: Dimens.space_8,
            ),
            CshTextNew.h5("${l10n.productTitle} - ${deviceData.productTitle}"),
            CshTextNew.h5("${l10n.status} - ${deviceData.status}")
          ],
        ),
      ),
    );
  }
}
