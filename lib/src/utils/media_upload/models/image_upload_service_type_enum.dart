import 'package:core_widgets/core_widgets.dart';
import 'package:flutter_trc/src/services/trc_service.dart';
import 'package:flutter_trc/src/utils/media_upload/image_optimiser_service.dart';

enum ImageUploadServiceType {
  trc,
  image_optimize;
}

extension ImageUploadServiceExt on ImageUploadServiceType {
  BaseService get service {
    switch (this) {
      case ImageUploadServiceType.trc:
        return TrcService();
      case ImageUploadServiceType.image_optimize:
        return ImageOptimizerService();
    }
  }
}