// coverage:ignore-file
import 'package:core_widgets/core_widgets.dart';
import 'package:intl/intl.dart';

class L10n extends BaseL10n {
  L10n(super.context);
  String get pixelTesting => Intl.message('Pixel Testing', locale: localName, name: 'pixelTesting');

}
