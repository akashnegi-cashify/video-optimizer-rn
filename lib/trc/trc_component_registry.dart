import 'package:components/no_internet/no_internet_component.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/src/modules/elss/components/add_device_media_component.dart';
import 'package:flutter_trc/src/modules/elss/components/add_part_component.dart';
import 'package:flutter_trc/src/modules/elss/components/add_part_qc_component.dart';
import 'package:flutter_trc/src/modules/elss/components/allowed_option_component.dart';
import 'package:flutter_trc/src/modules/elss/components/elss_home_component.dart';
import 'package:flutter_trc/src/modules/elss/components/elss_status_component.dart';
import 'package:flutter_trc/src/modules/elss/components/part_selection_component.dart';
import 'package:flutter_trc/src/modules/elss/components/part_selection_qc_component.dart';
import 'package:flutter_trc/src/modules/engineer/components/engineer_home_component.dart';
import 'package:flutter_trc/src/modules/engineer/components/manage_parts_component.dart';
import 'package:flutter_trc/src/modules/engineer/components/retrieved_part_list_component.dart';
import 'package:flutter_trc/src/modules/engineer/my_devices/widgets/components/my_devices_component.dart';
import 'package:flutter_trc/src/modules/engineer/my_devices/wip_devices/components/wip_devices_details_comp.dart';
import 'package:flutter_trc/src/modules/engineer/view_reports/component/view_report_component.dart';
import 'package:flutter_trc/src/modules/home/component/home_component.dart';
import 'package:flutter_trc/src/modules/inventory_manager/components/alternate_part_component.dart';
import 'package:flutter_trc/src/modules/inventory_manager/components/assign_part_barcode_scanner_component.dart';
import 'package:flutter_trc/src/modules/inventory_manager/components/assigned_device_details_component.dart';
import 'package:flutter_trc/src/modules/inventory_manager/components/assigned_part_details_component.dart';
import 'package:flutter_trc/src/modules/inventory_manager/components/inventory_home_component.dart';
import 'package:flutter_trc/src/modules/inventory_manager/components/pending_delivery_component.dart';
import 'package:flutter_trc/src/modules/inventory_manager/components/pending_part_details_component.dart';
import 'package:flutter_trc/src/modules/inventory_manager/components/pending_part_list_component.dart';
import 'package:flutter_trc/src/modules/inventory_manager/components/return_component.dart';
import 'package:flutter_trc/src/modules/inventory_manager/components/return_item_status_component.dart';
import 'package:flutter_trc/src/modules/inventory_manager/components/summary_component.dart';
import 'package:flutter_trc/src/modules/l4/components/l4_component.dart';
import 'package:flutter_trc/src/modules/login/component/login_component.dart';
import 'package:flutter_trc/src/modules/login/component/trc_and_qc_login_component.dart';
import 'package:flutter_trc/src/modules/part_qc/components/part_qc_home_component.dart';
import 'package:flutter_trc/src/modules/rider/components/rider_home_component.dart';
import 'package:flutter_trc/src/modules/rider/pending_delivery/deliver/components/delivery_deliver_engineer_parts_component.dart';
import 'package:flutter_trc/src/modules/rider/pending_pickup/receive/component/pickup_receive_engineer_parts_comp.dart';
import 'package:flutter_trc/src/modules/rubbing/components/receive_rubbing_device_comp.dart';
import 'package:flutter_trc/src/modules/rubbing/components/rubbing_home_component.dart';
import 'package:flutter_trc/src/modules/splash/components/splash_component.dart';
import 'package:flutter_trc/src/modules/trc_executive/components/device_scanner_comp.dart';
import 'package:flutter_trc/src/modules/trc_executive/components/trc_executive_component.dart';
import 'package:flutter_trc/src/modules/trc_tester/components/trc_tester_component.dart';

import '../src/modules/retreived_parts/components/retrieved_parts_data_details_component.dart';
import '../src/modules/retrieved_part_qc/components/action_component.dart';
import '../src/modules/retrieved_part_qc/components/retrieved_part_qc_dashboard.dart';
import '../src/modules/retrieved_part_qc/components/view_report_qc_component.dart';
import '../src/modules/store_manager/components/store_manager_home_component.dart';

