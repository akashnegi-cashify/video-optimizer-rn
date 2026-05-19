// coverage:ignore-file
import 'package:core_widgets/core_widgets.dart';
import 'package:intl/intl.dart';

class L10n extends BaseL10n {
  L10n(super.context, {super.listen = true});

  String get genericDeviceMedia => Intl.message('Generic Device Media', locale: localName, name: 'genericDeviceMedia');

  String get pendingVideoLot => Intl.message('Pending Video Lot', locale: localName, name: 'pendingVideoLot');
}
