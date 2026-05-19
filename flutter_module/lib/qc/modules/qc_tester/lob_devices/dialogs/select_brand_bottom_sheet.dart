import 'package:components/components.dart';
import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/qc/modules/qc_tester/lob_devices/resources/brand_list_response.dart';
import 'package:flutter_trc/qc/modules/qc_tester/lob_devices/widgets/brand_list_widget.dart';
import 'package:flutter_trc/src/modules/elss/common_models/brand_list_response_console.dart';
import 'package:flutter_trc/src/services/service_groups.dart';

void selectBrandBottomSheet(BuildContext context, List<BrandListData> brandList,
    {Function(BrandListData brand)? onBrandSelect, bool isDismissible = true}) {
  showCshBottomSheet(
    context: context,
    isDismissible: isDismissible,
    isScrollControlled: true,
    child: PopScope(
      canPop: isDismissible,
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.8,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: Dimens.space_24),
          child: BrandListWidget(brandList, onBrandSelect: onBrandSelect),
        ),
      ),
    ),
  );
}

void selectBrandBottomSheetConsole(BuildContext context,
    {required Function(BrandItem brand) onBrandSelect, bool isDismissible = true}) {
  showCshBottomSheet(
    context: context,
    isDismissible: isDismissible,
    isScrollControlled: true,
    child: PopScope(
      canPop: isDismissible,
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.8,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: Dimens.space_24),
          child: _BrandList(onItemClicked: onBrandSelect),
        ),
      ),
    ),
  );
}

class _BrandList extends StatelessWidget {
  Function(BrandItem item) onItemClicked;

  _BrandList({required this.onItemClicked, super.key});

  final CshListController _listController = CshListController();

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: CshApiList<BrandItem>(
        apiConfig: ListApiConfig(
          apiUrl: "/brand/list",
          serviceGroup: TRCServiceGroups.unifyTrc,
        ),
        controller: _listController,
        shimmerLoaderWidget: const CshShimmer(height: Dimens.space_60),
        itemFromJson: BrandItem.fromJson,
        getRowWidget: (item, index) {
          if (item != null) {
            return InkWell(
              onTap: () => onItemClicked(item),
              child: CshCard(child: CshTextNew.subTitle1(item.value ?? "")),
            );
          }
          return SizedBox.shrink();
        },
      ),
    );
  }
}
