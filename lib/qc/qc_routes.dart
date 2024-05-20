import 'package:flutter/material.dart';
import 'package:flutter_trc/qc/modules/device_details/screens/device_details_screen.dart';
import 'package:flutter_trc/qc/modules/external_audit/external_audit_home_screen.dart';
import 'package:flutter_trc/qc/modules/external_audit/external_audit_perform_screen.dart';
import 'package:flutter_trc/qc/modules/gaurd/screens/guard_device_counting_list_screen.dart';
import 'package:flutter_trc/qc/modules/gaurd/screens/guard_upload_invoice_screen.dart';
import 'package:flutter_trc/qc/modules/gaurd/screens/qc_guard_home_screen.dart';
import 'package:flutter_trc/qc/modules/imei_validator/screens/imei_validator_screen.dart';
import 'package:flutter_trc/qc/modules/qc_tester/audit/screens/audit_barcode_scanner_screen.dart';
import 'package:flutter_trc/qc/modules/qc_tester/audit/screens/audit_question_screen.dart';
import 'package:flutter_trc/qc/modules/qc_tester/audit/screens/audit_question_summary_screen.dart';
import 'package:flutter_trc/qc/modules/qc_tester/calculator/screens/calculation_screen.dart';
import 'package:flutter_trc/qc/modules/qc_tester/calculator/screens/calculator_scanner_screen.dart';
import 'package:flutter_trc/qc/modules/qc_tester/calculator/screens/disputed_questions_screen.dart';
import 'package:flutter_trc/qc/modules/qc_tester/calculator/screens/submit_device_quote_screen.dart';
import 'package:flutter_trc/qc/modules/qc_tester/home/screens/qc_tester_home_screen.dart';
import 'package:flutter_trc/qc/modules/qc_tester/lob_devices/screens/lob_device_scanner_screen.dart';
import 'package:flutter_trc/qc/modules/re_qc/screens/re_qc_detail_screen.dart';
import 'package:flutter_trc/qc/modules/re_qc/screens/re_qc_list_screen.dart';
import 'package:flutter_trc/qc/modules/stock_in_module/screens/media_file_upload_screen.dart';
import 'package:flutter_trc/qc/modules/stock_transfer/screens/pending_dispatch_detail%20screen.dart';
import 'package:flutter_trc/qc/modules/stock_transfer/screens/pending_lot_detail_screen.dart';
import 'package:flutter_trc/qc/modules/stock_transfer/screens/st_store_out_screen.dart';
import 'package:flutter_trc/qc/modules/stock_transfer/screens/stock_transfer_list_screen.dart';
import 'package:flutter_trc/qc/modules/stock_transfer/screens/storage_device_list_screen.dart';
import 'package:flutter_trc/qc/modules/store_in/screens/index.dart';
import 'package:flutter_trc/qc/modules/supervisor/screens/supervisor_screen.dart';
import 'package:flutter_trc/qc/modules/warehouse_audit/screens/on_going_audit_screen.dart';
import 'package:flutter_trc/qc/modules/warehouse_audit/screens/warehouse_audit_perform_screen.dart';
import 'package:flutter_trc/qc/qc_common/lot_type_filters/screens/store_out_lot_filter_screen.dart';
import 'package:flutter_trc/src/common/gallery_screen.dart';
import 'package:flutter_trc/src/common/user/widget/user_profile_screen.dart';
import 'package:flutter_trc/src/common/widgets/dispute_image_editor_screen.dart';

import 'modules/dead_repair/screens/index.dart';
import 'modules/device_receive_module/screens/device_receive_screen.dart';
import 'modules/dispatch_lot/screens/index.dart';
import 'modules/external_audit/widgets/video_recoder_widget.dart';
import 'modules/gaurd/screens/qc_guard_add_agent_screen.dart';
import 'modules/pre_dispatch/screens/index.dart';
import 'modules/qc_actions/qc_action_screen.dart';
import 'modules/qc_tester/calculator_media_capture/calculator_media_capture_screen.dart';
import 'modules/qc_tester/disputed_image_capture/screens/disputed_image_capture_barcode_scanner_screen.dart';
import 'modules/qc_tester/disputed_image_capture/screens/disputed_image_capture_screen.dart';
import 'modules/stock_in_module/screens/index.dart';
import 'modules/store_out/screens/index.dart';

