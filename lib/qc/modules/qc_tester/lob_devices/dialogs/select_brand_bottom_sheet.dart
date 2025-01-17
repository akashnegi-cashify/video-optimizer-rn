import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_trc/qc/modules/qc_tester/lob_devices/widgets/brand_list_widget.dart';
import 'package:flutter_trc/qc/modules/qc_tester/lob_devices/resources/brand_list_response.dart';

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
