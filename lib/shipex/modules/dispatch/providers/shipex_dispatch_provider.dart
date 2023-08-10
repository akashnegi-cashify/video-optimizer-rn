import 'dart:async';
import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:core/core.dart';
import 'package:core_widgets/core_widgets.dart' hide ImageUtil;
import 'package:flutter/material.dart';
import 'package:flutter_trc/src/utils/image_util.dart';
import 'package:flutter_trc/src/utils/media_upload/media_optimiser_utils.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';

import '../models/delivery_partner_list_response.dart';
import '../models/dispatch_awb_scan_response.dart';
import '../resources/dispatch_service.dart';

class ShipexDispatchProvider extends CshChangeNotifier {
  //Delivery Partner properties
  bool deliveryListLoading = false;
  String? deliveryListErrorMessage;
  List<DeliveryPartnerListData>? deliveryPartnerList;
  DeliveryPartnerListData? selectedDeliveryPartner;

  //AWB scanner properties
  List<String> scannedAwbList = [];

  //Dispatch Final step properties
  List<File> listOfInvoicePicture = [];

  static ShipexDispatchProvider of(BuildContext context, {bool listen = true}) {
    return Provider.of<ShipexDispatchProvider>(context, listen: listen);
  }

  //Delivery Partner List methods

  fetchDeliveryPartnerListData() {
    deliveryListLoading = true;
    notifyListeners();
    DispatchService.getDeliveryPartnerList().listen((event) {
      if (!Validator.isListNullOrEmpty(event?.deliveryPartnerList)) {
        deliveryPartnerList = event!.deliveryPartnerList!;
      }
    }, onError: (error) {
      String em = ApiErrorHelper.getErrorMessage(error) ?? "Something went wrong";
      Logger.debug('mydebug------ShipexDispatchProvider.fetchDeliveryPartnerListData', [em]);
      deliveryListErrorMessage = em;
    }, onDone: () {
      deliveryListLoading = false;
      notifyListeners();
    });
  }

  onDeliveryPartnerChanged(DeliveryPartnerListData? partner) {
    selectedDeliveryPartner = partner;
    notifyListeners();
  }

  //Scan AWB number methods
  Future<DispatchAwbScanResponse> checkValidAWBNumber(String number) {
    if (scannedAwbList.contains(number) == true) {
      return Future.error("This awb is already scanned");
    }

    var completer = Completer<DispatchAwbScanResponse>();
    try {
      DispatchService.validateAwbNumber(number, selectedDeliveryPartner?.key ?? "").listen((event) {
        if (event != null && Validator.isTrue(event.isValid)) {
          completer.complete(event);
        } else {
          completer.completeError("Shipment is not in a correct status for dispatch");
        }
      }, onError: (error) {
        String em = ApiErrorHelper.getErrorMessage(error) ?? "Something went wrong";
        Logger.debug('mydebug------ShipexDispatchProvider.checkValidAWBNumber', [em]);
        completer.completeError(em);
      }, onDone: () {
        notifyListeners();
      });
    } catch (e) {
      completer.completeError(e.toString());
    }
    return completer.future;
  }

  addScannedAwbNumber(String awbNumber) {
    scannedAwbList.add(awbNumber);
    notifyListeners();
  }

  removeScannedAwbNumber(String awbNumber) {
    scannedAwbList.removeWhere((element) => element == awbNumber);
    notifyListeners();
  }

  addInvoiceImageFile(File imageFile) {
    ImageUtil.compressImage(imageFile).then((targetFile) {
      listOfInvoicePicture.add(targetFile);
    }, onError: (error) {
      listOfInvoicePicture.add(imageFile);
    }).whenComplete(() => notifyListeners());
  }

  removeInvoiceFile(int index) {
    listOfInvoicePicture.removeAt(index);
    notifyListeners();
  }

  Future<String> _uploadImage(File file) {
    var completer = Completer<String>();
    try {
      String fileName = path.basename(file.path);
      MediaUploadUtil().uploadMedia(mediaFile: file, fileName: fileName).then((value) {
        if (!Validator.isNullOrEmpty(value)) {
          completer.complete(value);
        } else {
          completer.completeError("Something went wrong");
        }
      }, onError: (error) {
        String em = ApiErrorHelper.getErrorMessage(error) ?? "Something went wrong";
        Logger.debug('mydebug------ShipexDispatchProvider.uploadImage', [em]);
        completer.completeError(em);
      });
    } catch (e) {
      completer.completeError(e.toString());
    }
    return completer.future;
  }

  Future<bool> sendPodInPdfOrInCsv({bool? isCsvUpload = false}) {
    var completer = Completer<bool>();
    try {
      DispatchService.sendDispatchProof(scannedAwbList, selectedDeliveryPartner?.key ?? "", isCsv: isCsvUpload ?? false)
          .listen((event) {
        if (event != null && Validator.isTrue(event.isSuccess)) {
          completer.complete(true);
        } else {
          completer.completeError("Something went wrong");
        }
      }, onError: (error) {
        String em = ApiErrorHelper.getErrorMessage(error) ?? "Something went wrong";
        Logger.debug('mydebug------ShipexDispatchProvider.sendPodInPdfOrInCsv', [em]);
        completer.completeError(em);
      }, onDone: () {
        notifyListeners();
      });
    } catch (e) {
      completer.completeError(e.toString());
    }
    return completer.future;
  }

  Future<bool> finishDispatch() async {
    File? combinedFile = await _combineImageIntoOne(listOfInvoicePicture);
    if (combinedFile == null) {
      return Future.error("Failed in image processing, please try again");
    }

    var completer = Completer<bool>();
    try {
      String imageUrl = await _uploadImage(combinedFile);
      DispatchService.completeDispatch(scannedAwbList, imageUrl, selectedDeliveryPartner?.key).listen((event) {
        completer.complete(true);
      }, onError: (error) {
        completer.completeError(ApiErrorHelper.getErrorMessage(error).toString());
      });
    } catch (e) {
      completer.completeError(e.toString());
    }
    return completer.future;
  }

  Future<File?> _combineImageIntoOne(List<File> imgPathList) async {
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
      return saveImageToFile(pngBytes);
    }
    return null;
  }

  void _drawText(ui.Canvas canvas, String text, double x, double y) {
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

  void _drawLine(ui.Canvas canvas, double x1, double y1, double x2, double y2) {
    ui.Paint paint = ui.Paint()
      ..strokeWidth = 3
      ..color = Colors.black;

    canvas.drawLine(Offset(x1, y1), Offset(x2, y2), paint);
  }

  Future<File> saveImageToFile(Uint8List bytes) async {
    final Directory tempDir = await getTemporaryDirectory();
    File outputFile = File('${tempDir.path}/pod.jpeg');
    outputFile.createSync();
    outputFile.writeAsBytesSync(bytes);
    print('Image combined successfully and saved as: ${outputFile.path}');
    return outputFile;
  }
}