class QcRoutes {
  static Map<String, WidgetBuilder> getQcRoutes() {
    return {
      QcTesterHomeScreen.route: (_) => const QcTesterHomeScreen(),
      QcActionScreen.route: (_) => const QcActionScreen(),
      DeviceReceiveScreen.route: (_) => const DeviceReceiveScreen(),
      CalculationScreen.route: (_) => const CalculationScreen(),
      DisputedQuestionScreen.route: (_) => const DisputedQuestionScreen(),
      AuditQuestionSummaryScreen.route: (_) => const AuditQuestionSummaryScreen(),
      AuditQuestionsScreen.route: (_) => const AuditQuestionsScreen(),
      AuditBarcodeScannerScreen.route: (_) => const AuditBarcodeScannerScreen(),
      CalculatorScannerScreen.route: (_) => const CalculatorScannerScreen(),
      SubmitDeviceQuoteScreen.route: (_) => const SubmitDeviceQuoteScreen(),
      CalculatorMediaCaptureScreen.route: (_) => const CalculatorMediaCaptureScreen(),
      DisputedImageCaptureBarcodeScanner.route: (_) => const DisputedImageCaptureBarcodeScanner(),
      DisputedImageCaptureScreen.route: (_) => const DisputedImageCaptureScreen(),
      LobDeviceScannerScreen.route: (_) => const LobDeviceScannerScreen(),
      DisputeImageEditorScreen.route: (_) => const DisputeImageEditorScreen(),
      VideoRecorderWidget.route: (_) => const VideoRecorderWidget(),
      ExternalAuditHomeScreen.route: (_) => const ExternalAuditHomeScreen(),
      ExternalAuditPerformScreen.route: (_) => const ExternalAuditPerformScreen(),
      SearchItemScreen.route: (_) => const SearchItemScreen(),
      StockInProductDetailScreen.route: (_) => const StockInProductDetailScreen(),
      MediaFileUploadScreen.route: (_) => const MediaFileUploadScreen(),
      DispatchLotScreen.route: (_) => const DispatchLotScreen(),
      InvoiceScanScreen.route: (_) => const InvoiceScanScreen(),
      PreDispatchLotScreen.route: (_) => const PreDispatchLotScreen(),
      ReQcListScreen.route: (_) => const ReQcListScreen(),
      ReQcDetailScreen.route: (_) => const ReQcDetailScreen(),
      StockTransferListScreen.route: (_) => const StockTransferListScreen(),
      StStoreOutScreen.route: (_) => const StStoreOutScreen(),
      PendingLotDetailScreen.route: (_) => const PendingLotDetailScreen(),
      PendingDispatchDetailScreen.route: (_) => const PendingDispatchDetailScreen(),
      PreDispatchScreen.route: (_) => const PreDispatchScreen(),
      StoreInLocationScanScreen.route: (_) => const StoreInLocationScanScreen(),
      QcGuardHomeScreen.route: (_) => const QcGuardHomeScreen(),
      GuardDeviceCountingListScreen.route: (_) => const GuardDeviceCountingListScreen(),
      GuardUploadInvoiceScreen.route: (_) => const GuardUploadInvoiceScreen(),
      StoreOutScreen.route: (_) => const StoreOutScreen(),
      StoreOutLotFilterScreen.route: (_) => const StoreOutLotFilterScreen(),
      LotItemsScanScreen.route: (_) => const LotItemsScanScreen(),
      DeviceDeadRepairScreen.route: (_) => const DeviceDeadRepairScreen(),
      ReasonSelectionScreen.route: (_) => const ReasonSelectionScreen(),
      DeviceDeadAcceptRejectScreen.route: (_) => const DeviceDeadAcceptRejectScreen(),
      QcGuardAddAgentScreen.route: (_) => const QcGuardAddAgentScreen(),
      UserProfileScreen.route: (_) => const UserProfileScreen(),
      SupervisorScreen.route: (_) => const SupervisorScreen(),
      GalleryScreen.route: (_) => const GalleryScreen(),
      OnGoingAuditScreen.route: (_) => const OnGoingAuditScreen(),
      WarehouseAuditPerformScreen.route: (_) => const WarehouseAuditPerformScreen(),
      DeviceDetailsScreen.route: (_) => const DeviceDetailsScreen(),
      StorageDeviceListScreen.route: (_) => const StorageDeviceListScreen(),
      ImeiValidatorScreen.route: (_) => const ImeiValidatorScreen(),
    };
  }
}
