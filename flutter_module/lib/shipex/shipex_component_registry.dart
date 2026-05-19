import 'package:flutter/material.dart';
import 'package:flutter_trc/shipex/modules/pending_dispatch/components/complete_dispatch_component.dart';
import 'package:flutter_trc/shipex/modules/pending_dispatch/components/pending_dispatch_provider_list_component.dart';

import 'modules/create_shipment/components/create_manual_shipment_component.dart';
import 'modules/create_shipment/components/create_shipment_component.dart';
import 'modules/create_shipment/components/order_group_details_component.dart';
import 'modules/create_shipment/components/sub_order_group_component.dart';
import 'modules/create_shipment/components/upload_eway_bill_component.dart';
import 'modules/dispatch/components/dispatch_component.dart';
import 'modules/packaging/components/packaging_process_component.dart';
import 'modules/packaging/components/shipex_packing_component.dart';
import 'modules/shipex_home/components/shipex_home_component.dart';

class ShipexComponentRegistry {
  static Widget? getRegisteredComponent(String? componentKey, Map<String, dynamic>? jsonConfig) {
    switch (componentKey) {
      case ShipexHomeComponent.COMP_KEY:
        return ShipexHomeComponent(jsonConfig);
      case DispatchComponent.COMP_KEY:
        return DispatchComponent(jsonConfig);
      case ShipexPackingComponent.COMP_KEY:
        return ShipexPackingComponent(jsonConfig);
      case PackagingProcessComponent.COMP_KEY:
        return PackagingProcessComponent(jsonConfig);
      case SubOrderGroupListComponent.COMP_KEY:
        return SubOrderGroupListComponent(jsonConfig);
      case OrderGroupDetailsComponent.COMP_KEY:
        return OrderGroupDetailsComponent(jsonConfig);
      case UploadEwayBillComponent.COMP_KEY:
        return UploadEwayBillComponent(jsonConfig);
      case CreateShipmentComponent.COMP_KEY:
        return CreateShipmentComponent(jsonConfig);
      case CreateManualShipmentComponent.COMP_KEY:
        return CreateManualShipmentComponent(jsonConfig);
      case PendingDispatchProviderListComponent.COMP_KEY:
        return PendingDispatchProviderListComponent(jsonConfig);
      case CompleteDispatchComponent.COMP_KEY:
        return CompleteDispatchComponent(jsonConfig);
      default:
        null;
    }
    return null;
  }
}
