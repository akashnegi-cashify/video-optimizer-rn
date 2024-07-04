import 'package:core_widgets/core_widgets.dart';

enum TRCServiceGroups with ServiceGroupsMixin {
  qc("qc"),
  trc("trc"),
  supersalesOms("supersales-oms"),
  rms("rms");

  @override
  final String value;

  const TRCServiceGroups(this.value);
}
