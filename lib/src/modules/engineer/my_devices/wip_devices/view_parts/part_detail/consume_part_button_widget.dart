import 'package:core/core.dart';
import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/src/modules/engineer/l10n.dart';
import 'package:flutter_trc/src/modules/engineer/my_devices/wip_devices/models/engineer_part_info.dart';
import 'package:flutter_trc/src/modules/engineer/my_devices/wip_devices/view_parts/part_detail/capture_consume_parts_media_screen.dart';
import 'package:flutter_trc/src/modules/engineer/resources/engineer_api_service.dart';

class ConsumePartButtonWidget extends StatelessWidget {
  final EngineerPartInfo partInfo;
  final VoidCallback? onRequestCompletion;

  const ConsumePartButtonWidget({Key? key, required this.partInfo, this.onRequestCompletion}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    L10n l10n = L10n(context);
    return CshBigOutlineButton(
      text: l10n.consume,
      onPressed: () async {
        try {
          if (Validator.isTrue(partInfo.isService)) {
            _callConsumeApi(context, l10n);
          } else {
            Navigator.pushNamed(
              context,
              CaptureConsumePartsMediaScreen.route,
              arguments: CaptureConsumePartMediaArg(
                partInfo.prId,
                retrievedPartsMediaCount: partInfo.retrievedImageCount,
                onImageUploaded: (urlsMap, retrievedPartBarcode, reason, remarks) {
                  Navigator.pop(context); // Dismiss screen
                  _callConsumeApi(context, l10n,
                      imageUrlsMap: urlsMap,
                      retrievedPartBarcode: retrievedPartBarcode,
                      reasonId: reason?.id,
                      remarks: remarks);
                },
              ),
            );
          }
        } catch (e) {
          CshLoading().hideLoading(context);
          showSnackBar(context, e.toString(), isError: true);
        }
      },
    );
  }

  _callConsumeApi(BuildContext context, L10n l10n,
      {Map<CapturePartMediaType, List<String>>? imageUrlsMap,
      String? retrievedPartBarcode,
      int? reasonId,
      String? remarks}) {
    CshLoading().showLoading(context);
    EngineerAPIService.consumePart(partInfo.partBarcode!, partInfo.partId, partInfo.prId, imageUrlsMap,
            retrievedPartBarcode: retrievedPartBarcode, remarks: remarks, reasonId: reasonId)
        .listen((event) {
      CshLoading().hideLoading(context);
      if (event?.isSuccess == true) {
        if (onRequestCompletion != null) {
          onRequestCompletion!();
        }
        showSnackBar(context, l10n.consumePartSuccess(partInfo.partName));
      } else {
        showSnackBar(context, event?.errorMsg ?? l10n.somethingWentWrong, isError: true);
      }
    }, onError: (error) {
      CshLoading().hideLoading(context);
      String? errorMessage = ApiErrorHelper.getErrorMessage(error);
      showSnackBar(context, errorMessage ?? l10n.somethingWentWrong, isError: true);
    });
  }

  showSnackBar(BuildContext context, String message, {bool isError = false}) {
    ThemeData theme = Theme.of(context);
    CustomColors customTheme = theme.extension<CustomColors>() as CustomColors;
    var backgroundColor = customTheme.successColor;
    if (isError) {
      backgroundColor = theme.colorScheme.error;
    }
    SnackBar snackBar = SnackBar(
      behavior: SnackBarBehavior.floating,
      duration: const Duration(seconds: 3),
      padding: const EdgeInsets.all(Dimens.space_16),
      backgroundColor: backgroundColor,
      margin: EdgeInsets.only(
        bottom: MediaQuery.of(context).size.height - 200,
        left: Dimens.space_8,
        right: Dimens.space_8,
      ),
      dismissDirection: DismissDirection.endToStart,
      content: Text(
        message,
        style: theme.textTheme.titleSmall!.copyWith(color: theme.colorScheme.background),
      ),
    );
    return ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
