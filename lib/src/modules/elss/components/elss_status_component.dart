import 'package:builder_component/builder_component.dart';
import 'package:core_widgets/core_widgets.dart';
import 'package:csh_annotation/annotation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/src/app_builder/app_builder_groups/groups.dart';
import 'package:flutter_trc/src/app_builder/app_headers/general_app_header/models/none_config_model.dart';
import 'package:provider/provider.dart';

import '../../../header/trc_header.dart';
import '../common_models/elss_status_comp_param.dart';
import '../common_screen/elss_home_screen.dart';
import '../elss_qc/l10n.dart';
import '../elss_qc/providers/elss_status_provider.dart';
import '../elss_qc/resources/elss_status.dart';
import '../elss_qc/screens/elss_status_screen.dart';
import '../elss_qc/widgets/elss_device_details_widget.dart';

part 'elss_status_component.g.dart';

@CshComponent(
    key: ElssStatusComponent.COMP_KEY,
    configModel: NoneConfigModel,
    params: ElssStatusCompParamKeys.values,
    paramModel: ElssStatusCompParam,
    componentGroup: ComponentGroup.elssStatusComponentKey)
class ElssStatusComponent extends StatelessComponent<NoneConfigModel> {
  static const String COMP_KEY = "TRC_elss_status_comp";

  const ElssStatusComponent(super.jsonConfig, {super.key});

  @override
  Widget buildView(BuildContext context, configModel) {
    var theme = Theme.of(context);
    var l10n = L10n(context);
    return paramBuilder((param) {
      return ChangeNotifierProvider<ElssStatusProvider>(
        create: (_) => ElssStatusProvider(param.arguments?.barcode ?? ""),
        lazy: false,
        builder: (BuildContext innerContext, __) {
          var provider = ElssStatusProvider.of(innerContext);
          if (provider.isDataLoading) {
            return const Scaffold(
              body: Center(
                child: SizedBox(
                  height: Dimens.space_30,
                  width: Dimens.space_30,
                  child: CircularProgressIndicator(),
                ),
              ),
            );
          } else if (provider.isDataLoading == false && !Validator.isNullOrEmpty(provider.errMessage)) {
            return Scaffold(
              appBar: TrcHeader(l10n.elssStatus),
              body: Center(
                child: Row(
                  children: [
                    const SizedBox.shrink(),
                    Expanded(
                      child: Text(
                        provider.errMessage!,
                        style: theme.primaryTextTheme.headlineMedium,
                        textAlign: TextAlign.center,
                      ),
                    )
                  ],
                ),
              ),
            );
          } else {
            return _body(innerContext, theme, l10n, param.arguments!);
          }
        },
      );
    });
  }

  _body(BuildContext context, ThemeData theme, L10n l10n, ElssStatusScreenArg arg) {
    var provider = ElssStatusProvider.of(context);
    var statusData = _getStatusData(arg.elssStatus, l10n);
    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.elssStatus, style: theme.primaryTextTheme.displaySmall),
        automaticallyImplyLeading: false,
        backgroundColor: theme.colorScheme.surface,
        elevation: 0.0,
        shadowColor: theme.colorScheme.surface,
      ),
      body: CshCard(
        padding: const EdgeInsets.symmetric(horizontal: Dimens.space_16, vertical: Dimens.space_30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    CshCard(
                      radius: CshRadius.rad8,
                      elevation: CardElevation.dimen_10,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(statusData.imagePath, height: 100, width: 100),
                          const SizedBox(height: Dimens.space_24),
                          Row(
                            children: [
                              const SizedBox.shrink(),
                              Expanded(
                                child: Text(
                                  statusData.description,
                                  textAlign: TextAlign.center,
                                  style: theme.primaryTextTheme.displayMedium,
                                  maxLines: 2,
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: Dimens.space_20),
                    if (Validator.isNullOrEmpty(provider.errMessage))
                      ElssDeviceDetailsWidget(dataModel: provider.deviceDetails),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: Dimens.space_16,
            ),
            SizedBox(
              width: double.infinity,
              child: CshBigButton(
                text: l10n.home,
                onPressed: () {
                  ElssHomeScreenArguments args = ElssHomeScreenArguments(isLogicFromQC: true);
                  Navigator.pushNamedAndRemoveUntil(context, ElssHomeScreen.route, (route) => false, arguments: args);
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  _ElssStatusData _getStatusData(ElssStatus status, L10n l10n) {
    switch (status) {
      case ElssStatus.submit:
        return _ElssStatusData("assets/images/ic_elss_accept.png", l10n.elssSubmitDescription);
      case ElssStatus.reject:
        return _ElssStatusData("assets/images/ic_elss_reject.png", l10n.rejectDescription);
      case ElssStatus.pna:
        return _ElssStatusData("assets/images/ic_pna.png", l10n.pnaDescription);
    }
  }

  @override
  Function(Map<String, dynamic> data)? fromConfig() {
    return NoneConfigModel.fromConfig;
  }
}

class _ElssStatusData {
  String imagePath;
  String description;

  _ElssStatusData(this.imagePath, this.description);
}
