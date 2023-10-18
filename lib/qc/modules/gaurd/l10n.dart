import 'package:core_widgets/core_widgets.dart';
import 'package:intl/intl.dart';

class L10n extends BaseL10n {
  L10n(super.context);

  String get agent => Intl.message('Agent', locale: localName, name: 'agent');
  String get save => Intl.message('Save', locale: localName, name: 'save');
  String get totalDevices => Intl.message('Total Devices', locale: localName, name: 'totalDevices');
  String get roleGuard => Intl.message('Role Guard', locale: localName, name: 'roleGuard');
  String get agentListMustNotBeNullOrEmpty => Intl.message('Agent List Must Not Be Null Or Empty', locale: localName, name: 'agentListMustNotBeNullOrEmpty');
}