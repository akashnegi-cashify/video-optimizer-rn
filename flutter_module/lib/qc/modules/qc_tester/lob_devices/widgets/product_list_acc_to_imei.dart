import 'dart:async';

import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/qc/modules/qc_tester/lob_devices/providers/product_list_provider.dart';
import 'package:flutter_trc/qc/modules/qc_tester/lob_devices/resources/lob_product_list_response.dart';
import 'package:flutter_trc/qc/modules/qc_tester/lob_devices/resources/variant_list_response.dart';
import 'package:flutter_trc/qc/modules/qc_tester/lob_devices/widgets/product_list_selection.dart';
import 'package:flutter_trc/src/common/widgets/my_search_bar_widget.dart';
import 'package:flutter_trc/src/common/widgets/shimmer_list_widget.dart';

class ProductListAccToImei extends StatefulWidget {
  final Function(LobProductListData productItem, VariantListData? variantItem) onProductSelected;

  const ProductListAccToImei(this.onProductSelected, {super.key});

  @override
  State<ProductListAccToImei> createState() => _ProductListAccToImeiState();
}

class _ProductListAccToImeiState extends State<ProductListAccToImei> with ProductListSelection {
  @override
  void initState() {
    scheduleMicrotask(() {
      var provider = ProductListProvider.of(context, listen: false);
      provider.getProductsListWithImei();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var provider = ProductListProvider.of(context);
    if (provider.isShowLoading) {
      return const ShimmerListWidget(itemCount: 4);
    }

    return Padding(
      padding: const EdgeInsets.all(Dimens.space_16),
      child: Column(
        children: [
          MySearchBarWidget(
            hintText: "Search by product name",
            onQuery: (query) => provider.setSearchQuery(query),
          ),
          const SizedBox(height: Dimens.space_8),
          ListView.separated(
            itemCount: provider.productListAccToImei?.length ?? 0,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              var item = provider.productListAccToImei![index];
              return buildItemWidget(context, item, widget.onProductSelected);
            },
            separatorBuilder: (_, __) => const SizedBox(height: Dimens.space_12),
          ),
          const SizedBox(height: Dimens.space_24),
          CshBigButton(
            text: "Show All List",
            onPressed: () {
              provider.changeListType(isNotify: true);
            },
          )
        ],
      ),
    );
  }
}
