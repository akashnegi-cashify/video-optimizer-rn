import 'package:core_widgets/core_widgets.dart';
import 'package:flutter_trc/src/services/trc_service.dart';
import 'package:flutter_trc/src/utils/media_upload/resource/image_optimiser_service.dart';
import 'package:flutter_trc/src/utils/media_upload/resource/sso_image_optimiser_service.dart';

import '../../../modules/login/resources/login_types.dart';

enum MediaUploadServiceType {
  trc,
  image_optimize,
  oms;

  static MediaUploadServiceType fromLoginType(LoginTypes loginType) {
    switch (loginType) {
      case LoginTypes.trcLogin:
        return MediaUploadServiceType.trc;
      case LoginTypes.shipexLogin:
        return MediaUploadServiceType.oms;
      case LoginTypes.qcLogin:
      default:
        return MediaUploadServiceType.image_optimize;
    }
  }
}

extension MediaUploadServiceExt on MediaUploadServiceType {
  BaseService get service {
    switch (this) {
      case MediaUploadServiceType.trc:
        return ImageOptimizerService();
      case MediaUploadServiceType.image_optimize:
        return ImageOptimizerService();
      case MediaUploadServiceType.oms:
        return SSOImageOptimizerService();
    }
  }
}