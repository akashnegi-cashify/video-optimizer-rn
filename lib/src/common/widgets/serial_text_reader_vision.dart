import 'dart:io';

import 'package:camera/camera.dart';
import 'package:core/core.dart';
import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:imei_serial_reader/l10n.dart';
import 'package:imei_serial_reader/reader_type.dart';
import 'package:path_provider/path_provider.dart';
import 'package:text_recognizer/csh_text_recognition.dart';

class SerialTextVisionWidget extends StatefulWidget {
  final Function(
    List<String>?,
  )? imeiReaderCallback;
  final Function(
    List<String>,
  )? serialReaderCallback;
  final ReaderType readerType;

  const SerialTextVisionWidget({
    required super.key,
    required this.readerType,
    this.serialReaderCallback,
    this.imeiReaderCallback,
  });

  @override
  State<SerialTextVisionWidget> createState() => SerialTextVisionWidgetState();
}

class SerialTextVisionWidgetState extends State<SerialTextVisionWidget> {
  CameraController? _controller;

  // String serialNumberPath = "assets/images/serial_sample_image.png";

  // String serialNumberPath = "assets/images/type_2.png";

  // String serialNumberPath = "assets/images/type_3.png";
  String serialNumberPath = "assets/images/type_4.jpg";

  RegExp imeiRegex = RegExp(r'(.)*([0-9]{15,16})(.)*');

  // RegExp serialNumberRegex = RegExp(r'(?=.*[0-9])(?=.*[a-zA-Z])([a-zA-Z0-9]{8,16})');
  RegExp serialNumberRegex = RegExp(r"(?:serialnumber[:?]*)([A-Za-z0-9]{8,})");

  // Additional validation to ensure it contains both letters and numbers
  RegExp mustContainLetterAndNumber = RegExp(r"^(?=.*[A-Za-z])(?=.*\d)[A-Za-z0-9]+$");

  bool isReading = true;
  String? _errorDescription;

  late final TextRecognizer _textRecognizer;
  late L10n l10n;
  late bool isStreaming;
  String? _extractedSerialNumber;

  @override
  void initState() {
    super.initState();
    isStreaming = false;

    _textRecognizer = TextRecognizer();
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Column(
      children: [
        Image.asset(serialNumberPath),
        SizedBox(height: 16),
        CshBigButton(
            text: "Get Serial Number",
            onPressed: () {
              _getSerialNumber();
            }),
        SizedBox(height: 16),
        if (!Validator.isNullOrEmpty(_extractedSerialNumber))
          CshTextNew.subTitle1(_extractedSerialNumber!.toUpperCase())
      ],
    );
  }

  _getSerialNumber() async {
    var file = await getImageFileFromAssets(serialNumberPath);
    _imageProcessor(InputImage.fromFile(file));
  }

  _startTextRecognition() {
    if (isStreaming) return;
    isStreaming = true;
    _controller?.initialize().then((value) {
      if (mounted) {
        if (_controller?.value.isStreamingImages == false) {
          _controller?.startImageStream(_processCameraImage);
          setState(() {
            isStreaming = false;
          });
        }
      }
    }, onError: (error) {
      if (error is CameraException) {
        if (mounted) {
          _errorDescription = error.description;
        }
      } else {
        if (mounted) {
          _errorDescription = l10n.somethingWentWrong;
        }
      }
      setState(() {
        isStreaming = false;
      });
    });
  }

  _stopRecognition() async {
    if (_controller != null) {
      await _controller!.stopImageStream();
      await _controller!.dispose();
      _controller = null;
    }
  }

  Future _processCameraImage(CameraImage image) async {
    if (isReading) {
      isReading = false;

      final WriteBuffer allBytes = WriteBuffer();

      for (final Plane plane in image.planes) {
        allBytes.putUint8List(plane.bytes);
      }
      final bytes = allBytes.done().buffer.asUint8List();

      final Size imageSize = Size(image.width.toDouble(), image.height.toDouble());

      // final camera = widget.firstCamera;
      //
      // final imageRotation = InputImageRotationValue.fromRawValue(camera.sensorOrientation);
      // if (imageRotation == null) return;
      //
      // final inputImageFormat = InputImageFormatValue.fromRawValue(image.format.raw);
      // if (inputImageFormat == null) return;
      //
      // final plane = image.planes.first;
      //
      // final inputImageData = InputImageMetadata(
      //   size: imageSize,
      //   rotation: imageRotation,
      //   format: inputImageFormat,
      //   bytesPerRow: plane.bytesPerRow,
      // );
      //
      // final inputImage = InputImage.fromBytes(bytes: bytes, metadata: inputImageData);
      //
      // _imageProcessor(inputImage);
    }
  }

  Future<File> getImageFileFromAssets(String path) async {
    final directory = await getTemporaryDirectory();
    final filePath = '${directory.path}/temp_image.png';
    final byteData = await rootBundle.load(path);
    final file = File(filePath);
    await file.writeAsBytes(byteData.buffer.asUint8List());
    return file;
  }

