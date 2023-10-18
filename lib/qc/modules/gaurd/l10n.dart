import 'package:core_widgets/core_widgets.dart';
import 'package:intl/intl.dart';

class L10n extends BaseL10n {
  L10n(super.context);

  String get agent => Intl.message('Agent', locale: localName, name: 'agent');

  String get save => Intl.message('Save', locale: localName, name: 'save');

  String get totalDevices => Intl.message('Total Devices', locale: localName, name: 'totalDevices');

  String get roleGuard => Intl.message('Role Guard', locale: localName, name: 'roleGuard');

  String get addAgentInfo => Intl.message('Add Agent Info', locale: localName, name: 'addAgentInfo');

  String get agentListMustNotBeNullOrEmpty =>
      Intl.message('Agent List Must Not Be Null Or Empty', locale: localName, name: 'agentListMustNotBeNullOrEmpty');

  String get totalDevice => Intl.message('Total Device', locale: localName, name: 'totalDevice');

  String get enterTotalDeviceAgain =>
      Intl.message('Enter total device again.', locale: localName, name: 'enterTotalDeviceAgain');

  String get totalDeviceCountIsNotMatching =>
      Intl.message('Total device count is not matching', locale: localName, name: 'totalDeviceCountIsNotMatching');

  String get ok => Intl.message('Ok', locale: localName, name: 'ok');

  String get cancel => Intl.message('Cancel', locale: localName, name: 'cancel');

  String get totalDeviceCountShouldNotBeZero =>
      Intl.message('Total device count should not be zero', locale: localName, name: 'totalDeviceCountShouldNotBeZero');

  String get pleaseEnterDeviceCount =>
      Intl.message('Please enter device count', locale: localName, name: 'pleaseEnterDeviceCount');
}
