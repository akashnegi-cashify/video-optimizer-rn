import 'package:builder_component/builder_component.dart';
import 'package:core_widgets/core_widgets.dart';
import 'package:csh_annotation/annotation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_trc/qc/modules/gaurd/models/add_agent_comp_param.dart';
import 'package:flutter_trc/qc/modules/gaurd/screens/guard_upload_invoice_screen.dart';
import 'package:flutter_trc/src/app_builder/app_builder_groups/qc_groups.dart';
import 'package:flutter_trc/src/app_builder/app_headers/general_app_header/models/none_config_model.dart';
import 'package:provider/provider.dart';

import '../l10n.dart';
import '../providers/qc_guard_add_agent_provider.dart';

part 'qc_guard_add_agent_component.g.dart';

@CshComponent(
    key: QcGuardAddAgentComponent.COMP_KEY,
    configModel: NoneConfigModel,
    componentGroup: QcComponentGroup.qcGuardAddAgentComponentKey,
    params: AddAgentCompParamKeys.values,
    paramModel: AddAgentCompParam)
class QcGuardAddAgentComponent extends StatelessComponent<NoneConfigModel> {
  static const String COMP_KEY = "QC_guard_add_agent_component";

  const QcGuardAddAgentComponent(super.jsonConfig, {super.key});

  @override
  Widget buildView(BuildContext context, configModel) {
    return paramBuilder((paramModel) => ChangeNotifierProvider(
        create: (_) => AddAgentProvider(paramModel.agentList ?? []), child: const _AddAgentWidget()));
  }

  @override
  Function(Map<String, dynamic> data)? fromConfig() {
    return NoneConfigModel.fromConfig;
  }
}

class _AddAgentWidget extends StatelessWidget {
  const _AddAgentWidget({super.key});

  @override
  Widget build(BuildContext context) {
    var provider = AddAgentProvider.of(context);
    var l10n = L10n(context);
    return Padding(
      padding: const EdgeInsets.all(Dimens.space_16),
      child: CshCard(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CshTextNew.h3(l10n.agent),
            const SizedBox(height: Dimens.space_16),
            CshDropDown(
              items: provider.agentList,
              onChanged: provider.onAgentSelectionChange,
              selectedItem: provider.selectedAgent,
            ),
            const SizedBox(height: Dimens.space_16),
            Selector<AddAgentProvider, DropDownItem<bool>>(
              builder: (BuildContext context, value, Widget? child) {
                return Opacity(
                  opacity: value.id == '0' ? 0.5 : 1,
                  child: CshTextFormField(
                    controller: provider.textEditingController,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    keyboardType: TextInputType.number,
                    labelText: l10n.totalDevices,
                    enabled: value.id == '0' ? false : true,
                  ),
                );
              },
              selector: (context, provider) {
                return provider.selectedAgent;
              },
            ),
            const SizedBox(height: Dimens.space_16),
            Selector<AddAgentProvider, DropDownItem<bool>>(
              builder: (BuildContext context, value, Widget? child) {
                return CshBigButton(
                  text: l10n.save,
                  onPressed: value.id == '0' ? null : () => _onPressed(context, l10n),
                );
              },
              selector: (context, provider) {
                return provider.selectedAgent;
              },
            ),
          ],
        ),
      ),
    );
  }

  void _onPressed(BuildContext context, L10n l10n) {
    FocusManager.instance.primaryFocus?.unfocus();
    var provider = AddAgentProvider.of(context, listen: false);
    int value = int.tryParse(provider.textEditingController.text) ?? 0;

    if (provider.textEditingController.text.isEmpty) {
      CshSnackBar.error(context: context, message: l10n.pleaseEnterDeviceCount);
    } else if (value <= 0) {
      CshSnackBar.error(context: context, message: l10n.totalDeviceCountShouldNotBeZero);
    } else {
      _showAlert(context, int.tryParse(provider.textEditingController.text) ?? 0, provider.selectedAgent.label!);
    }
  }

  void _showAlert(BuildContext context, int count, String selectedAgent) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (dialogContext) {
        var theme = Theme.of(dialogContext);
        var l10n = L10n(context);
        final GlobalKey<FormState> formFieldKey = GlobalKey();
        var actionTextTheme = theme.textTheme.displaySmall?.copyWith(color: theme.primaryColor);
        return AlertDialog(
          title: CshTextNew.h3(l10n.totalDevice),
          content: Form(
            key: formFieldKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              children: [
                CshTextNew.h4(l10n.enterTotalDeviceAgain),
                const SizedBox(height: Dimens.space_8),
                CshTextFormField(
                  labelText: l10n.totalDevice,
                  hintText: '$count',
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value != '$count') {
                      return l10n.totalDeviceCountIsNotMatching;
                    }
                    return null;
                  },
                )
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: CshTextNew(
                l10n.cancel,
                textStyle: actionTextTheme,
              ),
            ),
            TextButton(
              onPressed: () {
                if (formFieldKey.currentState?.validate() == true) {
                  _navigateTo(context, count, selectedAgent);
                }
              },
              child: CshTextNew(
                l10n.ok,
                textStyle: actionTextTheme,
              ),
            ),
          ],
        );
      },
    );
  }

  void _navigateTo(BuildContext context, int count, String selectedAgent) {
    Navigator.pop(context); // dismiss alert dialog
    Navigator.pushNamed(context, GuardUploadInvoiceScreen.route,
        arguments: GuardUploadInvoiceScreen.arguments(selectedAgent, count));
  }
}
