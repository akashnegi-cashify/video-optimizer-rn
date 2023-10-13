import 'package:flutter/material.dart';
import 'package:flutter_trc/qc/modules/dispatch_lot/components/invoice_scan_component.dart';
import 'package:flutter_trc/qc/modules/external_audit/components/external_audit_home_component.dart';
import 'package:flutter_trc/qc/modules/external_audit/components/external_audit_perform_component.dart';
import 'package:flutter_trc/qc/modules/qc_tester/audit/components/audit_barcode_scanner_component.dart';
import 'package:flutter_trc/qc/modules/qc_tester/audit/components/audit_question_component.dart';
import 'package:flutter_trc/qc/modules/qc_tester/audit/components/audit_question_summary_component.dart';
import 'package:flutter_trc/qc/modules/qc_tester/barcode_scanner_module/components/barcode_scanner_component.dart';
import 'package:flutter_trc/qc/modules/qc_tester/calculator/component/calculator_component.dart';
import 'package:flutter_trc/qc/modules/qc_tester/calculator/component/calculator_scanner_component.dart';
import 'package:flutter_trc/qc/modules/qc_tester/calculator/component/disputed_question_component.dart';
import 'package:flutter_trc/qc/modules/qc_tester/calculator/component/submit_device_quote_component.dart';
import 'package:flutter_trc/qc/modules/qc_tester/lob_devices/component/lob_device_scanner_component.dart';
import 'package:flutter_trc/qc/modules/re_qc/components/re_qc_detail_component.dart';
import 'package:flutter_trc/qc/modules/re_qc/components/re_qc_list_component.dart';
import 'package:flutter_trc/qc/modules/stock_in_module/components/media_file_upload_component.dart';
import 'package:flutter_trc/qc/modules/stock_transfer/components/pending_dispatch_detail_component.dart';
import 'package:flutter_trc/qc/modules/stock_transfer/components/pending_lot_detail_component.dart';
import 'package:flutter_trc/qc/modules/stock_transfer/components/st_store_out_component.dart';
import 'package:flutter_trc/qc/modules/stock_transfer/components/stock_transfer_list_component.dart';
import 'package:flutter_trc/qc/modules/store_in/components/index.dart';

import 'modules/device_receive_module/components/device_receive_component.dart';
import 'modules/dispatch_lot/components/dispatch_lots_component.dart';
import 'modules/dispatch_lot/components/dispatch_lots_filter_component.dart';
import 'modules/pre_dispatch/components/index.dart';
import 'modules/qc_actions/component/qc_action_component.dart';
import 'modules/qc_tester/calculator_media_capture/components/calculator_media_capture_component.dart';
import 'modules/qc_tester/disputed_image_capture/components/disputed_image_barcode_scanner_component.dart';
import 'modules/qc_tester/disputed_image_capture/components/disputed_image_capture_component.dart';
import 'modules/qc_tester/home/component/qc_tester_home_component.dart';
import 'modules/stock_in_module/components/search_item_component.dart';
import 'modules/stock_in_module/components/stock_in_product_detail_component.dart';

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
      case BarcodeScannerComponent.COMP_KEY:
        return BarcodeScannerComponent(jsonConfig);
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
      case DispatchLotsFilterComponent.COMP_KEY:
        return DispatchLotsFilterComponent(jsonConfig);
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

      case PreDispatchLotsFilterComponent.COMP_KEY:
        return PreDispatchLotsFilterComponent(jsonConfig);

      case PreDispatchComponent.COMP_KEY:
        return PreDispatchComponent(jsonConfig);

      case StoreInLocationScanComponent.COMP_KEY:
        return StoreInLocationScanComponent(jsonConfig);

      default:
        return null;
    }
  }
}
