import 'package:core_widgets/core_widgets.dart';
import 'package:intl/intl.dart';

class L10n extends BaseL10n {
  L10n(super.context);

  String get barcode => Intl.message('Barcode', name: 'barcode');

  String get erasureProvider => Intl.message('Erasure Provider', name: 'erasureProvider');


}
