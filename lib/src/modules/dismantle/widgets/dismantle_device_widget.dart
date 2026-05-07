import 'package:core/core.dart';
import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/src/common/mark_to_tl/mark_to_tl_dialog.dart';
import 'package:flutter_trc/src/modules/dismantle/screens/part_barcode_attach_screen.dart';
import 'package:flutter_trc/src/modules/paint_shop/resources/paint_shop_service.dart';

import '../resources/dismantle_device_response.dart';

class DismantleDeviceWidget extends StatelessWidget {
  final DismantleDevice? item;
  final int index;
  final VoidCallback? onItemClick;
  final VoidCallback? onActionComplete;

  const DismantleDeviceWidget({
    super.key,
    required this.index,
    this.item,
    this.onItemClick,
    this.onActionComplete,
  });

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return cshGestureDetector(
      onTap: onItemClick,
      child: CshCard(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            CshTextNew(
              '#${index + 1}   ${item?.deviceBarcode ?? ''}',
              textStyle: theme.textTheme.headlineMedium?.copyWith(color: theme.primaryColor),
            ),
            const SizedBox(height: Dimens.space_12),
            Flexible(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(child: CshTextNew.h4("Model", isPrimary: false)),
                  Expanded(child: CshTextNew.h4(item?.model ?? '-')),
                ],
              ),
            ),
            const SizedBox(height: Dimens.space_6),
            Flexible(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(child: CshTextNew.h4("Status", isPrimary: false)),
                  Expanded(child: CshTextNew.h4(item?.statusDescription ?? '-')),
                ],
              ),
            ),
            const SizedBox(height: Dimens.space_6),
            Flexible(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(child: CshTextNew.h4("Engineer", isPrimary: false)),
                  Expanded(child: CshTextNew.h4(item?.engineer ?? '-')),
                ],
              ),
            ),
            const SizedBox(height: Dimens.space_16),
            Row(
              children: [
                Expanded(
                  child: CshMediumButton(
                    text: "Mark Ok",
                    onPressed: () => _onMarkOk(context),
                  ),
                ),
                const SizedBox(width: Dimens.space_12),
                Expanded(
                  child: CshMediumOutlineButton(
                    text: "Mark To TL",
                    onPressed: () => _onMarkToTl(context),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _onMarkOk(BuildContext context) async {
    final barcode = item?.deviceBarcode;
    if (barcode == null) return;

    final result = await Navigator.push<bool>(
      context,
      MaterialPageRoute(builder: (_) => PartBarcodeAttachScreen(deviceBarcode: barcode)),
    );

    if (result == true) {
      onActionComplete?.call();
    }
  }

  void _onMarkToTl(BuildContext context) async {
    final reason = await showMarkToTlDialog(context);
    if (reason == null || !context.mounted) return;

    final barcode = item?.deviceBarcode;
    if (barcode == null) return;

    CshLoading().showLoading(context);
    PaintShopService.markDevice(barcode, false, reasonId: reason.id).listen((event) {
      if (context.mounted) {
        CshLoading().hideLoading(context);
        if (event != null && event.isSuccess) {
          CshSnackBar.success(context: context, message: event.successMessage ?? "Device sent to TL");
          onActionComplete?.call();
        } else {
          CshSnackBar.error(
            context: context,
            message: event?.errorMsg ?? "Something went wrong",
            snackBarPosition: SnackBarPosition.TOP,
          );
        }
      }
    }, onError: (error) {
      if (context.mounted) {
        CshLoading().hideLoading(context);
        String errorMessage = ApiErrorHelper.getErrorMessage(error) ?? "Something went wrong";
        CshSnackBar.error(context: context, message: errorMessage);
      }
    });
  }
}
