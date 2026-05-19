// coverage:ignore-file
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

  String get repairDevice => Intl.message('Repair Device', locale: localName, name: 'repairDevice');

  String get deadDevice => Intl.message('Dead Device', locale: localName, name: 'deadDevice');

  String get deviceRepairDead => Intl.message('Device Repair/Dead', locale: localName, name: 'deviceRepairDead');

  String get receiveDevice => Intl.message('Receive Device', locale: localName, name: 'receiveDevice');

  String get supervision => Intl.message('Supervision', locale: localName, name: 'supervision');

  String get guardRole => Intl.message('Guard Role', locale: localName, name: 'guardRole');

  String get scanDeviceBarcode => Intl.message('Scan Device Barcode', locale: localName, name: 'scanDeviceBarcode');

  String get warehouseAudit => Intl.message('Warehouse Audit', locale: localName, name: 'warehouseAudit');

  String get deviceDetails => Intl.message('Device Details', locale: localName, name: 'deviceDetails');

  String get imeiValidator => Intl.message('IMEI Validator', locale: localName, name: 'imeiValidator');

  String get genericDeviceMedia => Intl.message('Generic Device Media', locale: localName, name: 'genericDeviceMedia');

  String get dataWipe => Intl.message('Data Wipe', locale: localName, name: 'dataWipe');

  String get dataWipeList => Intl.message('Data Wipe List', locale: localName, name: 'dataWipeList');

}
