import 'dart:async';
import 'dart:io';

import 'package:core_widgets/core_widgets.dart' hide ImageUtil;
import 'package:flutter/material.dart';
import 'package:flutter_trc/qc/modules/gaurd/resources/guard_service.dart';
import 'package:flutter_trc/src/utils/image_util.dart';
import 'package:flutter_trc/src/utils/media_upload/media_optimiser_utils.dart';
import 'package:path/path.dart' as path;
import 'package:provider/provider.dart';

class UploadInvoiceProvider extends CshChangeNotifier {
  List<File>? invoiceList;

  static UploadInvoiceProvider of(BuildContext context, {bool listen = true}) {
    return Provider.of<UploadInvoiceProvider>(context, listen: listen);
  }

  Future<void> submitInvoice() async {
    var completer = Completer<void>();
    ImageUtil.combineImageIntoOne(invoiceList!).then((file) {
      _uploadImage(file!).then((imageUrl) {
        GuardService.submitInvoice("", 0, imageUrl).listen((event) {
          completer.complete();
        }, onError: (error) {
          completer.completeError(ApiErrorHelper.getErrorMessage(error).toString());
        });
      }, onError: (error) {
        completer.completeError(error);
      });
    }, onError: (error) {
      completer.completeError(error);
    });
    return completer.future;
  }

  void addInvoiceImage(File invoiceFile) {
    invoiceList ??= [];
    invoiceList!.add(invoiceFile);
    notifyListeners();
  }

  Future<String> _uploadImage(File file) async {
    var completer = Completer<String>();
    var compressedFile = await ImageUtil.compressImage(file);
    String fileName = path.basename(compressedFile.path);
    MediaUploadUtil().uploadMediaWithType(mediaFile: compressedFile, fileName: fileName).then((imageUrl) {
      if (!Validator.isNullOrEmpty(imageUrl)) {
        completer.complete(imageUrl);
      } else {
        completer.completeError("Something went wrong");
      }
    }, onError: (error) {
      completer.completeError(error);
    });
    return completer.future;
  }
}
