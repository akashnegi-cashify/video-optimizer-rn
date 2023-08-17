import 'dart:async';
import 'dart:io';
import 'dart:ui' as ui;

import 'package:core/core.dart';
import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_trc/src/app_builder/app_headers/qc_general_header/widgets/qc_general_header.dart';
import 'package:path_provider/path_provider.dart';

class SquareMetric {
  final Offset offset;
  Offset? normalizeOffset;
  double height;
  double width;
  double? normalizeWidth;
  double? normalizeHeight;

  SquareMetric(this.offset,
      {this.height = 0, this.width = 0, this.normalizeOffset, this.normalizeWidth, this.normalizeHeight});
}

mixin DisputedImageEditorListener {
  void onImageEditComplete(File editedFile);
}

class DisputeImageEditorScreenArg {
  final File imageFile;
  final DisputedImageEditorListener listener;

  DisputeImageEditorScreenArg(this.imageFile, this.listener);
}

class DisputeImageEditorScreen extends StatefulWidget {
  static String route = "/image_editor";

  const DisputeImageEditorScreen({super.key});

  @override
  DisputeImageEditorScreenState createState() => DisputeImageEditorScreenState();
}

class DisputeImageEditorScreenState extends State<DisputeImageEditorScreen> {
  final List<SquareMetric> _squares = [];
  DisputedImageEditorListener? _listener;

  double _height = 0;
  double _width = 0;
  final _imageWidgetKey = GlobalKey();

  Future<void> _drawSquareOnImage(File imageFile) async {
    CshLoading().showLoading(context);
    Uint8List bytes = imageFile.readAsBytesSync();
    ui.Codec codec = await ui.instantiateImageCodec(bytes);
    ui.FrameInfo frameInfo = await codec.getNextFrame();
    ui.Image image = frameInfo.image;

    final recorder = ui.PictureRecorder();
    final canvas = Canvas(recorder);
    canvas.drawImage(image, Offset.zero, Paint());
    final paint = Paint()
      ..color = Colors.red
      ..style = PaintingStyle.stroke
      ..strokeWidth = 5;

    for (final square in _squares) {
      var normalizeOffset = square.normalizeOffset!;
      canvas.drawRect(
          Rect.fromLTWH(normalizeOffset.dx * image.width, normalizeOffset.dy * image.height,
              square.normalizeWidth! * image.width, square.normalizeHeight! * image.height),
          paint);
    }

    final picture = recorder.endRecording();
    final ui.Image modifiedImage = await picture.toImage(image.width, image.height);

    ByteData? byteData = await modifiedImage.toByteData(format: ui.ImageByteFormat.png);

    if (byteData != null) {
      Uint8List pngBytes = byteData.buffer.asUint8List();
      var file = await _saveImageToFile(pngBytes);
      if (mounted) CshLoading().hideLoading(context);
      _sendFileToListener(file);
    }
  }

  _sendFileToListener(File file) {
    _listener?.onImageEditComplete(file);
    Navigator.pop(context);
    // showCshBottomSheet(
    //     context: context,
    //     child: Container(
    //       child: Image.file(file),
    //     ));
  }

  @override
  void initState() {
    scheduleMicrotask(() {
      setState(() {
        _height = MediaQuery.of(context).size.height * 0.7;
        _width = MediaQuery.of(context).size.width;
      });
    });

    // Future.delayed(
    //   const Duration(seconds: 2),
    //   () {
    //     var size = _imageWidgetKey.currentContext?.size;
    //
    //     Logger.debug('mydebug-----DisputeImageEditorScreenState.initState', [size?.height, size?.width]);
    //
    //     if (size == null) return;
    //
    //     setState(() {
    //       _width = size.width;
    //       _height = size.height;
    //     });
    //   },
    // );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    DisputeImageEditorScreenArg? arg = ModalRoute.of(context)?.settings.arguments as DisputeImageEditorScreenArg?;
    assert(arg != null);
    _listener ??= arg!.listener;
    return Scaffold(
      appBar: const QcGeneralHeader("Image Editing"),
      body: Column(
        children: [
          Stack(
            children: [
              SizedBox(
                  height: _height,
                  width: _width,
                  child: Image.file(key: _imageWidgetKey, arg!.imageFile, fit: BoxFit.fitHeight)),
              SizedBox(
                height: _height,
                width: _width,
                child: ClipRect(
                  child: CustomPaint(
                    painter: SquarePainter(_squares),
                    child: GestureDetector(
                      onTapDown: (details) {
                        setState(() {
                          var squareMetric = SquareMetric(details.localPosition);
                          squareMetric.normalizeOffset =
                              Offset(details.localPosition.dx / _width, details.localPosition.dy / _height);
                          _squares.add(squareMetric);
                        });
                      },
                      onPanUpdate: (details) {
                        var lastSquareMetric = _squares.last;
                        var currentOffset = details.localPosition;
                        lastSquareMetric.width = currentOffset.dx - lastSquareMetric.offset.dx;
                        lastSquareMetric.height = currentOffset.dy - lastSquareMetric.offset.dy;

                        lastSquareMetric.normalizeWidth = lastSquareMetric.width / _width;
                        lastSquareMetric.normalizeHeight = lastSquareMetric.height / _height;
                        setState(() {});
                      },
                      onPanEnd: (details) async {
                        var lastSquareMetric = _squares.last;
                        // if (lastSquareMetric.height < 10 || lastSquareMetric.width < 10) {
                        //   _squares.removeLast();
                        // }
                        // setState(() {});
                      },
                      child: Container(color: Colors.black12),
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: Dimens.space_16),
          ComboButton(
            firstBtnText: "Undo",
            secondBtnText: "Proceed",
            buttonType: ButtonType.big,
            firstBtnClick: _squares.isNotEmpty
                ? () {
                    setState(() {
                      _squares.removeLast();
                    });
                  }
                : null,
            secondBtnClick: () {
              if (_squares.isEmpty) {
                _sendFileToListener(arg.imageFile);
              } else {
                _drawSquareOnImage(arg.imageFile);
              }
            },
          )
        ],
      ),
    );
  }

  Future<File> _saveImageToFile(Uint8List bytes) async {
    final Directory tempDir = await getTemporaryDirectory();
    File outputFile = File('${tempDir.path}/${DateTime.now().millisecondsSinceEpoch}.jpeg');
    outputFile.createSync();
    outputFile.writeAsBytesSync(bytes);
    print('Image combined successfully and saved as: ${outputFile.path}');
    return outputFile;
  }

  @override
  void dispose() {
    Logger.debug('mydebug-----DisputeImageEditorScreenState.dispose', []);
    super.dispose();
  }

}

class SquarePainter extends CustomPainter {
  final List<SquareMetric> squares;

  SquarePainter(this.squares);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.red
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;

    for (final square in squares) {
      canvas.drawRect(Rect.fromLTWH(square.offset.dx, square.offset.dy, square.width, square.height), paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
