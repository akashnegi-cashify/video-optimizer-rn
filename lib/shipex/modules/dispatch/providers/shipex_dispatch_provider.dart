import 'dart:async';
import 'dart:io';

import 'package:core/core.dart';
import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/src/utils/media_upload/media_optimiser_utils.dart';
import 'package:path/path.dart' as path;
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
  List<String> scannedAwbNumber = [];

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
    var completer = Completer<DispatchAwbScanResponse>();
    try {
      DispatchService.getCalculator(number, selectedDeliveryPartner?.key ?? "").listen((event) {
        if (event != null && Validator.isTrue(event.isValid)) {
          completer.complete(event);
        } else {
          completer.completeError("Not a valid AWB number");
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
    if (scannedAwbNumber.contains(awbNumber) == false) {
      scannedAwbNumber.add(awbNumber);
    }
    notifyListeners();
  }

  //Final dispatch widget methods
  removeScannedAwbNumber(String awbNumber) {
    scannedAwbNumber.removeWhere((element) => element == awbNumber);
    notifyListeners();
  }

  addInvoiceImageFile(File imageFile) {
    listOfInvoicePicture.add(imageFile);
    notifyListeners();
  }

  removeInvoiceFile(File imageFile) {
    listOfInvoicePicture.removeWhere((element) => element == imageFile);
    notifyListeners();
  }

  Future<String> uploadImage(BuildContext context, File file, {Function(String)? s3UrlCallback}) {
    var completer = Completer<String>();
    try {
      String fileName = path.basename(file.path);
      MediaUploadUtil().uploadMedia(context, mediaFile: file, fileName: fileName).then((value) {
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
      DispatchService.sendDispatchProof(scannedAwbNumber, selectedDeliveryPartner?.key ?? "",
              isCsv: isCsvUpload ?? false)
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
}
