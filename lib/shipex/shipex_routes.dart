import 'package:flutter/material.dart';
import 'package:flutter_trc/shipex/modules/create_shipment/screen/create_shipment_screen.dart';
import 'package:flutter_trc/shipex/modules/pending_dispatch/screens/pending_dispatch_provider_list_screen.dart';

import 'modules/create_shipment/screen/create_manual_shipment_screen.dart';
import 'modules/create_shipment/screen/sub_order_group_detail_screen.dart';
import 'modules/create_shipment/screen/sub_order_group_listing_screen.dart';
import 'modules/create_shipment/screen/upload_eway_bill_screen.dart';
import 'modules/dispatch/dispatch_screen.dart';
import 'modules/packaging/packaging_process_screen.dart';
import 'modules/packaging/shipex_packing_screen.dart';
import 'modules/pending_dispatch/screens/complete_dispatch_screen.dart';
import 'modules/shipex_home/screens/shipex_home_screen.dart';

class ShipexRoutes {
  static Map<String, WidgetBuilder> getRoutes() {
    return {
      ShipexHomeScreen.route: (_) => const ShipexHomeScreen(),
      DispatchScreen.route: (_) => const DispatchScreen(),
      ShipexPackingScreen.route: (_) => const ShipexPackingScreen(),
      PackagingProcessScreen.route: (_) => const PackagingProcessScreen(),
      SubOrderGroupListingScreen.route: (_) => const SubOrderGroupListingScreen(),
      SubOrderGroupDetailsScreen.route: (_) => const SubOrderGroupDetailsScreen(),
      UploadEwayBillScreen.route: (_) => const UploadEwayBillScreen(),
      CreateShipmentScreen.route: (_) => const CreateShipmentScreen(),
      CreateManualShipmentScreen.route: (_) => const CreateManualShipmentScreen(),
      PendingDispatchProviderListScreen.route: (_) => const PendingDispatchProviderListScreen(),
      CompleteDispatchScreen.route: (_) => const CompleteDispatchScreen(),
    };
  }
}
