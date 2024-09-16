import 'package:builder_component/builder_component.dart';
import 'package:csh_annotation/annotation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/qc/modules/qc_tester/lob_devices/models/product_list_screen_arg_model.dart';
import 'package:flutter_trc/qc/modules/qc_tester/lob_devices/providers/product_list_provider.dart';
import 'package:flutter_trc/qc/modules/qc_tester/lob_devices/widgets/new_product_list_widget.dart';
import 'package:flutter_trc/src/app_builder/app_builder_groups/qc_groups.dart';
import 'package:flutter_trc/src/app_builder/app_headers/general_app_header/models/none_config_model.dart';
import 'package:provider/provider.dart';

part 'product_list_component.g.dart';

@CshComponent(
  key: ProductListComponent.COMP_KEY,
  configModel: NoneConfigModel,
  componentGroup: QcComponentGroup.qcProductListComponentKey,
  paramModel: ProductListScreenArgModel,
  params: ProductListScreenArgModelKeys.values,
)
class ProductListComponent extends StatelessComponent<NoneConfigModel> {
  static const String COMP_KEY = "QC_product_list_component";

  const ProductListComponent(super.jsonConfig, {super.key});

  @override
  Widget buildView(BuildContext context, configModel) {
    return paramBuilder((model) {
      return ChangeNotifierProvider(
        create: (_) => ProductListProvider(model),
        child: NewProductListWidget(model.onProductSelected),
      );
    });
  }

  @override
  Function(Map<String, dynamic> data)? fromConfig() {
    return NoneConfigModel.fromConfig;
  }
}
