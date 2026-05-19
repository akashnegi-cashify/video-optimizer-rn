import 'package:builder_component/builder_component.dart';
import 'package:csh_annotation/annotation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/src/app_builder/app_builder_groups/qc_groups.dart';
import 'package:provider/provider.dart';

import '../../../../src/app_builder/app_headers/general_app_header/models/none_config_model.dart';
import '../models/product_detail_comp_params.dart';
import '../widgets/index.dart';

part 'stock_in_product_detail_component.g.dart';

@CshComponent(
    key: StockInProductDetailComponent.COMP_KEY,
    configModel: NoneConfigModel,
    componentGroup: QcComponentGroup.qcStockInProductDetailComponentKey,
    paramModel: ProductDetailCompParam,
    params: ProductDetailCompParamKeys.values)
class StockInProductDetailComponent extends StatelessComponent<NoneConfigModel> {
  static const String COMP_KEY = "QC_qc_stock_in_product_detail_component";

  const StockInProductDetailComponent(super.jsonConfig, {super.key});

  @override
  Widget buildView(BuildContext context, configModel) {
    return paramBuilder(
      (paramModel) => StockInProductDetailWidget(
        stockInProductDetail: paramModel.stockInProductDetail,
        awbNumber: paramModel.awbNumber,
        barCode: paramModel.barcode,
      ),
    );
  }

  @override
  Function(Map<String, dynamic> data)? fromConfig() {
    return NoneConfigModel.fromConfig;
  }
}
