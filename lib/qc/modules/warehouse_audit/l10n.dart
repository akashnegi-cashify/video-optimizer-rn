// coverage:ignore-file
import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

class L10n extends BaseL10n {
  L10n(BuildContext context, {bool listen = true}) : super(context, listen: listen);

  String get auditId => Intl.message('Audit Id', locale: localName, name: 'auditId');

  String get facilityName => Intl.message('Facility Name', locale: localName, name: 'facilityName');

  String get startTime => Intl.message('Start Time', locale: localName, name: 'startTime');

  String get endTime => Intl.message('End Time', locale: localName, name: 'endTime');

  String get emptyAuditList => Intl.message('No Ongoing audit found', locale: localName, name: 'emptyAuditList');
}
