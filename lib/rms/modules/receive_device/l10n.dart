import 'package:core_widgets/core_widgets.dart';
import 'package:intl/intl.dart';

class L10n extends BaseL10n {
  L10n(super.context, {super.listen});

  String get receiveDevice => Intl.message("Receive Device", locale: localName, name: "receiveDevice");

  String get createVideo => Intl.message('Create Video', locale: localName, name: 'createVideo');

  String get uploadingVideo => Intl.message('Uploading Video', locale: localName, name: 'uploadingVideo');

  String get videoUploadedSuccessfully => Intl.message('Video uploaded successfully', locale: localName, name: 'videoUploadedSuccessfully');
}
