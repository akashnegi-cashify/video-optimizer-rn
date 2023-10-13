import 'package:csh_annotation/annotation.dart';

enum QcComponentGroup with AbsComponentGroup {
  qcTesterHomeComponentKey("Qc Tester Home"),
  qcCalculatorScannerComponentKey("Qc Calculator Scanner"),
  qcSubmitDeviceQuoteComponentKey("Qc Submit Device Quote"),
  qcExternalAuditHomeComponentKey("Qc External Audit Home"),
  qcExternalAuditPerformComponentKey("Qc External Audit Perform"),
  qcLobDeviceScannerComponentKey("Qc Lob Device Scanner"),
  qcSearchItemComponentKey("Qc Search Item"),
  qcMediaFileUploadComponentKey("Qc Media File Upload"),
  qcStockInProductDetailComponentKey("Qc Stock In Product Detail"),
  qcDispatchLotsComponentKey("QC Dispatch Lots Component"),
  qcDispatchLotsFilterComponentKey("QC Dispatch Lots Filter Component"),
  qcInvoiceScanComponentKey("Qc Invoice Scan Component"),
  qcReQcListComponentKey("Qc Re Qc List"),
  qcStockTransferListComponentKey("Qc Stock Transfer List"),
  qcStockTransferStoreOutComponentKey("Qc Stock Transfer Store Out"),
  qcStockTransferPendingLotDetailComponentKey("Qc Stock Transfer Pending Lot Detail"),
  qcStockTransferPendingDispatchDetailComponentKey("Qc Stock Transfer Pending Dispatch Detail"),
  qcReQcDetailComponentKey("Qc Re Qc Detail");

  @override
  final String value;

  const QcComponentGroup(this.value);
}

enum QcPageGroup with AbsPageGroup {
  qcTesterHomePageKey("Qc Tester Home"),
  qcCalculatorScannerPageKey("Qc Calculator Scanner"),
  qcSubmitDeviceQuotePageKey("Qc Submit Device Quote"),
  qcLobDeviceScannerPageKey("Qc Lob Device Scanner"),
  qcExternalAuditPerformPageKey("Qc External Audit Perform"),
  qcExternalAuditHomePageKey("Qc External Audit Home"),
  qcSearchItemPageKey("Qc Search Item"),
  qcMediaFileUploadPageKey("Qc Media File Upload"),
  qcStockInProductDetailPageKey("Qc Stock In Product Detail"),
  qcDispatchLotFilter("QC Dispatch Lot Filter"),
  qcDispatchLot("QC Dispatch Lot"),
  qcInvoiceScan("QC Invoice Scan"),
  qcReQcListPageKey("Qc Re Qc List"),
  qcStockTransferListPageKey("Qc Stock Transfer List"),
  qcStockTransferStoreOutPageKey("Qc Stock Transfer Store Out"),
  qcStockTransferPendingLotDetailPageKey("Qc Stock Transfer Pending Lot Detail"),
  qcStockTransferPendingDispatchDetailPageKey("Qc Stock Transfer Pending Dispatch Detail"),
  qcReQcDetailPageKey("Qc Re Qc Detail");

  @override
  final String value;

  const QcPageGroup(this.value);
}
