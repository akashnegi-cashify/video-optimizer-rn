import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/qc/modules/stock_in_module/providers/stock_in_provider.dart';
import 'package:flutter_trc/qc/modules/stock_in_module/screens/media_file_upload_screen.dart';
import 'package:provider/provider.dart';

import '../models/awb_selection_request.dart';
import '../models/stock_in_sumit_request.dart';
import '../models/validate_awb_response.dart';
import '../l10n.dart';
import '../screens/stock_in_screen.dart';
import '../types.dart';
import 'index.dart';

class StockInProductDetailWidget extends StatelessWidget {
  final ValidateAwbResponse? stockInProductDetail;
  final String? barCode;
  final String? awbNumber;

  const StockInProductDetailWidget({
    super.key,
    this.stockInProductDetail,
    this.awbNumber,
    this.barCode,
  });

  @override
  Widget build(BuildContext context) {
    var l10n = L10n(context);
    var theme = Theme.of(context);
    return ChangeNotifierProvider(
      create: (context) => StockInProvider(stockInProductDetail),
      child: Builder(builder: (builderContext) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  ProductInfoWidget(
                    sourceName: stockInProductDetail?.sourceName,
                    product: stockInProductDetail?.product,
                    brand: stockInProductDetail?.brand,
                    imei1: stockInProductDetail?.imei1,
                    imei2: stockInProductDetail?.imei2,
                  ),
                  const SizedBox(
                    height: Dimens.space_8,
                  ),
                  Expanded(child: ProductValidatingGrpWidget(validatingGrp: stockInProductDetail?.groups))
                ],
              ),
            ),
            CshCard(
              padding: const EdgeInsets.all(Dimens.space_12),
              child: Selector<StockInProvider, bool>(
                builder: (BuildContext context, value, Widget? child) {
                  return CshBigButton(
                    text: l10n.submit,
                    bgColor: value ? theme.colorScheme.error : theme.primaryColor,
                    onPressed: () => _onSubmit(builderContext),
                  );
                },
                selector: (BuildContext context, StockInProvider provider) {
                  return provider.isAuditStatusFailSelected;
                },
              ),
            )
          ],
        );
      }),
    );
  }

  void _onSubmit(BuildContext context) {
    var provider = StockInProvider.of(context, listen: false);
    var items = provider.filterUploadMediaFileItems();

    StockInSubmitRequest request = StockInSubmitRequest()
      ..awbNumber = awbNumber
      ..qrcode = barCode;

    if (items.isEmpty) {
      request.imgList = [];
      _submitData(context, request);
    } else {
      // upload image data logic
      MediaFileUploadScreen.navigate(context, items).then((value) {
        if (value != null) {
          request.imgList = provider.convertMapToSelectionData(items);
          _submitData(context, request);
        }
      });
    }
  }

  void _submitData(BuildContext context, StockInSubmitRequest request) {
    var provider = StockInProvider.of(context, listen: false);
    var theme = Theme.of(context);
    provider.addAccessoriesOptionData();
    AccessoriesData accessoriesData = AccessoriesData();
    accessoriesData.action = 'Stock In';
    accessoriesData.qrCode = barCode;

    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return Dialog(
              child: ChangeNotifierProvider.value(value: provider, child: const AccessoryAvailabilityWidget()));
        }).then((value) {
      if (value != null) {
        for (var element in provider.accessoriesOptionDataList) {
          if (element.optionName == StockInConstants.BOX) {
            accessoriesData.hasBox = element.availableFlag!;
          } else if (element.optionName == StockInConstants.CHARGER) {
            accessoriesData.hasCharger = element.availableFlag!;
          }
        }

        request.barcodeChargerTracking = accessoriesData;

        CshLoading().showLoading(context);

        provider.stockInSubmission(request).then((value) {
          CshLoading().hideLoading(context);

          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) {
              return AlertDialog(
                content: CshTextNew.h3(value.confirmationMessage ?? 'Success'),
                actions: [
                  TextButton(
                    child: CshTextNew(
                      'OK',
                      textStyle: theme.textTheme.headlineMedium?.copyWith(color: theme.primaryColor),
                    ),
                    onPressed: () {
                      Navigator.popUntil(context, ModalRoute.withName(StockInScreen.route));
                    },
                  ),
                ],
              );
            },
          );
        }, onError: (error) {
          CshLoading().hideLoading(context);
          var errorMsg = ApiErrorHelper.getErrorMessage(error) ?? 'Something Went Wrong.';
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (dialogContext) {
              return AlertDialog(
                title: CshTextNew.h2('Error'),
                content: CshTextNew.h3(errorMsg),
                actions: [
                  TextButton(
                    child: CshTextNew(
                      'Retry',
                      textStyle: theme.textTheme.headlineMedium?.copyWith(color: theme.primaryColor),
                    ),
                    onPressed: () {
                      Navigator.pop(dialogContext);
                      _submitData(context, request);
                    },
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.popUntil(context, ModalRoute.withName(StockInScreen.route));
                    },
                    child: CshTextNew(
                      'Cancel',
                      textStyle: theme.textTheme.headlineMedium?.copyWith(color: theme.primaryColor),
                    ),
                  )
                ],
              );
            },
          );
        });
      }
    });
  }
}
