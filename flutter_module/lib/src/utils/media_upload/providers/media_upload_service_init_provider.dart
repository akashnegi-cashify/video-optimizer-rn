import 'package:core_widgets/core_widgets.dart';
import 'package:flutter_trc/src/libraries/shared_preferences/app_preferences.dart';
import 'package:flutter_trc/src/modules/login/resources/login_types.dart';
import 'package:flutter_trc/src/utils/media_upload/models/media_upload_service_type_enum.dart';

abstract class MediaUploadServiceInitProvider extends CshChangeNotifier {
  late final BaseService mediaUploadService;

  MediaUploadServiceInitProvider() {
    _initMediaService();
  }

  void _initMediaService() {
    var loginType = AppPreferences.app.getLoginType();
    var loginTypeEnum = LoginTypes.fromValue(loginType ?? "");
    mediaUploadService = MediaUploadServiceType.fromLoginType(loginTypeEnum).service;
  }
}
