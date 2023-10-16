import 'package:intl/intl.dart';
import 'package:localization/index.dart';

class L10n extends BaseL10n {
  L10n(super.context);

  String get elss => Intl.message("ELSS", locale: localName, name: "elss");

  String get deviceTesting => Intl.message("Device Testing", locale: localName, name: "deviceTesting");

  String get externalRecording => Intl.message("External Recording", locale: localName, name: "externalRecording");

  String get stockIn => Intl.message('Stock In', locale: localName, name: 'stockIn');

  String get lotDispatch => Intl.message('Lot Dispatch', locale: localName, name: 'lotDispatch');

  String get reQc => Intl.message("RE-QC", locale: localName, name: "reQc");

  String get stockTransfer => Intl.message("Stock Transfer", locale: localName, name: "stockTransfer");

  String get preDispatch => Intl.message('Pre Dispatch', locale: localName, name: 'preDispatch');

  String get storeIn => Intl.message('Store In', locale: localName, name: 'storeIn');

  String get storeOut => Intl.message('Store Out', locale: localName, name: 'storeOut');
  String get binStoreIn => Intl.message('Bin Store In', locale: localName, name: 'binStoreIn');

  String get receiveDevice => Intl.message('Receive Device', locale: localName, name: 'receiveDevice');
}
