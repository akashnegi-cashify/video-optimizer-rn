import 'package:core_widgets/core_widgets.dart';

enum TRCServiceGroups with ServiceGroupsMixin {
  qc("qc"),
  trc("trc"),
  supersalesOms("supersales-oms"),
  imageOptimiser("image-optimizer"),
  qcErazer("qc-data-erazer"),
  rms("sales-rms"),
  qcTransferLot("qc-transfer-lot");

  @override
  final String value;

  const TRCServiceGroups(this.value);
}
