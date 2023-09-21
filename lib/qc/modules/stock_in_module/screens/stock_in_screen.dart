import 'package:builder_project/builder_project.dart';
import 'package:csh_annotation/annotation.dart';
import 'package:flutter/material.dart';

part 'stock_in_screen.g.dart';

@CshPage(key: StockInScreen.pageKey,)

// todo ask page grp

class StockInScreen extends BaseScreen {
  static const String pageKey = "QC_qc_stock_in";
  static const String route = "/stock-in";

  const StockInScreen({super.key});

  @override
  Widget buildView(BuildContext context) {
    return const PageWidget(pageKey: pageKey);
  }
}