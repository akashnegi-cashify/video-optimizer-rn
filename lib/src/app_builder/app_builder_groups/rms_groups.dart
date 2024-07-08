import 'package:csh_annotation/annotation.dart';

enum RmsComponentGroup with AbsComponentGroup {
  rmsHomeComponent("RMS Home Component");

  @override
  final String value;

  const RmsComponentGroup(this.value);
}

enum RmsPageGroup with AbsPageGroup {
  rmsHomePageKey("RMS Home Page");

  @override
  final String value;

  const RmsPageGroup(this.value);
}
