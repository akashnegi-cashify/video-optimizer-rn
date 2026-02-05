import 'package:flutter/material.dart';
import 'package:flutter_trc/src/common/user/widget/user_profile_screen.dart';
import 'package:flutter_trc/src/modules/audit/screens/trc_audit_screen.dart';
import 'package:flutter_trc/src/modules/elss/common_screen/elss_home_screen.dart';
import 'package:flutter_trc/src/modules/elss/elss_qc/screens/add_part_screen_qc.dart';
import 'package:flutter_trc/src/modules/elss/elss_qc/screens/allowed_option_screen.dart';
import 'package:flutter_trc/src/modules/elss/elss_qc/screens/elss_status_screen.dart';
import 'package:flutter_trc/src/modules/elss/elss_qc/screens/part_selection_screen_qc.dart';
import 'package:flutter_trc/src/modules/elss/elss_trc/screens/add_device_media_screen_trc.dart';
import 'package:flutter_trc/src/modules/elss/elss_trc/screens/add_part_screen_trc.dart';
import 'package:flutter_trc/src/modules/elss/elss_trc/screens/brand_details_listing_screen.dart';
import 'package:flutter_trc/src/modules/elss/elss_trc/screens/part_selection_screen_trc.dart';
import 'package:flutter_trc/src/modules/engineer/manage_parts/manage_parts_screen.dart';
import 'package:flutter_trc/src/modules/engineer/my_devices/widgets/my_devices_screen.dart';
import 'package:flutter_trc/src/modules/engineer/my_devices/wip_devices/view_parts/part_detail/capture_consume_parts_media_screen.dart';
import 'package:flutter_trc/src/modules/engineer/my_devices/wip_devices/view_parts/widgets/assigned_parts_screen.dart';
import 'package:flutter_trc/src/modules/engineer/my_devices/wip_devices/view_parts/widgets/order_part_widget.dart';
import 'package:flutter_trc/src/modules/engineer/my_devices/wip_devices/view_parts/widgets/self_assign_part_widget.dart';
import 'package:flutter_trc/src/modules/engineer/my_devices/wip_devices/wip_devices_screen.dart';
import 'package:flutter_trc/src/modules/engineer/screens/device_report_screen.dart';
import 'package:flutter_trc/src/modules/engineer/screens/part_request_reasons_screen.dart';
import 'package:flutter_trc/src/modules/engineer/screens/retrieved_part_list_screen.dart';
import 'package:flutter_trc/src/modules/engineer/view_reports/view_report_screen.dart';
import 'package:flutter_trc/src/modules/engineer/widgets/engineer_home_widget.dart';
import 'package:flutter_trc/src/modules/home/home_screen.dart';
import 'package:flutter_trc/src/modules/home/trc_home_screen_new.dart';
import 'package:flutter_trc/src/modules/inventory_manager/screens/alternate_part_screen.dart';
import 'package:flutter_trc/src/modules/inventory_manager/screens/assign_part_barcode_scanner.dart';
import 'package:flutter_trc/src/modules/inventory_manager/screens/assigned_device_details_screen.dart';
import 'package:flutter_trc/src/modules/inventory_manager/screens/assigned_part_details_screen.dart';
import 'package:flutter_trc/src/modules/inventory_manager/screens/inventory_home_screen.dart';
import 'package:flutter_trc/src/modules/inventory_manager/screens/pending_delivery_screen.dart';
import 'package:flutter_trc/src/modules/inventory_manager/screens/pending_part_details_screen.dart';
import 'package:flutter_trc/src/modules/inventory_manager/screens/pending_part_list_screen.dart';
import 'package:flutter_trc/src/modules/inventory_manager/screens/return_item_status_screen.dart';
import 'package:flutter_trc/src/modules/inventory_manager/screens/return_page.dart';
import 'package:flutter_trc/src/modules/inventory_manager/screens/summary_screen.dart';
import 'package:flutter_trc/src/modules/l4/l4_home_screen.dart';
import 'package:flutter_trc/src/modules/login/screens/login_screen.dart';
import 'package:flutter_trc/src/modules/login/screens/trc_and_qc_login_screen.dart';
import 'package:flutter_trc/src/modules/part_qc/screens/pq_home_screen.dart';
import 'package:flutter_trc/src/modules/rider/pending_delivery/deliver/delivery_deliver_engineer_parts_screen.dart';
import 'package:flutter_trc/src/modules/rider/pending_pickup/receive/pickup_receive_engineer_parts_screen.dart';
import 'package:flutter_trc/src/modules/rider/rider_home_screen.dart';
import 'package:flutter_trc/src/modules/rider/screens/rider_pending_delivery_deliver_screen.dart';
import 'package:flutter_trc/src/modules/rider/screens/rider_pending_delivery_receive_screen.dart';
import 'package:flutter_trc/src/modules/rider/screens/rider_pending_pickup_screen.dart';
import 'package:flutter_trc/src/modules/rubbing/widgets/received_rubbing_devices_screen.dart';
import 'package:flutter_trc/src/modules/rubbing/widgets/rubbing_home_screen.dart';
import 'package:flutter_trc/src/modules/splash/splash_screen.dart';
import 'package:flutter_trc/src/modules/store_manager/screens/store_manager_home_screen.dart';
import 'package:flutter_trc/src/modules/trc_executive/screens/device_scanner_screen.dart';
import 'package:flutter_trc/src/modules/trc_executive/screens/trc_executive_screen.dart';
import 'package:flutter_trc/src/modules/trc_executive/screens/trc_executive_store_out_screen.dart';
import 'package:flutter_trc/src/modules/trc_tester/trc_tester_screen.dart';

