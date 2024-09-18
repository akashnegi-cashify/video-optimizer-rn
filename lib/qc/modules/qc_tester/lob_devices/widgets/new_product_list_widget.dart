import 'package:core_widgets/core_widgets.dart' hide iterate;
import 'package:flutter/material.dart';
import 'package:flutter_trc/qc/modules/qc_tester/lob_devices/providers/product_list_provider.dart';
import 'package:flutter_trc/qc/modules/qc_tester/lob_devices/providers/variant_list_provider.dart';
import 'package:flutter_trc/qc/modules/qc_tester/lob_devices/resources/lob_product_list_response.dart';
import 'package:flutter_trc/qc/modules/qc_tester/lob_devices/resources/service_initialize_interface.dart';
import 'package:flutter_trc/qc/modules/qc_tester/lob_devices/resources/variant_list_response.dart';
import 'package:flutter_trc/qc/modules/qc_tester/lob_devices/screens/variant_list_screen.dart';
import 'package:flutter_trc/src/common/widgets/my_search_bar_widget.dart';
import 'package:flutter_trc/src/libraries/analytics/analytics_controller.dart';
import 'package:flutter_trc/src/libraries/analytics/events/product_search_clicked_event.dart';
import 'package:flutter_trc/src/libraries/analytics/events/variant_search_clicked_event.dart';
import 'package:flutter_trc/src/utils/paginate_list_abstract.dart';
import 'package:provider/provider.dart';

class NewProductListWidget extends StatefulWidget {
  final Function(LobProductListData productItem, VariantListData? variantItem) onProductSelected;

  const NewProductListWidget(this.onProductSelected, {super.key});

  @override
  State<NewProductListWidget> createState() => _NewProductListWidgetState();
}

class _NewProductListWidgetState extends PaginatedListState<LobProductListData, NewProductListWidget>
    implements ServiceInitializeInterface {
  @override
  void initState() {
    var provider = ProductListProvider.of(context, listen: false);
    provider.setServiceInitializedListener(this);
  }

  @override
  Widget build(BuildContext context) {
    var provider = ProductListProvider.of(context);
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.90,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          const Padding(
            padding: EdgeInsets.all(Dimens.space_16),
            child: CshTextNew.h3("Please select product"),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: Dimens.space_16),
            child: MySearchBarWidget(
              hintText: "Search by product name",
              onQuery: (query) {
                provider.searchQuery = query;
                resetAndRefreshScreen();
              },
            ),
          ),
          const SizedBox(height: Dimens.space_16),
          Expanded(
            child: iterate(
              (item, index) {
                return GestureDetector(
                  onTap: () => _onItemClicked(context, item),
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
              },
              padding: const EdgeInsets.symmetric(horizontal: Dimens.space_16),
              separator: const SizedBox(height: Dimens.space_12),
            ),
          ),
        ],
      ),
    );
  }

  void _onItemClicked(BuildContext context, LobProductListData item) {
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
                widget.onProductSelected(item, variantItem);
              },
            ),
          );
        },
      ));
    } else {
      widget.onProductSelected(item, null);
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

  @override
  void requestApi(int pageNo,
      {Function(List<LobProductListData>? list)? onSuccess, Function(String errorMessage)? onError}) {
    var provider = ProductListProvider.of(context, listen: false);
    if (!provider.isPageInitializing) {
      provider.getProductsList(pageNo, pageSize).then((value) {
        onSuccess?.call(value);
      }, onError: (error) {
        onError?.call(error);
      });
    }
  }

  @override
  void initialize() {
    resetAndRefreshScreen();
  }
}
