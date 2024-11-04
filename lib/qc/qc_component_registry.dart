import 'package:flutter/material.dart';
import 'package:flutter_trc/qc/modules/d2c_video/components/d2c_video_component.dart';
import 'package:flutter_trc/qc/modules/device_details/components/device_details_component.dart';
import 'package:flutter_trc/qc/modules/dispatch_lot/components/invoice_scan_component.dart';
import 'package:flutter_trc/qc/modules/external_audit/components/external_audit_home_component.dart';
import 'package:flutter_trc/qc/modules/external_audit/components/external_audit_perform_component.dart';
import 'package:flutter_trc/qc/modules/gaurd/components/guard_device_counting_list_component.dart';
import 'package:flutter_trc/qc/modules/gaurd/components/guard_upload_invoice_component.dart';
import 'package:flutter_trc/qc/modules/gaurd/components/qc_guard_home_component.dart';
import 'package:flutter_trc/qc/modules/imei_validator/components/imei_validator_component.dart';
import 'package:flutter_trc/qc/modules/qc_tester/audit/components/audit_barcode_scanner_component.dart';
import 'package:flutter_trc/qc/modules/qc_tester/audit/components/audit_question_component.dart';
import 'package:flutter_trc/qc/modules/qc_tester/audit/components/audit_question_summary_component.dart';
import 'package:flutter_trc/qc/modules/qc_tester/calculator/component/calculator_component.dart';
import 'package:flutter_trc/qc/modules/qc_tester/calculator/component/calculator_scanner_component.dart';
import 'package:flutter_trc/qc/modules/qc_tester/calculator/component/disputed_question_component.dart';
import 'package:flutter_trc/qc/modules/qc_tester/calculator/component/submit_device_quote_component.dart';
import 'package:flutter_trc/qc/modules/qc_tester/lob_devices/component/color_selection_component.dart';
import 'package:flutter_trc/qc/modules/qc_tester/lob_devices/component/lob_device_scanner_component.dart';
import 'package:flutter_trc/qc/modules/qc_tester/lob_devices/component/product_list_component.dart';
import 'package:flutter_trc/qc/modules/re_qc/components/re_qc_detail_component.dart';
import 'package:flutter_trc/qc/modules/re_qc/components/re_qc_list_component.dart';
import 'package:flutter_trc/qc/modules/stock_in_module/components/media_file_upload_component.dart';
import 'package:flutter_trc/qc/modules/stock_transfer/components/pending_dispatch_detail_component.dart';
import 'package:flutter_trc/qc/modules/stock_transfer/components/pending_lot_detail_component.dart';
import 'package:flutter_trc/qc/modules/stock_transfer/components/st_store_out_component.dart';
import 'package:flutter_trc/qc/modules/stock_transfer/components/stock_transfer_list_component.dart';
import 'package:flutter_trc/qc/modules/stock_transfer/components/storage_device_list_component.dart';
import 'package:flutter_trc/qc/modules/store_in/components/index.dart';
import 'package:flutter_trc/qc/modules/supervisor/components/supervisor_component.dart';
import 'package:flutter_trc/qc/modules/warehouse_audit/components/on_going_audit_component.dart';
import 'package:flutter_trc/qc/modules/warehouse_audit/components/warehouse_audit_perform_component.dart';
import 'package:flutter_trc/qc/qc_common/lot_type_filters/components/store_out_lots_filter_component.dart';

import 'modules/dead_repair/components/index.dart';
import 'modules/device_receive_module/components/device_receive_component.dart';
import 'modules/dispatch_lot/components/dispatch_lots_component.dart';
import 'modules/gaurd/components/qc_guard_add_agent_component.dart';
import 'modules/pre_dispatch/components/index.dart';
import 'modules/qc_actions/component/qc_action_component.dart';
import 'modules/qc_tester/calculator_media_capture/components/calculator_media_capture_component.dart';
import 'modules/qc_tester/disputed_image_capture/components/disputed_image_barcode_scanner_component.dart';
import 'modules/qc_tester/disputed_image_capture/components/disputed_image_capture_component.dart';
import 'modules/qc_tester/home/component/qc_tester_home_component.dart';
import 'modules/stock_in_module/components/search_item_component.dart';
import 'modules/stock_in_module/components/stock_in_product_detail_component.dart';
import 'modules/store_out/components/index.dart';

