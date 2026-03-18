import 'dart:async';

import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/qc/modules/qc_tester/lob_devices/providers/variant_list_provider.dart';
import 'package:flutter_trc/qc/modules/qc_tester/lob_devices/resources/variant_list_response.dart';
import 'package:flutter_trc/qc/modules/qc_tester/lob_devices/widgets/variant_list_item_widget.dart';
import 'package:flutter_trc/src/app_builder/app_headers/qc_general_header/widgets/qc_general_header.dart';
import 'package:flutter_trc/src/common/widgets/my_search_bar_widget.dart';
import 'package:flutter_trc/src/common/widgets/shimmer_list_widget.dart';

class VariantListScreen extends StatefulWidget {
  final Function(VariantListData? variantItem) onVariantSelected;
  final bool isFromTrc;

  const VariantListScreen({
    required this.onVariantSelected,
    this.isFromTrc = false,
    super.key,
  });

  @override
  State<VariantListScreen> createState() => _VariantListScreenState();
}

class _VariantListScreenState extends State<VariantListScreen> {
  @override
  void initState() {
    super.initState();
    scheduleMicrotask(() {
      var provider = VariantListProvider.of(context, listen: false);
      provider.getVariantList();
    });
  }

  @override
  Widget build(BuildContext context) {
    var provider = VariantListProvider.of(context);
    return Scaffold(
      appBar: const QcGeneralHeader("Please select variant", showBackBtn: true),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: Dimens.space_16),
          CshCard(
            margin: const EdgeInsets.symmetric(horizontal: Dimens.space_16),
            cardWidth: double.infinity,
            child: CshTextNew.h3(provider.seriesName),
          ),
          const SizedBox(height: Dimens.space_16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: Dimens.space_16),
            child: MySearchBarWidget(
              hintText: "Search by variant name",
              onQuery: (query) => provider.setSearchQuery(query),
            ),
          ),
          const SizedBox(height: Dimens.space_8),
          if (provider.isShowLoading)
            const Expanded(child: ShimmerListWidget(itemCount: 4))
          else
            Expanded(
              child: ListView.separated(
                padding: const EdgeInsets.symmetric(horizontal: Dimens.space_16),
                itemCount: provider.variantList?.length ?? 0,
                itemBuilder: (context, index) {
                  var item = provider.variantList![index];
                  return VariantListItemWidget(item, onTap: (item) {
                    if (Validator.isNullOrEmpty(item.commonName)) {
                      CshSnackBar.error(
                        context: context,
                        message: "Model no. is missing.",
                        snackBarPosition: SnackBarPosition.TOP,
                      );
                      return;
                    }
                    widget.onVariantSelected(item);
                  });
                },
                separatorBuilder: (_, __) => const SizedBox(height: Dimens.space_12),
              ),
            ),
        ],
      ),
    );
  }
}
