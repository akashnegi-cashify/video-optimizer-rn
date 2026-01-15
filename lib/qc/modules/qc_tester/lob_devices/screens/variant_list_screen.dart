import 'package:components/components.dart';
import 'package:components/resources/list/list_request.dart';
import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/qc/modules/qc_tester/lob_devices/providers/variant_list_provider.dart';
import 'package:flutter_trc/qc/modules/qc_tester/lob_devices/resources/variant_list_response.dart';
import 'package:flutter_trc/qc/modules/qc_tester/lob_devices/widgets/variant_list_item_widget.dart';
import 'package:flutter_trc/src/app_builder/app_headers/qc_general_header/widgets/qc_general_header.dart';
import 'package:flutter_trc/src/services/service_groups.dart';

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
  final CshListController _listController = CshListController();

  FilterConfig _getFilterConfig(VariantListProvider provider) {
    return FilterConfig(
      filterData: [
        CshFilterData(
          label: "Search by variant name",
          field: 'pn',
          crudFilter: 'pn',
          filterType: CshFilterType.input,
          valueType: CshFilterValueType.contains,
          position: FilterPosition.top,
          keyboardType: TextInputType.text,
          filterGroup: FilterGroupType.multipleTypeSearch,
        ),
      ],
      preSelectedFilters: [
        AdminFilterList(
          type: 'pdid',
          field: 'pdid',
          value: AdminFilterData(search: provider.productId.toString()),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    var provider = VariantListProvider.of(context);
    return Scaffold(
      appBar: const QcGeneralHeader("Please select variant", showBackBtn: true),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: Dimens.space_16),
          CshCard(
            margin: const EdgeInsets.symmetric(horizontal: Dimens.space_16),
            cardWidth: double.infinity,
            child: CshTextNew.h3(provider.seriesName),
          ),
          const SizedBox(height: Dimens.space_16),
          Expanded(
            child: CshApiList<VariantListData>(
              apiConfig: ListApiConfig(
                apiUrl: "/manual-test/search/variant",
                serviceGroup: widget.isFromTrc
                    ? TRCServiceGroups.unifyTrc
                    : TRCServiceGroups.qcConsole,
              ),
              filterConfig: _getFilterConfig(provider),
              controller: _listController,
              itemFromJson: VariantListData.fromJson,
              shimmerLoaderWidget: const CshShimmer(height: Dimens.space_60),
              listPadding:
                  const EdgeInsets.symmetric(horizontal: Dimens.space_16),
              verticalRowSpacing: Dimens.space_12,
              isHideCoreFilterButton: true,
              getRowWidget: (item, index) {
                final data = item;
                return VariantListItemWidget(data!, onTap: (item) {
                  if (Validator.isNullOrEmpty(item.commonName)) {
                    CshSnackBar.error(
                        context: context,
                        message: "Model no. is missing.",
                        snackBarPosition: SnackBarPosition.TOP);
                    return;
                  }

                  widget.onVariantSelected(item);
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}
