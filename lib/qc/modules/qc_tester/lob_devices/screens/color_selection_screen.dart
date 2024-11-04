import 'package:builder_project/builder_project.dart';
import 'package:csh_annotation/annotation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/qc/modules/qc_tester/lob_devices/models/color_selection_screen_arg_model.dart';
import 'package:flutter_trc/src/app_builder/app_builder_groups/qc_groups.dart';

part 'color_selection_screen.g.dart';

class ColorSelectionScreenArguments extends BaseArguments {
  int? productId;
  String? deviceBarcode;
  Function(String color)? onColorSelected;

  ColorSelectionScreenArguments(
    this.productId,
    this.deviceBarcode,
    this.onColorSelected,
  ) : super(ColorSelectionScreen.pageKey);

  Map<String, dynamic> toMap() {
    return {
      ColorSelectionScreenArgModelKeys.productId.value: productId,
      ColorSelectionScreenArgModelKeys.deviceBarcode.value: deviceBarcode,
      ColorSelectionScreenArgModelKeys.onColorSelected.value: onColorSelected,
    };
  }
}

@CshPage(
  key: ColorSelectionScreen.pageKey,
  pageGroup: QcPageGroup.qcColorSelectionPageKey,
  params: ColorSelectionScreenArgModelKeys.values,
)
class ColorSelectionScreen extends BaseScreen<ColorSelectionScreenArguments> {
  static const String pageKey = "QC_color_selection_screen";
  static const String route = "/qc-tester/color-selection";

  const ColorSelectionScreen({super.key});

  @override
  Widget buildView(BuildContext context) {
    var args = getArguments(context);
    return PageWidget(pageKey: pageKey, initialValue: args?.toMap());
  }

  static navigateTo(BuildContext context, int? productId, String? barcode, Function(String color) onColorSelected) {
    Navigator.of(context)
        .pushNamed(route, arguments: ColorSelectionScreenArguments(productId, barcode, onColorSelected));
  }
}
