import 'package:csh_annotation/annotation.dart';

enum QcComponentGroup with AbsComponentGroup {
  qcTesterHomeComponentKey("Qc Tester Home"),
  qcCalculatorScannerComponentKey("Qc Calculator Scanner"),
  qcSubmitDeviceQuoteComponentKey("Qc Submit Device Quote"),
  qcExternalAuditHomeComponentKey("Qc External Audit Home"),
  qcExternalAuditPerformComponentKey("Qc External Audit Perform"),
  qcReQcListComponentKey("Qc Re Qc List"),
  qcLobDeviceScannerComponentKey("Qc Lob Device Scanner");

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
  qcReQcListPageKey("Qc Re Qc List"),
  qcExternalAuditHomePageKey("Qc External Audit Home");

  @override
  final String value;

  const QcPageGroup(this.value);
}
