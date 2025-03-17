import 'dart:async';
import 'dart:typed_data';

import 'package:camera/camera.dart';
import 'package:core/core.dart';
import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/src/common/widgets/imei_scanner.dart';
import 'package:image/image.dart' as imglib;
// import 'package:image_labeling_detector/image_labeling_detector.dart';
import 'package:imei_serial_reader/imei_serial_reader.dart';

import '../src/app_builder/app_headers/qc_general_header/widgets/qc_general_header.dart';

class Temp extends StatefulWidget {
  const Temp({super.key});

  @override
  State<Temp> createState() => _TempState();
}

class _TempState extends State<Temp> {
  bool isBusy = false;
  CameraImage? cameraImage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const QcGeneralHeader('Temp'),
      body: Center(
        child: Column(
          children: [
            CshBigButton(
              text: "Get Values",
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(
                  builder: (_) {
                    return ImeiScanner(
                      config: ParserConfig(
                          readerType: ReaderType.imeiReader,
                          // imageDetector: ImageLabelingDetector(),
                          isExecuteImageDetector: true,
                          objectsToDetect: ["mobile", "telephone"]),
                      onProceed: (List<String>? scannedList, {CameraDataModel? imageRawData}) {
                        if (!isBusy) {
                          isBusy = true;
                          Navigator.pop(context);
                          Future.delayed(
                            Duration(seconds: 1),
                            () {
                              Logger.debug('mydebug-----_TempState.build', [scannedList, imageRawData]);
                              setState(() {
                                isBusy = false;
                                cameraImage = imageRawData?.imageRawData;
                              });
                            },
                          );
                        }
                      },
                      // onTimeOut: () => _onScanningTimeout(readerType),
                    );
                  },
                ));
              },
            ),
            if (cameraImage != null)
              FutureBuilder(
                future: convertYUV420toImageColor(cameraImage!),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done && snapshot.hasData) {
                    // Display the image using RawImage
                    return Image.memory(snapshot.data as Uint8List);
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error loading image'));
                  }
                  return Center(child: CircularProgressIndicator());
                },
              ),
          ],
        ),
      ),
    );
  }

  Future<Uint8List?> convertYUV420toImageColor(CameraImage image) async {
    final format = InputImageFormatValue.fromRawValue(image.format.raw);
    Logger.debug('mydebug-----_TempState.convertYUV420toImageColor', [image.format]);
    try {
      final int width = image.width;
      final int height = image.height;
      final int uvRowStride = image.planes[1].bytesPerRow;
      final int uvPixelStride = image.planes[1].bytesPerPixel ?? 1;

      // imgLib -> Image package from https://pub.dartlang.org/packages/image
      var img = imglib.Image(width: width, height: height); // Create Image buffer

      // Fill image buffer with plane[0] from YUV420_888
      for (int x = 0; x < width; x++) {
        for (int y = 0; y < height; y++) {
          final int uvIndex = uvPixelStride * (x / 2).floor() + uvRowStride * (y / 2).floor();
          final int index = y * width + x;

          final yp = image.planes[0].bytes[index];
          final up = image.planes[1].bytes[uvIndex];
          final vp = image.planes[2].bytes[uvIndex];
          // Calculate pixel color
          int r = (yp + vp * 1436 / 1024 - 179).round().clamp(0, 255);
          int g = (yp - up * 46549 / 131072 + 44 - vp * 93604 / 131072 + 91).round().clamp(0, 255);
          int b = (yp + up * 1814 / 1024 - 227).round().clamp(0, 255);
        }
      }

      imglib.PngEncoder pngEncoder = imglib.PngEncoder(level: 0, filter: imglib.PngFilter.paeth);
      List<int> png = pngEncoder.encode(img);

      return Uint8List.fromList(png);
    } catch (e) {
      print(">>>>>>>>>>>> ERROR:$e");
    }
    return null;
  }
}

enum InputImageFormat {
  nv21,
  yv12,
  yuv_420_888,
  yuv420,
  bgra8888,
}

extension InputImageFormatValue on InputImageFormat {
  // source: https://developers.google.com/android/reference/com/google/mlkit/vision/common/InputImage#constants
  int get rawValue {
    switch (this) {
      case InputImageFormat.nv21:
        return 17;
      case InputImageFormat.yv12:
        return 842094169;
      case InputImageFormat.yuv_420_888:
        return 35;
      case InputImageFormat.yuv420:
        return 875704438;
      case InputImageFormat.bgra8888:
        return 1111970369;
    }
  }

  static InputImageFormat? fromRawValue(int rawValue) {
    try {
      return InputImageFormat.values.firstWhere((element) => element.rawValue == rawValue);
    } catch (_) {
      return null;
    }
  }
}
