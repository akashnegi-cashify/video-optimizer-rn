import 'package:core_widgets/core_widgets.dart';

enum ImageOptimiserGroup with ServiceGroupsMixin {
  imageOptimiser("image-optimizer");

  @override
  final String value;

  const ImageOptimiserGroup(this.value);
}

class ImageOptimizerService extends BaseService {
  final bool isAuthNeeded;

  ImageOptimizerService({this.isAuthNeeded = true});

  @override
  bool isToAddAuthorization() {
    return isAuthNeeded;
  }

  @override
  Map<String, String> getHeaders(bool? isToAddAuth) {
    return {
      ...(isToAddAuth ?? isToAddUserAuth()) ? CoreHeaders.X_USER_AUTH : {},
    "content-type" : "application/x-www-form-urlencoded",
    };
  }

  @override
  ServiceGroupsMixin getServiceGroup() {
    return ImageOptimiserGroup.imageOptimiser;
  }
}
