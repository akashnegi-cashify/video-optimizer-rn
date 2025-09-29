import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/qc/modules/qc_tester/lob_devices/providers/product_list_provider.dart';
import 'package:flutter_trc/qc/modules/qc_tester/lob_devices/providers/variant_list_provider.dart';
import 'package:flutter_trc/qc/modules/qc_tester/lob_devices/resources/lob_product_list_response.dart';
import 'package:flutter_trc/qc/modules/qc_tester/lob_devices/resources/variant_list_response.dart';
import 'package:flutter_trc/qc/modules/qc_tester/lob_devices/screens/variant_list_screen.dart';
import 'package:flutter_trc/src/libraries/analytics/analytics_controller.dart';
import 'package:flutter_trc/src/libraries/analytics/events/product_search_clicked_event.dart';
import 'package:flutter_trc/src/libraries/analytics/events/variant_search_clicked_event.dart';
import 'package:provider/provider.dart';

mixin ProductListSelection {
  Widget buildItemWidget(context, LobProductListData item,
      Function(LobProductListData productItem, VariantListData? variantItem) onProductSelected) {
    return GestureDetector(
      onTap: () => _onItemClicked(context, item, onProductSelected),
      child: CshCard(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CshTextNew.subTitle1(item.brand ?? ""),
            const SizedBox(height: Dimens.space_4),
            CshTextNew.subTitle1(item.name ?? ""),
          ],
        ),
      ),
    );
  }

  void _onItemClicked(BuildContext context, LobProductListData item,
      Function(LobProductListData productItem, VariantListData? variantItem) onProductSelected) {
    var provider = ProductListProvider.of(context, listen: false);
    _fireProductSearchAnalytics(item, provider.categoryId, provider.deviceBarcode);
    if (provider.isAllowedVariants()) {
      Navigator.push(context, MaterialPageRoute(
        builder: (context) {
          return ChangeNotifierProvider(
            create: (_) => VariantListProvider(item.productId!, item.name ?? ""),
            child: VariantListScreen(
              onVariantSelected: (variantItem) {
                Navigator.pop(context); // pop variant list screen
                _fireVariantAnalytics(variantItem!, provider.deviceBarcode, provider.categoryId);
                onProductSelected(item, variantItem);
              },
            ),
          );
        },
      ));
    } else {
      onProductSelected(item, null);
    }
  }

  _fireProductSearchAnalytics(LobProductListData item, int? categoryId, String? deviceBarcode) {
    AnalyticsController.logEvent(ProductSearchClickedEvent(
      barcode: deviceBarcode.toString(),
      productName: item.name,
      productId: item.productId,
      deviceCategory: categoryId.toString(),
    ));
  }

  _fireVariantAnalytics(VariantListData item, String? deviceBarcode, int? categoryId) {
    AnalyticsController.logEvent(VariantSearchClickedEvent(
      barcode: deviceBarcode.toString(),
      productName: item.name,
      variantId: item.id,
      deviceCategory: categoryId.toString(),
    ));
  }
}
