import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:pd/pd.dart';

class PDScreenExample extends StatelessWidget {
  static const route = 'pd-screen';
  static const title = 'PD';

  const PDScreenExample({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    DeviceInfoHandler().syncDeviceDetails(context);
    return Builder(builder: (innerContext) {
      return CshScaffold(
          middleSection: Center(
              child: CshMediumButton(
                  text: 'start',
                  onPressed: () {
                    ProductDiscovery.startProductDiscoveryJourney(
                        context: innerContext,
                        serviceId: 2,
                        pinCode: '110049',
                        regionId: 312,
                        sourceId: 2,
                        onItemSelectCallback: (item) {
                          Navigator.of(innerContext).pop();
                          CshSnackBar.show(
                              context: innerContext, message: '${item.serviceId}       ${item.product?.productName}');
                        });
                  })));
    });
  }
}
