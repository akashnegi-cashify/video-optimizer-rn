import 'package:core_widgets/core_widgets.dart';
import 'package:intl/intl.dart';

class L10n extends BaseL10n {
  L10n(super.context);

  String get deviceDeadRepair => Intl.message('Device Dead/Repair', locale: localName, name: 'deviceDeadRepair');

  String get markDead => Intl.message('Mark Dead', locale: localName, name: 'markDead');

  String get accpetRejectDead => Intl.message('Accpet/Reject Dead', locale: localName, name: 'accpetRejectDead');

  String get deadDevice => Intl.message('Dead Device', locale: localName, name: 'deadDevice');

  String get acceptRejectDeadRemark =>
      Intl.message('Accept/Reject Dead Remark', locale: localName, name: 'acceptRejectDeadRemark');

  String get repairPartSkUs => Intl.message('Repair Part SKUs', locale: localName, name: 'repairPartSkUs');

  String get partSkUs => Intl.message('Part SKUs', locale: localName, name: 'partSkUs');

  String get scan => Intl.message('+ Scan', locale: localName, name: 'scan');

  String get scanOneByOneSkus => Intl.message('Scan One By One SKUs', locale: localName, name: 'scanOneByOneSkus');

  String get add => Intl.message('+ Add', locale: localName, name: 'add');

  String get remarks => Intl.message('Remarks', locale: localName, name: 'remarks');

  String get acceptDead => Intl.message('ACCEPT DEAD', locale: localName, name: 'acceptDead');

  String get repairDone => Intl.message('REPAIR DONE', locale: localName, name: 'repairDone');

  String get repairReject => Intl.message('REPAIR REJECT', locale: localName, name: 'repairReject');

  String markDeadWithoutSku(String barcode) {
    return Intl.message('Not added any SKU against device $barcode Do you still want to continue?',
        locale: localName, name: 'markDeadWithoutSku');
  }

  String get yes => Intl.message('Yes', locale: localName, name: 'yes');
  String get no => Intl.message('No', locale: localName, name: 'no');
  String get alert => Intl.message('Alert', locale: localName, name: 'alert');
  String get markRepair => Intl.message('Mark Repair', locale: localName, name: 'markRepair');
  String get next => Intl.message('Next', locale: localName, name: 'next');
  String get repair => Intl.message('Repair', locale: localName, name: 'repair');
  String get dead => Intl.message('Dead', locale: localName, name: 'dead');
  String get pleaseSelectAReason => Intl.message('Please select a reason', locale: localName, name: 'pleaseSelectAReason');
  String get success => Intl.message('Success', locale: localName, name: 'success');
  String get somethingWentWrong => Intl.message('Something Went Wrong', locale: localName, name: 'somethingWentWrong');
  String get update => Intl.message('Update', locale: localName, name: 'update');
}
