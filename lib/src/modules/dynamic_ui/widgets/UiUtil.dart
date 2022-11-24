import 'package:core_widgets/core_widgets.dart';
class UiUtils {
  static ColSpan calculateColSpan({int? colSpan, int divider = 3}) {
    int span = (colSpan ?? 0) ~/ divider;

    switch (span) {
      case 0:
      case 1:
        return ColSpan.column_1;

      case 2:
        return ColSpan.column_2;

      default:
        return ColSpan.column_2;
    }
  }
}
