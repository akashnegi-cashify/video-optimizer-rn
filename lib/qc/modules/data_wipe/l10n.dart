import 'package:core_widgets/core_widgets.dart';
import 'package:intl/intl.dart';

class L10n extends BaseL10n {
  L10n(super.context, {super.listen = true});

  String get barcode => Intl.message('Barcode', name: 'barcode');

  String get erasureProvider => Intl.message('Erasure Provider', name: 'erasureProvider');

  String get initiateDataWipe => Intl.message('Initiate Data Wipe', name: 'initiateDataWipe');

  String get scanAnother => Intl.message('Scan Another', name: 'scanAnother');

  String get goBack => Intl.message('Go Back', name: 'goBack');

  String get filters => Intl.message('Filters', name: 'filters');

  String get initiateBulk => Intl.message('Initiate Bulk', name: 'initiateBulk');

  String get sreYouSure => Intl.message('Are you sure?', name: 'sreYouSure');

  String get proceed => Intl.message('Proceed', name: 'proceed');

  String erasedDesc(String status) {
    return Intl.message("Initiate Bulk Erase on $status status", name: 'erasedDesc', args: [status]);
  }



}
