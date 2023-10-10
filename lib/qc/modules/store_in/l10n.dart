import 'package:core_widgets/core_widgets.dart';
import 'package:intl/intl.dart';

class L10n extends BaseL10n {
  L10n(super.context);

  String get storeIn => Intl.message('Store In', locale: localName, name: 'storeIn');
  String get goBack => Intl.message('GO BACK', locale: localName, name: 'goBack');
  String get scanDevice => Intl.message('SCAN DEVICE', locale: localName, name: 'scanDevice');
}