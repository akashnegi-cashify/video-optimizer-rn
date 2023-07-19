import 'package:csh_annotation/annotation.dart';

enum QcComponentGroup with AbsComponentGroup {
  qcTesterHomeComponentKey("Qc Tester Home"),
  qcCalculatorScannerComponentKey("Qc Calculator Scanner"),
  qcSubmitDeviceQuoteComponentKey("Qc Submit Device Quote"),
  qcLobDeviceScannerComponentKey("Qc Lob Device Scanner");

  @override
  final String value;

  const QcComponentGroup(this.value);
}

enum QcPageGroup with AbsPageGroup {
  qcTesterHomePageKey("Qc Tester Home"),
  qcCalculatorScannerPageKey("Qc Calculator Scanner"),
  qcSubmitDeviceQuotePageKey("Qc Submit Device Quote"),
  qcLobDeviceScannerPageKey("Qc Lob Device Scanner");

  @override
  final String value;

  const QcPageGroup(this.value);
}