  Future<void> _imageProcessor(InputImage inputImage) async {
    List<String> blockTextList = [];
    Set<String> scannedIMEIs = {};
    Set<String> scannedSerialNumbers = {};
    List<String> scannedIMEIResult = [];
    List<String> scannedSerialResult = [];
    final recognizedText = await _textRecognizer.processImage(inputImage);
    Logger.debug('mydebug-----SerialTextVisionWidgetState._imageProcessor recognizedText', [recognizedText]);
    isReading = true;
    // if (inputImage.metadata?.size != null && inputImage.metadata?.rotation != null) {
    String lastBlock = "";
    for (TextBlock block in recognizedText.blocks) {
      var dataString = block.text.trim();
      dataString = dataString.replaceAll(" ", "");
      dataString = dataString.toLowerCase();
      if (widget.readerType == ReaderType.imeiReader) {
        if (imeiRegex.hasMatch(dataString) && !blockTextList.any((element) => element == dataString)) {
          blockTextList.add(dataString);
        }
      } else {
        if (lastBlock.contains("serialnumber")) {
          dataString = lastBlock + dataString;
        }
        var match = serialNumberRegex.firstMatch(dataString);
        if (match != null) {
          String? serialNumber = match.group(1);
          if (serialNumber != null && mustContainLetterAndNumber.hasMatch(serialNumber)) {
            setState(() {
              _extractedSerialNumber = serialNumber;
            });
            break;
          }
        } else {
          Logger.debug('mydebug-----SerialTextVisionWidgetState._imageProcessor matched not matched');
        }
        // if (serialNumberRegex.hasMatch(dataString) && !blockTextList.any((element) => element == dataString)) {
        //   blockTextList.add(dataString);
        // }
      }
      lastBlock = dataString;
    }
    if (blockTextList.isNotEmpty) {
      String combinedData = blockTextList.join("\n");
      Logger.debug('mydebug-----SerialTextVisionWidgetState._imageProcessor', [combinedData]);
      // if (widget.readerType == ReaderType.serialNumberReader) {
      //   scannedSerialNumbers = _generateSerialFromBlocks(combinedData);
      // } else {
      //   scannedIMEIs = _generateIMEIFromBlocks(combinedData);
      // }
    }
    // }
    // if (mounted) {
    //   if (scannedIMEIs.isNotEmpty) {
    //     scannedIMEIResult.clear();
    //     for (var element in scannedIMEIs) {
    //       scannedIMEIResult.add(element);
    //     }
    //     if (widget.imeiReaderCallback != null) {
    //       widget.imeiReaderCallback!(scannedIMEIResult.toList());
    //     }
    //     // _controller?.pausePreview();
    //   } else {
    //     if (scannedSerialNumbers.isNotEmpty) {
    //       scannedSerialResult.clear();
    //       for (var element in scannedSerialNumbers) {
    //         scannedSerialResult.add(element);
    //       }
    //       if (widget.serialReaderCallback != null) {
    //         widget.serialReaderCallback!(scannedSerialResult);
    //       }
    //       // _controller?.pausePreview();
    //     }
    //   }
    //
    //   // setState(() {});
    // }
  }

  Set<String> _generateIMEIFromBlocks(String dataString) {
    Set<String> result = {};
    Iterable<RegExpMatch> allMatches = imeiRegex.allMatches(dataString);
    for (Match match in allMatches) {
      for (int i = 0; i < match.groupCount; i++) {
        if (match[i] != null && isValidIMEI(match[i]!)) {
          var imei = match[i]!.trim();
          result.add(imei);
        }
      }
    }
    return result;
  }

  Set<String> _generateSerialFromBlocks(String dataString) {
    Set<String> result = {};
    Iterable<RegExpMatch> allMatches = serialNumberRegex.allMatches(dataString);
    for (Match match in allMatches) {
      for (int k = 0; k < match.groupCount; k++) {
        if (match[k] != null) {
          result.add(match[k]!.trim());
        }
      }
    }
    return result;
  }

  bool isValidIMEI(String numberString) {
    int anyNumber;
    try {
      anyNumber = int.parse(numberString);
    } catch (e) {
      return false;
    }
    int len = numberString.length;
    if (len != 15) return false;

    int sum = 0;
    for (int i = len; i >= 1; i--) {
      int d = (anyNumber % 10);

      // Doubling every alternate digit
      if (i % 2 == 0) d = 2 * d;

      // Finding sum of the digits
      sum += sumDig(d);
      anyNumber = anyNumber ~/ 10;
    }

    return (sum % 10 == 0);
  }

  int sumDig(int number) {
    int a = 0;
    while (number > 0) {
      a = a + number % 10;
      number = number ~/ 10;
    }
    return a;
  }

  @override
  void dispose() {
    _stopRecognition();
    super.dispose();
  }

  //Retry method to start scanning again.
  resetVisionScreen() {
    if (_controller?.value.isInitialized == true) {
      if (_controller?.value.isStreamingImages == true) {
        _controller?.stopImageStream();
      }

      // _controller = CameraController(
      //   widget.firstCamera,
      //   ResolutionPreset.high,
      //   enableAudio: false,
      // );
      setState(() {});
      _startTextRecognition();
    }
  }
}
