import 'package:components/components.dart';
import 'package:components/resources/list/list_request.dart';
import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/qc/modules/qc_tester/lob_devices/providers/product_list_provider.dart';
import 'package:flutter_trc/qc/modules/qc_tester/lob_devices/resources/lob_product_list_response.dart';
import 'package:flutter_trc/qc/modules/qc_tester/lob_devices/resources/variant_list_response.dart';
import 'package:flutter_trc/qc/modules/qc_tester/lob_devices/widgets/product_list_selection.dart';
import 'package:flutter_trc/src/libraries/shared_preferences/app_preferences.dart';
import 'package:flutter_trc/src/modules/login/resources/login_types.dart';
import 'package:flutter_trc/src/services/service_groups.dart';

class NewProductListWidget extends StatefulWidget {
  final Function(LobProductListData productItem, VariantListData? variantItem) onProductSelected;

  const NewProductListWidget(this.onProductSelected, {super.key});

  @override
  State<NewProductListWidget> createState() => _NewProductListWidgetState();
}

class _NewProductListWidgetState extends State<NewProductListWidget> with ProductListSelection {
  final CshListController _listController = CshListController();

  /// Returns the appropriate service group based on login type
  /// QC login uses qcConsole, TRC login uses unifyTrc
  TRCServiceGroups _getServiceGroup() {
    var loginTypeEnum = LoginTypes.fromValue(AppPreferences.app.getLoginType() ?? "");
    return loginTypeEnum == LoginTypes.qcLogin ? TRCServiceGroups.qcConsole : TRCServiceGroups.unifyTrc;
  }

  FilterConfig _getFilterConfig(ProductListProvider provider) {
    return FilterConfig(
      filterData: [
        CshFilterData(
          label: "Search by product name",
          field: "productName",
          crudFilter: 'productName',
          filterType: CshFilterType.input,
          valueType: CshFilterValueType.contains,
          position: FilterPosition.top,
          keyboardType: TextInputType.text,
          filterGroup: FilterGroupType.multipleTypeSearch,
        ),
      ],
      initialFilter: [
        // AdminFilterList(
        //   type: 'qr',
        //   field: 'qr',
        //   value: AdminFilterData(search: provider.deviceBarcode),
        // ),
        AdminFilterList(
          type: CshFilterValueType.equality.value,
          field: 'deviceCategory.id',
          value: AdminFilterData(search: provider.categoryId?.toString()),
        ),
        AdminFilterList(
          type: CshFilterValueType.equality.value,
          field: 'brand.brandId',
          value: AdminFilterData(search: provider.brandId?.toString()),
        ),
      ],
    );
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
            padding: EdgeInsets.fromLTRB(Dimens.space_16, Dimens.space_16, Dimens.space_16, 0),
            child: CshTextNew.h3("Please select product"),
          ),
          Expanded(
            child: CshApiList<LobProductListData>(
              apiConfig: ListApiConfig(
                apiUrl: "/manual-test/product/list",
                serviceGroup: _getServiceGroup(),
              ),
              filterConfig: _getFilterConfig(provider),
              controller: _listController,
              itemFromJson: LobProductListData.fromJson,
              shimmerLoaderWidget: const CshShimmer(height: Dimens.space_60),
              listPadding: const EdgeInsets.symmetric(horizontal: Dimens.space_16),
              verticalRowSpacing: Dimens.space_12,
              isHideCoreFilterButton: false,
              getRowWidget: (item, index) {
                final data = item;
                return buildItemWidget(context, data!, widget.onProductSelected);
              },
            ),
          ),
        ],
      ),
    );
  }
}
