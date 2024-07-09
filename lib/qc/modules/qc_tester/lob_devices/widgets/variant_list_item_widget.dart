import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/qc/modules/qc_tester/lob_devices/resources/variant_list_response.dart';

class VariantListItemWidget extends StatelessWidget {
  final VariantListData item;
  final Function(VariantListData item)? onTap;

  const VariantListItemWidget(this.item, {this.onTap, super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (onTap != null) {
          onTap!(item);
        }
      },
      child: CshCard(
        child: CshTextNew.subTitle1(item.name ?? ""),
      ),
    );
  }
}
