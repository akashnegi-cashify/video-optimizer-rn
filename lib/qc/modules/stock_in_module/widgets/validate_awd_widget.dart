import 'package:core/core.dart';
import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:ml_barcode_scanner/widgets/index.dart';
import 'package:provider/provider.dart';
import '../../qc_tester/disputed_image_capture/screens/disputed_image_capture_barcode_scanner_screen.dart';
import '../l10n.dart';
import '../models/validate_awb_response.dart';
import '../providers/validate_awd_provider.dart';
import '../resources/stock_in_service.dart';
import '../screens/index.dart';
import 'index.dart';

class ValidateAwdWidget extends StatelessWidget {
  const ValidateAwdWidget({super.key});

  @override
  Widget build(BuildContext context) {
    var l10n = L10n(context);

    return ChangeNotifierProvider(
      create: (BuildContext context) => ValidateAwdProvider(),
      child: Builder(builder: (builderContext) {
        var provider = ValidateAwdProvider.of(builderContext);
        return Padding(
          padding: const EdgeInsets.all(Dimens.space_16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  LabeledTextField(
                    controller: provider.awdNumberTextEditingController,
                    hintText: l10n.enterAwbNumber,
                    label: l10n.awbNo,
                    suffixIcon: CshIcon(
                      FeatherIcons.camera,
                      onClick: () => _launchScanner(builderContext, provider.awdNumberTextEditingController),
                    ),
                  ),
                  const SizedBox(height: Dimens.space_8),
                  LabeledTextField(
                    controller: provider.barCodeTextEditingController,
                    hintText: l10n.enterInternalBarcode,
                    label: l10n.internalBarcode,
                    suffixIcon: CshIcon(
                      FeatherIcons.camera,
                      onClick: () => _launchScanner(builderContext, provider.barCodeTextEditingController),
                    ),
                  ),
                ],
              ),
              CshBigButton(
                text: l10n.submit,
                onPressed: () => _onSubmit(builderContext),
              )
            ],
          ),
        );
      }),
    );
  }

  void _onSubmit(BuildContext context) {
    var provider = ValidateAwdProvider.of(context, listen: false);
    var awdNumber = provider.awdNumberTextEditingController.text;
    var barCode = provider.barCodeTextEditingController.text;

    if (isEmpty(awdNumber)) {
      CshSnackBar.error(context: context, message: 'Please enter awb number.');
    } else if (isEmpty(barCode)) {
      CshSnackBar.error(context: context, message: 'Please enter internal barcode');
    } else {
      CshLoading().showLoading(context);

      StockInService.validateAwb(awdNumber, barCode).listen((event) {
        CshLoading().hideLoading(context);
        _navigateToProductDetail(context,event);

      }, onError: (error) => _onError(context, error));
    }
  }

  void _launchScanner(BuildContext context, TextEditingController textController) {
    DisputedImageCaptureBarcodeScannerArguments args = DisputedImageCaptureBarcodeScannerArguments(
        onScanDetected: (String scannedData, MlScannerController? controller) {
      if (scannedData.isNotEmpty) {
        Navigator.pop(context); // pop scanner screen
        textController.text = scannedData.trim();
      }
    });
    Navigator.of(context).pushNamed(DisputedImageCaptureBarcodeScanner.route, arguments: args);
  }

  void _onError(BuildContext context, dynamic error) {
    CshLoading().hideLoading(context);
    var errorMsg = ApiErrorHelper.getErrorMessage(error);
    Logger.debug('ValidateAwdWidget._onSubmit', [error]);
    if (isNotEmpty(errorMsg)) {
      CshSnackBar.error(context: context, message: errorMsg!);
    }
  }

  void _navigateToProductDetail(BuildContext context,ValidateAwbResponse? awbResponse){
    StockInProductDetailScreen.navigate(context,arguments: awbResponse);
  }
}
