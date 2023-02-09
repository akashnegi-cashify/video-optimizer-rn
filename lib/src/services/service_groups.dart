import 'package:core_widgets/core_widgets.dart';

enum TRCServiceGroups with ServiceGroupsMixin {
  qc("qc"),
  trc("trc");

  @override
  final String value;

  const TRCServiceGroups(this.value);
}
