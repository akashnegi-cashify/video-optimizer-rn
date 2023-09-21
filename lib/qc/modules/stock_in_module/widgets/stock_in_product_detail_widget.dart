import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/qc/modules/stock_in_module/providers/stock_in_provider.dart';
import 'package:provider/provider.dart';

import '../models/validate_awb_response.dart';
import '../l10n.dart';
import 'index.dart';

class StockInProductDetailWidget extends StatelessWidget {
  final ValidateAwbResponse? stockInProductDetail;

  const StockInProductDetailWidget({
    super.key,
    this.stockInProductDetail,
  });

  @override
  Widget build(BuildContext context) {
    var l10n = L10n(context);
    return ChangeNotifierProvider(
      create: (context) => StockInProvider(stockInProductDetail),
      child: Column(
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
            child: CshBigButton(
              text: l10n.submit,
              onPressed: () => _onSubmit(context),
            ),
          )
        ],
      ),
    );
  }

  void _onSubmit(BuildContext context) {}
}
