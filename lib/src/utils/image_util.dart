import 'dart:async';
import 'dart:io';

import 'package:components/common/image_compress_utils.dart';
import 'package:core/core.dart';
import 'package:path_provider/path_provider.dart';

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

  static Future<File> compressImage(File file, {int quality = 100}) async {
    Logger.debug('mydebug-----ImageUtil.compressImage current file', [(file.lengthSync() / (1024 * 1024)), file.path]);
    var completer = Completer<File>();
    var fileName = '${DateTime.now().millisecondsSinceEpoch}.jpg';
    var rootDir = await getTemporaryDirectory();
    final targetFile = await File('${rootDir.path}/$fileName').create();
    try {
      await ImageCompressUtils.compressAndSaveFile(file, targetFile, quality: quality);
      Logger.debug(
          'mydebug--ImageUtil.compressImage-target file', [(targetFile.lengthSync() / (1024 * 1024)), targetFile.path]);
      completer.complete(targetFile);
    } catch (e) {
      Logger.debug('mydebug-----ImageUtil.compressImage---error', [e]);
      completer.completeError(e.toString());
    }
    return completer.future;
  }
}
