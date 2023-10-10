import 'package:core_widgets/core_widgets.dart';
import 'package:intl/intl.dart';

class L10n extends BaseL10n {
  L10n(super.context);

  String get pending => Intl.message('Pending', locale: localName, name: 'pending');

  String get dispatchPending => Intl.message('Dispatch Pending', locale: localName, name: 'dispatchPending');

  String get storeOut => Intl.message('Store Out', locale: localName, name: 'storeOut');

}