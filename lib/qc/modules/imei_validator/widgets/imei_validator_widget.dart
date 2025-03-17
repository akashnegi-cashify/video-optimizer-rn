import 'dart:async';

import 'package:camera/camera.dart';
import 'package:core/core.dart';
import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/qc/modules/imei_validator/resources/imei_qrcode_response.dart';
import 'package:flutter_trc/qc/modules/imei_validator/resources/imei_validator_service.dart';
import 'package:flutter_trc/src/common/widgets/imei_scanner.dart';
import 'package:imei_serial_reader/imei_serial_reader.dart';
import 'package:rxdart/rxdart.dart';

import '../l10n.dart';

class ImeiValidatorWidget extends StatefulWidget {
  final ImeiQrcodeResponse? imeiQrcodeResponse;

  const ImeiValidatorWidget(this.imeiQrcodeResponse, {super.key});

  @override
  State<ImeiValidatorWidget> createState() => _ImeiValidatorWidgetState();
}

class _ImeiValidatorWidgetState extends State<ImeiValidatorWidget> {
  bool? _isImei1Matched;
  bool? _isImei2Matched;
  List<String>? _scannedList;
  StreamController<List<String>?> throttleController = StreamController();

  @override
  void initState() {
    throttleController.stream.throttleTime(const Duration(milliseconds: 1500)).listen((event) {
      List<String>? scannedList = event;
      // if (_isAllImeiScanned(scannedList)) {
      if (!Validator.isListNullOrEmpty(scannedList)) {
        _scannedList = scannedList!;
        if (!Validator.isNullOrEmpty(widget.imeiQrcodeResponse?.imei1)) {
          _isImei1Matched = _isImeiMatched(scannedList, widget.imeiQrcodeResponse!.imei1!);
        }

        if (!Validator.isNullOrEmpty(widget.imeiQrcodeResponse?.imei2)) {
          _isImei2Matched = _isImeiMatched(scannedList, widget.imeiQrcodeResponse!.imei2!);
        }
        Navigator.pop(context);
        setState(() {});
      }
    });
    super.initState();
  }

  bool _isAllImeiScanned(List<String>? scannedList) {
    if (Validator.isListNullOrEmpty(scannedList)) {
      return false;
    }

    if (widget.imeiQrcodeResponse?.imei1 != null) {
      if (widget.imeiQrcodeResponse?.imei2 != null) {
        return scannedList!.length >= 2;
      } else {
        return scannedList!.length >= 1;
      }
    } else {
      return false;
    }
  }

  _scanImei() {
    Navigator.push(context, MaterialPageRoute(
      builder: (_) {
        return ImeiScanner(
          config: ParserConfig(readerType: ReaderType.imeiReader),
          onProceed: (List<String>? scannedList, {CameraImage? imageRawData}) {
            throttleController.add(scannedList);
          },
        );
      },
    ));
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var l10n = L10n(context);
    return Container(
      padding: const EdgeInsets.all(Dimens.space_16),
      child: CshCard(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CshTextNew.subTitle1(l10n.deviceDetails),
            const Divider(),
            const SizedBox(height: Dimens.space_12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                    flex: 2, fit: FlexFit.tight, child: CshTextNew.subTitle2("${l10n.awbNumber}:", isPrimary: false)),
                Flexible(
                  flex: 3,
                  fit: FlexFit.tight,
                  child: CshTextNew.subTitle2(widget.imeiQrcodeResponse?.awbNumber ?? "NA"),
                ),
              ],
            ),
            Container(
              padding: const EdgeInsets.symmetric(vertical: Dimens.space_6),
              margin: const EdgeInsets.only(top: Dimens.space_12),
              decoration: _isImei1Matched != null
                  ? BoxDecoration(border: Border.all(color: _isImei1Matched! ? Colors.green : Colors.red))
                  : null,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                      flex: 2, fit: FlexFit.tight, child: CshTextNew.subTitle2("${l10n.imei1}:", isPrimary: false)),
                  Flexible(
                    flex: 3,
                    fit: FlexFit.tight,
                    child: CshTextNew.subTitle2(widget.imeiQrcodeResponse?.imei1 ?? "NA"),
                  ),
                ],
              ),
            ),
            if (_isImei1Matched != null)
              Text(
                _isImei1Matched! ? l10n.imei1Matched : l10n.imei1Mismatched,
                style: theme.primaryTextTheme.bodySmall?.copyWith(
                  color: !_isImei1Matched! ? theme.colorScheme.error : null,
                ),
              ),
            Container(
              padding: const EdgeInsets.symmetric(vertical: Dimens.space_6),
              margin: const EdgeInsets.only(top: Dimens.space_12),
              decoration: _isImei2Matched != null
                  ? BoxDecoration(border: Border.all(color: _isImei2Matched! ? Colors.green : Colors.red))
                  : null,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                      flex: 2, fit: FlexFit.tight, child: CshTextNew.subTitle2("${l10n.imei2}:", isPrimary: false)),
                  Flexible(
                    flex: 3,
                    fit: FlexFit.tight,
                    child: CshTextNew.subTitle2(widget.imeiQrcodeResponse?.imei2 ?? "NA"),
                  ),
                ],
              ),
            ),
            if (_isImei2Matched != null)
              Text(
                _isImei2Matched! ? l10n.imei2Matched : l10n.imei2Mismatched,
                style: theme.primaryTextTheme.bodySmall?.copyWith(
                  color: !_isImei2Matched! ? theme.colorScheme.error : null,
                ),
              ),
            const SizedBox(height: Dimens.space_12),
            if (!Validator.isListNullOrEmpty(_scannedList))
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Flexible(
                    flex: 2,
                    fit: FlexFit.tight,
                    child: CshTextNew.subTitle2("${l10n.scannedImei}:", isPrimary: false),
                  ),
                  Flexible(flex: 3, fit: FlexFit.tight, child: CshTextNew.subTitle2(_scannedList?.join(", ") ?? "NA")),
                ],
              ),
            const SizedBox(height: Dimens.space_12),
            // Imei 1 is mandatory for IMEI Validation
            if (Validator.isListNullOrEmpty(_scannedList) && !Validator.isNullOrEmpty(widget.imeiQrcodeResponse?.imei1))
              SizedBox(
                width: double.infinity,
                child: CshMediumOutlineButton(text: l10n.scanImei, onPressed: () => _scanImei()),
              ),
            const SizedBox(height: Dimens.space_12),
            if (!Validator.isListNullOrEmpty(_scannedList))
              SizedBox(
                width: double.infinity,
                child: CshMediumOutlineButton(text: l10n.reScan, onPressed: () => _scanImei()),
              ),
            const SizedBox(height: Dimens.space_12),
            if (!Validator.isListNullOrEmpty(_scannedList))
              SizedBox(
                width: double.infinity,
                child: CshMediumButton(text: l10n.completeValidation, onPressed: () => _onValidationComplete()),
              ),
          ],
        ),
      ),
    );
  }

  _onValidationComplete() {
    CshLoading().showLoading(context);
    ImeiValidatorService.completeValidation(widget.imeiQrcodeResponse?.awbNumber, _isImei1Matched, _isImei2Matched)
        .listen((event) {
      CshLoading().hideLoading(context);
      Navigator.pop(context); // dismiss this screen
      CshSnackBar.success(context: context, message: "Validation Completed");
    }, onError: (error) {
      CshLoading().hideLoading(context);
      CshSnackBar.error(context: context, message: ApiErrorHelper.getErrorMessage(error).toString());
    });
  }

  bool _isImeiMatched(List<String> scannedList, String imei) {
    return scannedList.contains(imei);
  }
}
