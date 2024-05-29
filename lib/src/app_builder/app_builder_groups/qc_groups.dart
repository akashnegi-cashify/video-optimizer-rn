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
  qcPreDispatchLotsComponentKey("QC Pre Dispatch Lots Component"),
  qcPreDispatchComponentKey("QC Pre Dispatch Component"),
  qcReQcListComponentKey("Qc Re Qc List"),
  qcStockTransferListComponentKey("Qc Stock Transfer List"),
  qcStockTransferStoreOutComponentKey("Qc Stock Transfer Store Out"),
  qcStockTransferPendingLotDetailComponentKey("Qc Stock Transfer Pending Lot Detail"),
  qcStockTransferPendingDispatchDetailComponentKey("Qc Stock Transfer Pending Dispatch Detail"),
  qcReQcDetailComponentKey("Qc Re Qc Detail"),
  qcPreDispatchLotsFilterComponentKey("QC Pre Dispatch Lots Filter Component"),
  qcStoreOutLotsFilterComponentKey("QC Store Out Lots Filter Component"),
  qcPreDispatchScanResultComponentKey("QC Pre Dispatch Scan Result Component"),
  qcGuardDeviceCountingListComponentKey("QC Pre Dispatch Scan Result Component"),
  qcGuardHomeComponentKey("QC Guard Home Component"),
  qcGuardUploadInvoiceComponentKey("QC Guard Upload Invoice Component"),
  qcGuardAddAgentComponentKey("QC Guard Add Agent Component"),
  qcSupervisorComponentKey("QC Supervisor Device Detail Component"),
  qcOnGoingAuditComponentKey("QC OnGoing Audit Component"),
  qcWarehouseAuditPerformComponentKey("QC Warehouse Audit Perform Component"),
  qcDeviceDetailsComponentKey("QC Device Details Component"),
  qcStorageDeviceListComponentKey("QC Storage Device List Component"),
  qcImeiValidatorComponentKey("QC Imei Validator Component"),
  qcD2cVideoComponentKey("QC D2C Video Component");

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
  qcPreDispatchLot("QC Pre Dispatch Lot"),
  qcPreDispatch("QC Pre Dispatch"),
  qcInvoiceScan("QC Invoice Scan"),
  qcReQcListPageKey("Qc Re Qc List"),
  qcStockTransferListPageKey("Qc Stock Transfer List"),
  qcStockTransferStoreOutPageKey("Qc Stock Transfer Store Out"),
  qcStockTransferPendingLotDetailPageKey("Qc Stock Transfer Pending Lot Detail"),
  qcStockTransferPendingDispatchDetailPageKey("Qc Stock Transfer Pending Dispatch Detail"),
  qcReQcDetailPageKey("Qc Re Qc Detail"),
  qcPreDispatchLotFilter("QC Pre Dispatch Lot Filter"),
  qcStoreOutLotFilterPageKey("QC Store Out Lot Filter"),
  qcStoreOutLotItemsScanPageKey("QC lot Items Scan"),
  qcPreDispatchScanResult("QC Pre Dispatch Scan Result"),
  qcGuardHomePageKey("QC Guard Home"),
  qcGuardDeviceCountingListPageKey("QC Guard Home"),
  qcGuardUploadInvoicePageKey("QC Guard Upload Invoice"),
  qcGuardAddAgentPageKey("QC Guard Add Agent"),
  qcSupervisorPageKey("QC Supervisor Device Detail"),
  qcOnGoingAuditPageKey("QC OnGoing Audit"),
  qcWarehouseAuditPerformPageKey("QC Warehouse Audit Perform"),
  qcDeviceDetailsPageKey("QC Device Details"),
  qcStorageDeviceListPageKey("QC Storage Device List"),
  qcImeiValidatorPageKey("QC Imei Validator"),
  qcD2cVideoPageKey("QC D2C Video");

  @override
  final String value;

  const QcPageGroup(this.value);
}
