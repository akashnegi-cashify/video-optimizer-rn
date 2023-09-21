import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/qc/modules/stock_in_module/providers/stock_in_provider.dart';
import 'package:provider/provider.dart';

import '../models/validate_awb_response.dart';
import 'widget.dart';

class ProductValidatingGrpWidget extends StatelessWidget {
  final List<Groups?>? validatingGrp;

  const ProductValidatingGrpWidget({super.key, this.validatingGrp});

  @override
  Widget build(BuildContext context) {
    print('ProductValidatingGrpWidget.build :::: ProductValidatingGrpWidget');
    var theme = Theme.of(context);
    return ListView.builder(
      itemBuilder: (context, index) {
        var item = validatingGrp?[index];
        return StickyHeader(
          header: Container(
            height: Dimens.space_50,
            color: theme.primaryColor,
            padding: const EdgeInsets.symmetric(horizontal: Dimens.space_16),
            alignment: Alignment.centerLeft,
            child: CshTextNew(
              item?.label ?? '',
              textStyle: theme.primaryTextTheme.displayMedium?.copyWith(color: theme.colorScheme.background),
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListView.separated(
                padding: const EdgeInsets.symmetric(horizontal: Dimens.space_12, vertical: Dimens.space_8),
                physics: const ScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (context, innerIndex) {
                  var innerItem = item?.items?[innerIndex];
                  return Selector<StockInProvider, bool>(
                    builder: (BuildContext context, value, Widget? child) {
                      return CshCard(
                        padding: EdgeInsets.zero,
                        child: ListTile(
                          contentPadding: EdgeInsets.zero,
                          title: cshGestureDetector(
                              child: CshCheckbox(
                                title: CshTextNew.h3(innerItem?.label ?? ''),
                                isSelected: value,
                              ),
                              onTap: () => _onItemClick(context,index,innerIndex)),
                        ),
                      );
                    },
                    selector: (BuildContext context, StockInProvider provider) {
                      return provider.getItemSelectionStatus(index, innerIndex) ;
                    },

                  );
                },
                itemCount: item?.items?.length ?? 0,
                separatorBuilder: (BuildContext context, int index) {
                  return const SizedBox(height: Dimens.space_8);
                },
              ),
            ],
          ),
        );
      },
      itemCount: validatingGrp?.length ?? 0,
    );
  }

  void _onItemClick(BuildContext context,int grpIndex,int itemIndex) {
    var provider = StockInProvider.of(context,listen: false);
    provider.updateItemSelectionStatus(grpIndex, itemIndex);
  }
}
