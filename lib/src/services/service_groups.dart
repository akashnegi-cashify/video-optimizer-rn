import 'package:core_widgets/core_widgets.dart';

enum TRCServiceGroups with ServiceGroupsMixin {
  trc("trc");

  @override
  final String value;

  const TRCServiceGroups(this.value);
}
