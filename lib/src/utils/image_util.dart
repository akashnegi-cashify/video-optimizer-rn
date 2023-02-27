import 'package:core/core.dart';

import 'device_info_handler.dart';

class ImageUtil {
  static String getImageUrl(String? cdnUrl, String? imagePath, {bool isThumb = false, String folder = 'xhdpi'}) {
    String type = isThumb ? 'thumb' : 'img';
    if (cdnUrl != null && !cdnUrl.endsWith('/')) {
      type = '/$type';
    }
    return '$cdnUrl$type/$folder/$imagePath';
  }

  static String getDensitySpecificUrl(String? baseUrl, String? imageName, String imageFolder, {String? imgUri = ''}) {
    var densityDrawable = DeviceInfoHandler().densityFolder;
    if (imageFolder.isNotEmpty && imageFolder.contains('/')) {
      imageFolder = imageFolder.replaceAll('/', '');
    }
    if (baseUrl == null || baseUrl.isEmpty) {
      Logger.log("tag", "Base url may not be null or empty");
    } else if (imageFolder.isEmpty) {
      if (baseUrl.endsWith('/')) {
        return "$baseUrl$densityDrawable/$imageName";
      } else {
        return "$baseUrl/$densityDrawable/$imageName";
      }
    } else {
      if (baseUrl.endsWith('/')) {
        return "$baseUrl$imageFolder/$densityDrawable/$imageName";
      } else {
        return "$baseUrl/$imageFolder/$densityDrawable/$imageName";
      }
    }
    return "$baseUrl$imgUri$imageFolder/$densityDrawable/$imageName";
  }
}
