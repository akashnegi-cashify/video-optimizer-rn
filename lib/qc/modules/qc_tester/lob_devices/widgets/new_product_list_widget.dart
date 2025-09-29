import 'package:core_widgets/core_widgets.dart' hide iterate;
import 'package:flutter/material.dart';
import 'package:flutter_trc/qc/modules/qc_tester/lob_devices/providers/product_list_provider.dart';
import 'package:flutter_trc/qc/modules/qc_tester/lob_devices/resources/lob_product_list_response.dart';
import 'package:flutter_trc/qc/modules/qc_tester/lob_devices/resources/variant_list_response.dart';
import 'package:flutter_trc/qc/modules/qc_tester/lob_devices/widgets/product_list_selection.dart';
import 'package:flutter_trc/src/common/widgets/my_search_bar_widget.dart';
import 'package:flutter_trc/src/utils/paginate_list_abstract.dart';

class NewProductListWidget extends StatefulWidget {
  final Function(LobProductListData productItem, VariantListData? variantItem) onProductSelected;

  const NewProductListWidget(this.onProductSelected, {super.key});

  @override
  State<NewProductListWidget> createState() => _NewProductListWidgetState();
}

class _NewProductListWidgetState extends PaginatedListState<LobProductListData, NewProductListWidget>
    with ProductListSelection {
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
                return buildItemWidget(context, item, widget.onProductSelected);
              },
              padding: const EdgeInsets.symmetric(horizontal: Dimens.space_16),
              separator: const SizedBox(height: Dimens.space_12),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void requestApi(int pageNo,
      {Function(List<LobProductListData>? list)? onSuccess, Function(String errorMessage)? onError}) {
    var provider = ProductListProvider.of(context, listen: false);
    provider.getProductsList(pageNo, pageSize).then((value) {
      onSuccess?.call(value);
    }, onError: (error) {
      onError?.call(error);
    });
  }
}
