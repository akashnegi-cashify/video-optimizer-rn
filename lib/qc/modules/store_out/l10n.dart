import 'package:core_widgets/core_widgets.dart';
import 'package:intl/intl.dart';

class L10n extends BaseL10n {
  L10n(super.context, {super.listen = true});

  String get lotList => Intl.message('LOT LIST', locale: localName, name: 'lotList');

  String get binList => Intl.message('BIN LIST', locale: localName, name: 'binList');

  String get binOut => Intl.message('BIN OUT', locale: localName, name: 'binOut');

  String get apply => Intl.message('Apply', locale: localName, name: 'apply');

  String get clear => Intl.message('Clear', locale: localName, name: 'clear');

  String get storeOutLots => Intl.message('Store Out Lots', locale: localName, name: 'storeOutLots');

  String get binOutSuccessfully => Intl.message('Bin Out Successfully', locale: localName, name: 'binOutSuccessfully');

  String get pleaseScanDeviceBarcode =>
      Intl.message('Please Scan Device Barcode', locale: localName, name: 'pleaseScanDeviceBarcode');

  String get pleaseScanLocationBarcode =>
      Intl.message('Please Scan Location Barcode', locale: localName, name: 'pleaseScanLocationBarcode');

  String get scan => Intl.message('Scan', locale: localName, name: 'scan');

  String get barCode => Intl.message('BarCode : ', locale: localName, name: 'barCode');

  String get location => Intl.message('Location : ', locale: localName, name: 'location');

  String get barcodeMismatchNTryAgain =>
      Intl.message('Barcode Mismatch\nTry again!', locale: localName, name: 'barcodeMismatchNTryAgain');

  String get skip => Intl.message('Skip', locale: localName, name: 'skip');

  String get somethingWentWrong => Intl.message('Something Went Wrong.', locale: localName, name: 'somethingWentWrong');

  String get lotName => Intl.message('Lot Name : ', locale: localName, name: 'lotName');

  String get groupName => Intl.message('Group Name : ', locale: localName, name: 'groupName');

  String get noOfDevices => Intl.message('No. Of Devices : ', locale: localName, name: 'noOfDevices');

  String get id => Intl.message('Id: ', locale: localName, name: 'id');

  String get lotType => Intl.message('Lot Type : ', locale: localName, name: 'lotType');

  String get productTitle => Intl.message('Product Title', locale: localName, name: 'productTitle');

  String get lotOutSuccessfully => Intl.message('Lot Out Successfully', locale: localName, name: 'lotOutSuccessfully');

  String get warning => Intl.message('Warning', locale: localName, name: 'warning');

  String get storeOutAlreadyInProcess => Intl.message('Store out already in process', locale: localName, name: 'storeOutAlreadyInProcess');

  String get doYouWantToProceed => Intl.message('Do you want to proceed', locale: localName, name: 'doYouWantToProceed');

  String get cancel => Intl.message('Cancel', locale: localName, name: 'cancel');

  String get proceed => Intl.message('Proceed', locale: localName, name: 'proceed');

  String get inProcessLot => Intl.message('In Process Lot', locale: localName, name: 'inProcessLot');
}
