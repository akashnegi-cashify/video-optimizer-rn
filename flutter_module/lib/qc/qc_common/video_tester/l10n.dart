// coverage:ignore-file
import 'package:core_widgets/core_widgets.dart';
import 'package:intl/intl.dart';

class L10n extends BaseL10n {
  L10n(super.context);

  String get packagingVideo => Intl.message('Packaging video', name: 'packagingVideo', desc: 'Packaging video');

  String get cancel => Intl.message('Cancel', name: 'packagingVideo', desc: 'cancel');

  String get uploadVideo => Intl.message('Upload Video', name: 'uploadVideo', desc: 'Upload Video');
}
