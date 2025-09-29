import 'package:builder_component/builder_component.dart';
import 'package:core_widgets/core_widgets.dart';
import 'package:csh_annotation/annotation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/src/app_builder/app_builder_groups/groups.dart';
import 'package:flutter_trc/src/app_builder/app_headers/general_app_header/models/none_config_model.dart';
import 'package:provider/provider.dart';

import '../common_models/elss_device_details_response.dart';
import '../common_models/part_selection_comp_param.dart';
import '../elss_trc/providers/elss_provider_trc.dart';
import '../elss_trc/screens/brand_details_listing_screen.dart';
import '../elss_trc/widgets/part_selection_widget_trc.dart';

part 'part_selection_component.g.dart';

@CshComponent(
    key: PartSelectionComponent.COMP_KEY,
    configModel: NoneConfigModel,
    componentGroup: ComponentGroup.partSelectionComponentKey,
    params: PartSelectionCompParamKeys.values,
    paramModel: PartSelectionCompParam)
class PartSelectionComponent extends StatelessComponent<NoneConfigModel> {
  static const String COMP_KEY = "TRC_part_selection_comp";

  const PartSelectionComponent(super.jsonConfig, {super.key});

  @override
  Widget buildView(BuildContext context, configModel) {
    var theme = Theme.of(context);
    return paramBuilder((param) {
      return ChangeNotifierProvider<ELssProviderTrc>(
        create: (_) => ELssProviderTrc(param.scannedBarcode ?? "",
            onProductIdMissingCallback: (String barcode, {ElssDeviceDetailsResponse? detailsData}) {
          _productIdNullHandlingCallback(context, barcode, detailsData: detailsData);
        }),
        lazy: false,
        builder: (BuildContext innerContext, __) {
          var provider = ELssProviderTrc.of(innerContext);
          return (provider.isDetailsDataLoading)
              ? const Center(
                  child: SizedBox(
                    height: Dimens.space_30,
                    width: Dimens.space_30,
                    child: CircularProgressIndicator(),
                  ),
                )
              : (provider.isDetailsDataLoading == false && provider.elssDeviceDetails == null)
                  ? Center(
                      child: Text(
                        (provider.apiErrorMessage.isNotEmpty) ? provider.apiErrorMessage : "No Data Found",
                        textAlign: TextAlign.center,
                        style: theme.primaryTextTheme.displaySmall,
                      ),
                    )
                  : _PartSelection(scannedBarCode: param.scannedBarcode ?? "");
        },
      );
    });
  }

  _productIdNullHandlingCallback(BuildContext context, String barcode, {ElssDeviceDetailsResponse? detailsData}) {
    BrandDetailsListingArguments args = BrandDetailsListingArguments(
      barcode: barcode,
      deviceDetailsResponse: detailsData,
    );
    Navigator.of(context).pushReplacementNamed(BrandsDetailsListingScreen.route, arguments: args);
  }

  @override
  Function(Map<String, dynamic> data)? fromConfig() {
    return NoneConfigModel.fromConfig;
  }
}

class _PartSelection extends StatelessWidget {
  final String scannedBarCode;

  const _PartSelection({
    Key? key,
    required this.scannedBarCode,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var provider = ELssProviderTrc.of(context);
    var theme = Theme.of(context);
    if (!Validator.isNullOrEmpty(provider.elssDeviceDetails?.errorMessage)) {
      return Padding(
        padding: const EdgeInsets.all(Dimens.space_16),
        child: Center(
          child: Row(
            children: [
              const SizedBox(),
              Expanded(
                child: Text(
                  provider.elssDeviceDetails!.errorMessage!,
                  style: theme.primaryTextTheme.displaySmall,
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      );
    }

    return PartSelectionWidgetTrc(
      barcode: scannedBarCode,
    );
  }
}
