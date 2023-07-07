import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

import 'package:core/core.dart';
import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';


import 'dart:ui' as ui;

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

  static Future<File?> combineImageIntoOne(List<File> imgPathList) async {
    if (imgPathList.length == 1) {
      return Future.value(imgPathList.first);
    }
    List<ui.Image> images = [];
    int w = 0;
    int h = 0;

    // Load images
    for (File file in imgPathList) {
      if (file.existsSync()) {
        Uint8List bytes = file.readAsBytesSync();
        ui.Codec codec = await ui.instantiateImageCodec(bytes);
        ui.FrameInfo frameInfo = await codec.getNextFrame();
        ui.Image image = frameInfo.image;
        images.add(image);

        w = images.length > 1 ? w = images[0].width : image.width;
        h += image.height;
        h += 15;
      }
    }

    // Create canvas and draw images
    ui.PictureRecorder recorder = ui.PictureRecorder();
    ui.Canvas canvas = ui.Canvas(recorder);
    canvas.drawColor(Colors.white, BlendMode.color);

    double top = 0;
    int bitmapHeight = 0;
    for (int i = 0; i < images.length; i++) {
      ui.Image image = images[i];
      top = i == 0 ? 0 : top + bitmapHeight + 15;
      canvas.drawImage(image, Offset(0, top).scale(1, 1), Paint());
      _drawText(canvas, "${i + 1}", 80 - 10.0, top + image.height - 80 + 10.0);

      if (i > 0) {
        _drawLine(canvas, 0.0, top - 15 / 2, image.width.toDouble(), top - 15 / 2);
      }
      bitmapHeight = image.height;
    }

    // Convert to PNG and save into a file
    ui.Picture picture = recorder.endRecording();
    ui.Image image = await picture.toImage(w, h);
    ByteData? byteData = await image.toByteData(format: ui.ImageByteFormat.png);

    if (byteData != null) {
      Uint8List pngBytes = byteData.buffer.asUint8List();
      return _saveImageToFile(pngBytes);
    }
    return null;
  }

  static void _drawText(ui.Canvas canvas, String text, double x, double y) {
    TextPainter painter = TextPainter(
      text: TextSpan(
        text: text,
        style: const TextStyle(color: Colors.blue, fontSize: 40),
      ),
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr,
    );

    painter.layout();
    painter.paint(canvas, Offset(x, y));
  }

  static void _drawLine(ui.Canvas canvas, double x1, double y1, double x2, double y2) {
    ui.Paint paint = ui.Paint()
      ..strokeWidth = 3
      ..color = Colors.black;

    canvas.drawLine(Offset(x1, y1), Offset(x2, y2), paint);
  }

  static Future<File> _saveImageToFile(Uint8List bytes) async {
    final Directory tempDir = await getTemporaryDirectory();
    File outputFile = File('${tempDir.path}/pod.jpeg');
    outputFile.createSync();
    outputFile.writeAsBytesSync(bytes);
    print('Image combined successfully and saved as: ${outputFile.path}');
    return outputFile;
  }
}
