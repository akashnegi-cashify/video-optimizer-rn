import 'dart:async';
import 'dart:io';

import 'package:core/core.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:path/path.dart';
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

  static Future<File> compressImage(File file, {int quality = 90}) async {
    var completer = Completer<File>();
    Logger.debug('mydebug-----ImageUtil.compressImage Original file', [(file.lengthSync() / (1024 * 1024)), file.path]);

    // Im.Image? image = Im.decodeImage(readAsBytesSync());
    // Logger.debug('mydebug-----convertToWebP original File', [
    //   (lengthSync() / (1024 * 1024)),
    //   image?.height,
    //   image?.width,
    //   path,
    // ]);

    var targetPath = join((await getTemporaryDirectory()).path, ("${DateTime.now().millisecondsSinceEpoch}.webp"));

    FlutterImageCompress.compressAndGetFile(file.path, targetPath,
            quality: quality, keepExif: false, format: CompressFormat.webp, minWidth: 1200)
        .then((compressedXFile) {
      if (compressedXFile != null) {
        var compressedFile = File(compressedXFile.path);
        // Im.Image? comImage = Im.decodeImage(compressedFile.readAsBytesSync());
        Logger.debug('mydebug--compressed---convertToWebP Compressed File', [
          (compressedFile.lengthSync() / (1024 * 1024)),
          // comImage?.height,
          // comImage?.width,
          compressedXFile.path,
        ]);
        completer.complete(compressedFile);
      } else {
        completer.complete(file);
      }
    }, onError: (error) {
      Logger.debug('mydebug-----ImageUtil.compressImage', [error]);
      completer.complete(file);
    });

    return completer.future;
  }
}
