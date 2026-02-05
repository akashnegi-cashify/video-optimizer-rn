import 'package:builder_component/builder_component.dart';
import 'package:core_widgets/core_widgets.dart';
import 'package:csh_annotation/annotation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/src/app_builder/app_builder_groups/groups.dart';
import 'package:flutter_trc/src/app_builder/app_headers/general_app_header/models/none_config_model.dart';
import 'package:flutter_trc/src/modules/rider/screens/rider_pending_delivery_deliver_screen.dart';
import 'package:flutter_trc/src/modules/rider/screens/rider_pending_delivery_receive_screen.dart';
import 'package:flutter_trc/src/modules/rider/screens/rider_pending_pickup_screen.dart';
import 'package:flutter_trc/src/utils/dotted_divider_line.dart';

part 'rider_home_component.g.dart';

@CshComponent(
    key: RiderHomeComponent.COMP_KEY,
    configModel: NoneConfigModel,
    componentGroup: ComponentGroup.riderHomeComponentKey)
class RiderHomeComponent extends StatelessComponent<NoneConfigModel> {
  static const String COMP_KEY = "TRC_rider_home_component";

  const RiderHomeComponent(super.jsonConfig, {super.key});

  @override
  Widget buildView(BuildContext context, configModel) {
    // return const RiderWidget();
    return Padding(
      padding: const EdgeInsets.all(Dimens.space_16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.center,
        spacing: Dimens.space_16,
        children: [
          CshBigButton(
            text: "Pending Delivery",
            onPressed: () => _showDialog(context),
          ),
          CshBigButton(
            text: "Pending Pickup",
            onPressed: () {
              Navigator.pushNamed(context, RiderPendingPickupScreen.route);
            },
          ),
        ],
      ),
    );
  }

  void _showDialog(BuildContext context) {
    showCshBottomSheet(
      context: context,
      child: Padding(
        padding: const EdgeInsets.all(Dimens.space_16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          spacing: Dimens.space_16,
          children: [
            CshTextNew.h3('Choose action'),
            DottedLineDivider(),
            CshMediumButton(
              text: 'Receive',
              onPressed: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, PendingDeliveryReceiveScreen.route);
              },
            ),
            CshMediumButton(
              text: 'Deliver',
              onPressed: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, RiderPendingDeliveryDeliverScreen.route);
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  Function(Map<String, dynamic> data)? fromConfig() {
    return NoneConfigModel.fromConfig;
  }
}