import '../src/modules/engineer/retreived_parts/screens/image_view_screen.dart';
import '../src/modules/engineer/retreived_parts/screens/retrieved_parts_details_data_screen.dart';
import '../src/modules/part_qc/retrieved_part_qc/screens/action_screen.dart';
import '../src/modules/part_qc/retrieved_part_qc/screens/view_repost_qc_screen.dart';
import '../src/modules/trc_executive/screens/tl_list_screen.dart';

class TrcRoutes {
  static Map<String, WidgetBuilder> getRoutes() {
    return {
      SplashScreen.route: (_) => const SplashScreen(),
      HomeScreen.route: (_) => const HomeScreen(),
      TrcHomeScreenNew.route: (_) => const TrcHomeScreenNew(),
      RubbingHomeScreen.route: (_) => const RubbingHomeScreen(),
      ReceivedRubbingDevicesScreen.route: (_) => const ReceivedRubbingDevicesScreen(),
      ElssHomeScreen.route: (_) => const ElssHomeScreen(),
      //ELSS_TRC_ROUTES
      AddDeviceMediaScreenTrc.route: (_) => const AddDeviceMediaScreenTrc(),
      AddPartScreenTrc.route: (_) => const AddPartScreenTrc(),
      PartSelectionScreenTrc.route: (_) => const PartSelectionScreenTrc(),
      BrandsDetailsListingScreen.route: (_) => const BrandsDetailsListingScreen(),
      ElssStatusScreen.routeName: (_) => const ElssStatusScreen(),
      //ELSS_QC_ROUTES
      AddPartScreenQc.route: (_) => const AddPartScreenQc(),
      PartSelectionScreenQc.route: (_) => const PartSelectionScreenQc(),
      AllowedOptionScreen.route: (_) => const AllowedOptionScreen(),
      // engineer routes
      EngineerHomeScreen.route: (_) => const EngineerHomeScreen(),
      MyDevicesScreen.route: (_) => const MyDevicesScreen(),
      AssignedPartsScreen.route: (_) => const AssignedPartsScreen(),
      WipDevicesScreen.route: (_) => const WipDevicesScreen(),
      SelfAssignPartScreen.route: (_) => const SelfAssignPartScreen(),
      OrderPartScreen.route: (_) => const OrderPartScreen(),
      ManagePartsScreen.route: (_) => const ManagePartsScreen(),
      ViewReportScreen.route: (_) => const ViewReportScreen(),
      RiderHomeScreen.route: (_) => const RiderHomeScreen(),
      DeliveryDeliverEngineerPartsScreen.route: (_) => const DeliveryDeliverEngineerPartsScreen(),
      PickUpReceiveEngineerPartsScreen.route: (_) => const PickUpReceiveEngineerPartsScreen(),
      L4HomeScreen.route: (_) => const L4HomeScreen(),

      //Inventory routes
      InventoryHomeScreen.route: (_) => const InventoryHomeScreen(),
      PendingDeliveryScreen.route: (_) => const PendingDeliveryScreen(),
      PendingPartListScreen.route: (_) => const PendingPartListScreen(),
      PendingPartDetailsScreen.route: (_) => const PendingPartDetailsScreen(),
      AssignPartBarcodeScreen.route: (_) => const AssignPartBarcodeScreen(),
      AssignedDeviceDetailsScreen.route: (_) => const AssignedDeviceDetailsScreen(),
      AssignedPartDetailsScreen.route: (_) => const AssignedPartDetailsScreen(),
      ReturnScreen.route: (_) => const ReturnScreen(),
      ReturnStatusScreen.route: (_) => const ReturnStatusScreen(),
      SummaryScreen.route: (_) => const SummaryScreen(),
      AlternatePartScreen.route: (_) => const AlternatePartScreen(),
      //Part qc routes
      PartQCHomeScreen.route: (_) => const PartQCHomeScreen(),
      TRCExecutiveScreen.route: (_) => const TRCExecutiveScreen(),
      DeviceScannerScreen.route: (_) => const DeviceScannerScreen(),
      LoginScreen.route: (_) => const LoginScreen(),
      TrcAndQcLoginScreen.route: (_) => const TrcAndQcLoginScreen(),
      TrcTesterScreen.route: (_) => const TrcTesterScreen(),
      StoreManagerHomeScreen.route: (_) => const StoreManagerHomeScreen(),
      CaptureConsumePartsMediaScreen.route: (_) => const CaptureConsumePartsMediaScreen(),
      RetrievedPartListScreen.route: (_) => const RetrievedPartListScreen(),
      RetrievedPartsDataDetailsScreen.route: (_) => const RetrievedPartsDataDetailsScreen(),
      ViewRepostQcScreen.route: (_) => const ViewRepostQcScreen(),
      ActionScreen.route: (_) => const ActionScreen(),
      ProductImageViewScreen.route: (_) => const ProductImageViewScreen(),
      DeviceReportScreen.route: (_) => const DeviceReportScreen(),
      PartRequestReasonsScreen.route: (_) => const PartRequestReasonsScreen(),
      TlListScreen.route: (_) => const TlListScreen(),
      TrcAuditScreen.route: (_) => const TrcAuditScreen(),
      TRCExecutiveStoreOutScreen.route: (_) => const TRCExecutiveStoreOutScreen(),
      UserProfileScreen.route: (_) => const UserProfileScreen(),
      PendingDeliveryReceiveScreen.route: (_) => const PendingDeliveryReceiveScreen(),
      RiderPendingDeliveryDeliverScreen.route: (_) => const RiderPendingDeliveryDeliverScreen(),
      RiderPendingPickupScreen.route: (_) => const RiderPendingPickupScreen(),
    };
  }
}
