import 'package:core/core.dart';
import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/src/modules/laptop_analyzer/resources/analyzer_status_type.dart';
import 'package:flutter_trc/src/modules/laptop_analyzer/resources/laptop_analyzer_service.dart';

import '../resources/analyzer_device_response.dart';

class AnalyzerDeviceWidget extends StatelessWidget {
  final AnalyzerDevice? item;
  final int index;
  final VoidCallback? onItemClick;
  final VoidCallback? onActionComplete;

  const AnalyzerDeviceWidget({
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
                    text: "Paint Shop",
                    onPressed: () => _confirmAndUpdate(context, AnalyzerStatusType.paintShop),
                  ),
                ),
                const SizedBox(width: Dimens.space_8),
                Expanded(
                  child: CshMediumButton(
                    text: "Body Shop",
                    onPressed: () => _confirmAndUpdate(context, AnalyzerStatusType.bodyShop),
                  ),
                ),
                const SizedBox(width: Dimens.space_8),
                Expanded(
                  child: CshMediumOutlineButton(
                    text: "Dismantle",
                    onPressed: () => _confirmAndUpdate(context, AnalyzerStatusType.dismantling),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _confirmAndUpdate(BuildContext context, AnalyzerStatusType statusType) {
    showDialog(
      context: context,
      useRootNavigator: false,
      builder: (dialogContext) {
        return AlertDialog(
          title: CshTextNew.subTitle1("Confirm"),
          content: CshTextNew.h4("Are you sure you want to send this device to ${statusType.label}?"),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogContext),
              child: CshTextNew.h4("Cancel"),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(dialogContext);
                _callUpdateStatus(context, statusType);
              },
              child: CshTextNew.h4("Proceed"),
            ),
          ],
        );
      },
    );
  }

  void _callUpdateStatus(BuildContext context, AnalyzerStatusType statusType) {
    final deviceId = item?.deviceId;
    if (deviceId == null) return;

    CshLoading().showLoading(context);
    LaptopAnalyzerService.updateStatus(deviceId, statusType).listen((event) {
      if (context.mounted) {
        CshLoading().hideLoading(context);
        if (event != null && event.isSuccess) {
          CshSnackBar.success(context: context, message: event.successMessage ?? "Device updated successfully");
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
