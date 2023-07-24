import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

class LogoutActionWidget extends StatelessWidget {
  const LogoutActionWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return GestureDetector(
      onTap: () async {
        // bool? loginFromShipex = await AppPreferences().getIsLoginFromShipex();
        // if (Validator.isTrue(loginFromShipex)) {
        //   AppPreferences().resetAndClearAll();
        //   Navigator.of(context).pushNamedAndRemoveUntil(TrcAndQcLoginScreen.route, (route) => false);
        // } else {
        //   UserUtil.applicationLogout(context);
        // }

        final ImagePicker picker = ImagePicker();
        var filex1 = await picker.pickImage(source: ImageSource.camera);
        var file = File(filex1!.path);

        var filex2 = await picker.pickImage(source: ImageSource.camera);
        var file2 = File(filex2!.path);

        var filex3 = await picker.pickImage(source: ImageSource.camera);
        var file3 = File(filex3!.path);
        // final Directory tempDir = await getTemporaryDirectory();
        // File outputFile = File('${tempDir.path}/pod.png');
        // outputFile.createSync();
        await combineImageIntoOne([file, file2, file3], context);
        // _showImage(outputFile, context);
      },
      child: CshIcon(
        FeatherIcons.logOut,
        iconSize: MobileIconSize.medium,
        padding: EdgeInsets.zero,
        iconColor: theme.primaryColor,
      ),
    );
  }

  _showImage(File file, BuildContext context) {
    showCshBottomSheet(
      context: context,
      child: Column(
        children: [
          Image.file(
            file,
            height: 300,
            width: 300,
          )
        ],
      ),
    );
  }

  Future<void> combineImageIntoOne(List<File> imgPathList, BuildContext context) async {
    List<ui.Image> images = [];
    int w = 0;
    int h = 0;

    // Load images
    for (File file in imgPathList) {
      // File file = File(imagePath);
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

      drawText(canvas, "${i + 1}", 80 - 10.0, top + image.height - 80 + 10.0);

      if (i > 0) {
        drawLine(canvas, 0.0, top - 15 / 2, image.width.toDouble(), top - 15 / 2);
      }
      bitmapHeight = image.height;
    }

    // Convert to PNG and save into a file
    ui.Picture picture = recorder.endRecording();
    ui.Image image = await picture.toImage(w, h);
    ByteData? byteData = await image.toByteData(format: ui.ImageByteFormat.png);

    if (byteData != null) {
      Uint8List pngBytes = byteData.buffer.asUint8List();
      saveImageToFile(pngBytes, context);
    }
  }

  void drawText(ui.Canvas canvas, String text, double x, double y) {
    TextPainter painter = TextPainter(
      text: TextSpan(
        text: text,
        style: TextStyle(color: Colors.blue, fontSize: 40),
      ),
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr,
    );

    painter.layout();
    painter.paint(canvas, Offset(x, y));
  }

  void drawLine(ui.Canvas canvas, double x1, double y1, double x2, double y2) {
    ui.Paint paint = ui.Paint()
      ..strokeWidth = 3
      ..color = Colors.black;

    canvas.drawLine(Offset(x1, y1), Offset(x2, y2), paint);
  }

  void saveImageToFile(Uint8List bytes, BuildContext context) async {
    final Directory tempDir = await getTemporaryDirectory();
    File outputFile = File('${tempDir.path}/pod.png');
    outputFile.createSync();
    outputFile.writeAsBytesSync(bytes);
    print('Image combined successfully and saved as: ${outputFile.path}');
    _showImage(outputFile, context);
  }
}
