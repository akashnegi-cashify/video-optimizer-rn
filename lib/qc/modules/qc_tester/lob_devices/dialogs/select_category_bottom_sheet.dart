import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/qc/modules/qc_tester/lob_devices/resources/device_detail_response.dart';

void selectCategoryBottomSheet(BuildContext context, List<CategoryData>? categoryList,
    {Function(CategoryData category)? onCategorySelected}) {
  showCshBottomSheet(
    context: context,
    isScrollControlled: true,
    child: SizedBox(
      height: MediaQuery.of(context).size.height * 0.8,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: Dimens.space_24),
        child: _CategoryList(categoryList, onCategorySelected: onCategorySelected),
      ),
    ),
  );
}

class _CategoryList extends StatelessWidget {
  final List<CategoryData>? categoryList;
  final Function(CategoryData category)? onCategorySelected;

  const _CategoryList(this.categoryList, {super.key, this.onCategorySelected});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return ListView.separated(
      itemCount: categoryList?.length ?? 0,
      shrinkWrap: true,
      padding: const EdgeInsets.all(Dimens.space_16),
      separatorBuilder: (_, __) => const SizedBox(height: Dimens.space_12),
      itemBuilder: (context, index) {
        var category = categoryList![index];
        return InkWell(
          onTap: () {
            onCategorySelected?.call(category);
          },
          child: CshCard(child: Text(category.name ?? "", style: theme.primaryTextTheme.titleMedium)),
        );
      },
    );
  }
}