class QcComponentRegistry {
  static Widget? getRegisteredComponent(String? componentKey, Map<String, dynamic>? jsonConfig) {
    switch (componentKey) {
      case DisputedImageCaptureComponent.COMP_KEY:
        return DisputedImageCaptureComponent(jsonConfig);
      case DisputedImageBarcodeScannerComponent.COMP_KEY:
        return DisputedImageBarcodeScannerComponent(jsonConfig);
      case CalculatorMediaCaptureComponent.COMP_KEY:
        return CalculatorMediaCaptureComponent(jsonConfig);
      case QcTesterHomeComponent.COMP_KEY:
        return QcTesterHomeComponent(jsonConfig);
      case QcActionComponent.COMP_KEY:
        return QcActionComponent(jsonConfig);
      case DeviceReceiveComponent.COMP_KEY:
        return DeviceReceiveComponent(jsonConfig);
      case CalculatorComponent.COMP_KEY:
        return CalculatorComponent(jsonConfig);
      case DisputedQuestionsComponent.COMP_KEY:
        return DisputedQuestionsComponent(jsonConfig);
      case AuditQuestionSummaryComponent.COMP_KEY:
        return AuditQuestionSummaryComponent(jsonConfig);
      case AuditQuestionComponent.COMP_KEY:
        return AuditQuestionComponent(jsonConfig);
      case AuditBarcodeScannedComponent.COMP_KEY:
        return AuditBarcodeScannedComponent(jsonConfig);
      case CalculatorScannerComponent.COMP_KEY:
        return CalculatorScannerComponent(jsonConfig);
      case SubmitDeviceQuoteComponent.COMP_KEY:
        return SubmitDeviceQuoteComponent(jsonConfig);
      case LobDeviceScannerComponent.COMP_KEY:
        return LobDeviceScannerComponent(jsonConfig);
      case ExternalAuditPerformComponent.COMP_KEY:
        return ExternalAuditPerformComponent(jsonConfig);
      case ReQcListComponent.COMP_KEY:
        return ReQcListComponent(jsonConfig);
      case ReQcDetailComponent.COMP_KEY:
        return ReQcDetailComponent(jsonConfig);
      case ExternalAuditHomeComponent.COMP_KEY:
        return ExternalAuditHomeComponent(jsonConfig);
      case SearchItemComponent.COMP_KEY:
        return SearchItemComponent(jsonConfig);
      case StockInProductDetailComponent.COMP_KEY:
        return StockInProductDetailComponent(jsonConfig);
      case MediaFileUploadComponent.COMP_KEY:
        return MediaFileUploadComponent(jsonConfig);
      case DispatchLotsComponent.COMP_KEY:
        return DispatchLotsComponent(jsonConfig);
      case InvoiceScanComponent.COMP_KEY:
        return InvoiceScanComponent(jsonConfig);
      case StockTransferListComponent.COMP_KEY:
        return StockTransferListComponent(jsonConfig);
      case StStoreOutComponent.COMP_KEY:
        return StStoreOutComponent(jsonConfig);
      case PendingLotDetailComponent.COMP_KEY:
        return PendingLotDetailComponent(jsonConfig);
      case PendingDispatchDetailComponent.COMP_KEY:
        return PendingDispatchDetailComponent(jsonConfig);

      case PreDispatchLotsComponent.COMP_KEY:
        return PreDispatchLotsComponent(jsonConfig);

      case PreDispatchComponent.COMP_KEY:
        return PreDispatchComponent(jsonConfig);

      case StoreInLocationScanComponent.COMP_KEY:
        return StoreInLocationScanComponent(jsonConfig);

      case StoreOutComponent.COMP_KEY:
        return StoreOutComponent(jsonConfig);

      case StoreOutLotsFilterComponent.COMP_KEY:
        return StoreOutLotsFilterComponent(jsonConfig);

      case LotItemsScanComponent.COMP_KEY:
        return LotItemsScanComponent(jsonConfig);

      case ReasonSelectionComponent.COMP_KEY:
        return ReasonSelectionComponent(jsonConfig);

      case DeviceDeadComponent.COMP_KEY:
        return DeviceDeadComponent(jsonConfig);

      case DeviceDeadAcceptRejectComponent.COMP_KEY:
        return DeviceDeadAcceptRejectComponent(jsonConfig);

      case QcGuardHomeComponent.COMP_KEY:
        return QcGuardHomeComponent(jsonConfig);

      case GuardDeviceCountingListComponent.COMP_KEY:
        return GuardDeviceCountingListComponent(jsonConfig);

      case GuardUploadInvoiceComponent.COMP_KEY:
        return GuardUploadInvoiceComponent(jsonConfig);

      case QcGuardAddAgentComponent.COMP_KEY:
        return QcGuardAddAgentComponent(jsonConfig);

      case SupervisorComponent.COMP_KEY:
        return SupervisorComponent(jsonConfig);

      case OnGoingAuditComponent.COMP_KEY:
        return OnGoingAuditComponent(jsonConfig);

      case WarehouseAuditPerformComponent.COMP_KEY:
        return WarehouseAuditPerformComponent(jsonConfig);

      case DeviceDetailsComponent.COMP_KEY:
        return DeviceDetailsComponent(jsonConfig);

      case StorageDeviceListComponent.COMP_KEY:
        return StorageDeviceListComponent(jsonConfig);

      case ImeiValidatorComponent.COMP_KEY:
        return ImeiValidatorComponent(jsonConfig);

      case D2CVideoComponent.COMP_KEY:
        return D2CVideoComponent(jsonConfig);

      case ProductListComponent.COMP_KEY:
        return ProductListComponent(jsonConfig);

      case ColorSelectionComponent.COMP_KEY:
        return ColorSelectionComponent(jsonConfig);

      default:
        return null;
    }
  }
}
