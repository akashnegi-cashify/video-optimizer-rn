import 'package:builder_component/builder_component.dart';
import 'package:core_widgets/core_widgets.dart';
import 'package:csh_annotation/annotation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/src/app_builder/app_builder_groups/groups.dart';
import 'package:flutter_trc/src/app_builder/app_headers/general_app_header/models/none_config_model.dart';
import 'package:provider/provider.dart';

import '../../../header/trc_header.dart';
import '../common_models/part_selection_qc_comp_param.dart';
import '../elss_qc/l10n.dart';
import '../elss_qc/providers/elss_provider_qc.dart';
import '../elss_qc/widgets/part_selection_widget.dart';

part 'part_selection_qc_component.g.dart';

@CshComponent(
    key: PartSelectionQCComponent.COMP_KEY,
    configModel: NoneConfigModel,
    params: PartSelectionQCCompParamKeys.values,
    paramModel: PartSelectionQCCompParam,
    componentGroup: ComponentGroup.partSelectionQCComponentKey)
class PartSelectionQCComponent extends StatelessComponent<NoneConfigModel> {
  static const String COMP_KEY = "TRC_part_selection_QC";

  const PartSelectionQCComponent(super.jsonConfig, {super.key});

  @override
  Widget buildView(BuildContext context, configModel) {
    var theme = Theme.of(context);
    var l10n = L10n(context);
    return paramBuilder(
      (param) {
        return ChangeNotifierProvider<ELssProviderQc>(
          create: (_) => ELssProviderQc(param.scannedBarcode ?? ""),
          lazy: false,
          builder: (BuildContext innerContext, __) {
            var provider = ELssProviderQc.of(innerContext);

            return Scaffold(
              appBar: TrcHeader(l10n.deviceDetails),
              resizeToAvoidBottomInset: false,
              body: (provider.isDetailsDataLoading)
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
                            (provider.detailsApiErrorMessage.isNotEmpty)
                                ? provider.detailsApiErrorMessage
                                : l10n.noDataFound,
                            textAlign: TextAlign.center,
                            style: theme.primaryTextTheme.displaySmall,
                          ),
                        )
                      : _PartSelection(scannedBarCode: param.scannedBarcode ?? ""),
            );
          },
        );
      },
    );
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
    var provider = ELssProviderQc.of(context);
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

    return PartSelectionWidget(
      barcode: scannedBarCode,
    );
  }
}