class TrcComponentRegistry {
  static Widget? getRegisteredComponent(String? componentKey, Map<String, dynamic>? jsonConfig) {
    switch (componentKey) {
      case NoInternetComponent.componentKey:
        return NoInternetComponent(jsonConfig);

      case LoginComponent.COMP_KEY:
        return LoginComponent(jsonConfig);

      case TrcAndQCLoginComponent.COMP_KEY:
        return TrcAndQCLoginComponent(jsonConfig);

      case RubbingHomeComponent.COMP_KEY:
        return RubbingHomeComponent(jsonConfig);

      case PendingPartDetailsComponents.COMP_KEY:
        return PendingPartDetailsComponents(jsonConfig);

      case PendingDeliveryComponent.COMP_KEY:
        return PendingDeliveryComponent(jsonConfig);

      case AlternatePartComponent.COMP_KEY:
        return AlternatePartComponent(jsonConfig);

      case AssignedPartDetailsComponent.COMP_KEY:
        return AssignedPartDetailsComponent(jsonConfig);

      case AssignPartBarcodeScannerComponent.COMP_KEY:
        return AssignPartBarcodeScannerComponent(jsonConfig);

      case AssignedDeviceDetailsComponent.COMP_KEY:
        return AssignedDeviceDetailsComponent(jsonConfig);

      case InventoryHomeComponent.COMP_KEY:
        return InventoryHomeComponent(jsonConfig);

      case PendingPartListComponent.COMP_KEY:
        return PendingPartListComponent(jsonConfig);

      case ReturnItemStatusComponent.COMP_KEY:
        return ReturnItemStatusComponent(jsonConfig);

      case ReturnComponent.COMP_KEY:
        return ReturnComponent(jsonConfig);

      case SummaryComponent.COMP_KEY:
        return SummaryComponent(jsonConfig);

      case PartSelectionQCComponent.COMP_KEY:
        return PartSelectionQCComponent(jsonConfig);

      case ElssStatusComponent.COMP_KEY:
        return ElssStatusComponent(jsonConfig);

      case AllowedOptionsComponent.COMP_KEY:
        return AllowedOptionsComponent(jsonConfig);

      case AddPartsQcComponent.COMP_KEY:
        return AddPartsQcComponent(jsonConfig);

      case PartSelectionComponent.COMP_KEY:
        return PartSelectionComponent(jsonConfig);

      case AddPartComponent.COMP_KEY:
        return AddPartComponent(jsonConfig);

      case AddDeviceMediaComponent.COMP_KEY:
        return AddDeviceMediaComponent(jsonConfig);

      case ElssHomeComponent.COMP_KEY:
        return ElssHomeComponent(jsonConfig);

      case ManagePartsComponent.COMP_KEY:
        return ManagePartsComponent(jsonConfig);

      case MyDevicesComponent.COMP_KEY:
        return MyDevicesComponent(jsonConfig);

      case WipDeviceDetailsComponent.COMP_KEY:
        return WipDeviceDetailsComponent(jsonConfig);

      case ViewReportComponent.COMP_KEY:
        return ViewReportComponent(jsonConfig);

      case EngineerHomeComponent.COMP_KEY:
        return EngineerHomeComponent(jsonConfig);

      case HomeComponent.COMP_KEY:
        return HomeComponent(jsonConfig);

      case L4Component.COMP_KEY:
        return L4Component(jsonConfig);

      case PartQcHomeComponent.COMP_KEY:
        return PartQcHomeComponent(jsonConfig);

      case DeliveryDeliverEngineerPartsComponent.COMP_KEY:
        return DeliveryDeliverEngineerPartsComponent(jsonConfig);

      case PickUpReceiveEngineerPartsCompo.COMP_KEY:
        return PickUpReceiveEngineerPartsCompo(jsonConfig);

      case RiderHomeComponent.COMP_KEY:
        return RiderHomeComponent(jsonConfig);

      case ReceiveRubbingDeviceComp.COMP_KEY:
        return ReceiveRubbingDeviceComp(jsonConfig);

      case DeviceScannerComponent.COMP_KEY:
        return DeviceScannerComponent(jsonConfig);

      case TrcExecutiveComponent.COMP_KEY:
        return TrcExecutiveComponent(jsonConfig);

      case SplashComponent.COMP_KEY:
        return SplashComponent(jsonConfig);

      case TrcTesterComponent.COMP_KEY:
        return TrcTesterComponent(jsonConfig);

      case StoreManagerHomeComponent.COMP_KEY:
        return StoreManagerHomeComponent(jsonConfig);

      case RetrievedPartListComponent.COMP_KEY:
        return RetrievedPartListComponent(jsonConfig);
      case RetrievedPartsDataDetailsComponents.COMP_KEY:
        return RetrievedPartsDataDetailsComponents(jsonConfig);
      case RetrievedPartQcDashboardComponent.COMP_KEY:
        return RetrievedPartQcDashboardComponent(jsonConfig);
      case ViewReportQcComponent.COMP_KEY:
        return ViewReportQcComponent(jsonConfig);
      case ActionComponent.COMP_KEY:
        return ActionComponent(jsonConfig);
      default:
        return null;
    }
  }
}
