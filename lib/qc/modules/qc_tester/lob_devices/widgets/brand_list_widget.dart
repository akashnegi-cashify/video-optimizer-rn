import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/qc/modules/qc_tester/lob_devices/resources/brand_list_response.dart';
import 'package:flutter_trc/src/common/widgets/my_search_bar_widget.dart';

class BrandListWidget extends StatefulWidget {
  final Function(BrandListData brand)? onBrandSelect;
  final List<BrandListData> brandList;

  const BrandListWidget(this.brandList, {super.key, this.onBrandSelect});

  @override
  State<BrandListWidget> createState() => _BrandListWidgetState();
}

class _BrandListWidgetState extends State<BrandListWidget> {
  String? _query;

  List<BrandListData> getFilteredBrandList() {
    if (Validator.isNullOrEmpty(_query)) {
      return widget.brandList;
    } else {
      return widget.brandList.where((element) => element.brandName?.toLowerCase().contains(_query!.toLowerCase()) ?? false).toList();
    }
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var list = getFilteredBrandList();
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: Dimens.space_16),
          child: MySearchBarWidget(
            hintText: "Search Brand",
            onQuery: (String query) {
              setState(() {
                _query = query;
              });
            },
          ),
        ),
        Validator.isListNullOrEmpty(list)
            ? Container(
                padding: const EdgeInsets.all(Dimens.space_16),
                alignment: Alignment.center,
                child: Text(
                  "No brands found",
                  style: theme.primaryTextTheme.titleMedium?.copyWith(color: theme.colorScheme.error),
                ),
              )
            : Expanded(
                child: ListView.separated(
                  itemCount: list.length,
                  shrinkWrap: true,
                  padding: const EdgeInsets.all(Dimens.space_16),
                  separatorBuilder: (_, __) => const SizedBox(height: Dimens.space_12),
                  itemBuilder: (context, index) {
                    var brand = list[index];
                    return InkWell(
                      onTap: () {
                        widget.onBrandSelect?.call(brand);
                      },
                      child: CshCard(child: Text(brand.brandName ?? "", style: theme.primaryTextTheme.titleMedium)),
                    );
                  },
                ),
              ),
      ],
    );
  }
}
