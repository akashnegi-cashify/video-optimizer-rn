import 'package:core_widgets/core_widgets.dart';
import 'package:flutter_trc/src/services/trc_service.dart';
import 'package:flutter_trc/src/utils/media_upload/resource/image_optimiser_service.dart';
import 'package:flutter_trc/src/utils/media_upload/resource/sso_image_optimiser_service.dart';

import '../../../modules/login/resources/login_types.dart';

enum ImageUploadServiceType {
  trc,
  image_optimize,
  oms;

  static ImageUploadServiceType fromLoginType(LoginTypes loginType) {
    switch (loginType) {
      case LoginTypes.trcLogin:
        return ImageUploadServiceType.trc;
      case LoginTypes.shipexLogin:
        return ImageUploadServiceType.oms;
      case LoginTypes.qcLogin:
      default:
        return ImageUploadServiceType.image_optimize;
    }
  }
}

extension ImageUploadServiceExt on ImageUploadServiceType {
  BaseService get service {
    switch (this) {
      case ImageUploadServiceType.trc:
        return TrcService();
      case ImageUploadServiceType.image_optimize:
        return ImageOptimizerService();
      case ImageUploadServiceType.oms:
        return SSOImageOptimizerService();
    }
  }
}