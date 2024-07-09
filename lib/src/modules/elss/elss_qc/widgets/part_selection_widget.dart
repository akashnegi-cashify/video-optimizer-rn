import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_trc/src/modules/elss/elss_qc/resources/elss_status.dart';
import 'package:flutter_trc/src/modules/elss/elss_qc/screens/elss_status_screen.dart';
import 'package:flutter_trc/src/modules/elss/elss_qc/widgets/reject_retest_reason_selection_modal.dart';

import '../../common_models/part_device_list.dart';
import '../l10n.dart';
import '../providers/elss_provider_qc.dart';
import '../screens/add_part_screen_qc.dart';
import '../screens/allowed_option_screen.dart';
import 'elss_device_details_widget.dart';
import 'elss_part_widget.dart';

class PartSelectionWidget extends StatelessWidget {
  final String barcode;

  const PartSelectionWidget({
    Key? key,
    required this.barcode,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var l10n = L10n(context);
    var theme = Theme.of(context);
    var provider = ELssProviderQc.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(Dimens.space_8),
                  child: ElssDeviceDetailsWidget(dataModel: provider.elssDeviceDetails?.deviceDetailsData),
                ),
                const SizedBox(height: Dimens.space_20),
                if (provider.elssDeviceDetails?.deviceDetailsData?.partAdditionAllowed ?? false)
                  Align(
                    alignment: Alignment.centerRight,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: Dimens.space_8),
                      child: CshIconButton(
                        text: l10n.addParts,
                        onPressed: () async {
                          AddPartScreenQcArguments args =
                              AddPartScreenQcArguments(scannedBarcode: barcode, elssPartList: provider.elssPartList);
                          var data = await Navigator.of(context).pushNamed(AddPartScreenQc.route, arguments: args);
                          if ((data is List<PartItemDataResponse>?) && !Validator.isListNullOrEmpty(data)) {
                            provider.addNewPartsFromAddParts(data!);
                          }
                        },
                        prefixIcon: CshIcon(
                          FeatherIcons.plus,
                          padding: EdgeInsets.zero,
                        ),
                      ),
                    ),
                  ),
                if (!Validator.isListNullOrEmpty(provider.elssPartList)) ...[
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: Dimens.space_16),
                    child: Text(l10n.deviceParts, style: theme.primaryTextTheme.headlineMedium),
                  ),
                  const SizedBox(height: Dimens.space_4),
                  ListView.separated(
                    padding: const EdgeInsets.all(Dimens.space_16),
                    shrinkWrap: true,
                    primary: false,
                    itemBuilder: (context, index) {
                      var item = provider.elssPartList[index];
                      return ElssPartWidget(
                        dataModel: item,
                        onOptionSelected: (int actionId) {
                          provider.searchItemDataUpdate(item.elssPartId!, actionConstant: actionId);
                        },
                      );
                    },
                    itemCount: provider.elssPartList.length,
                    separatorBuilder: (BuildContext context, int index) {
                      return const SizedBox(height: Dimens.space_16);
                    },
                  ),
                ] else
                  const SizedBox(height: Dimens.space_20),
              ],
            ),
          ),
        ),
        CshCard(
          radius: CshRadius.none,
          padding: const EdgeInsets.all(Dimens.space_16),
          child: Container(
            width: MediaQuery.of(context).size.width,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(Dimens.space_6),
                topRight: Radius.circular(Dimens.space_6),
              ),
            ),
            child: _BottomButtons(
              onAcceptClicked: _isEnableAcceptButton(provider) ? () => _submitDataForPartsLogic(l10n, context) : null,
              onRejectClicked: () => _onRejectElss(context),
              onRetestClicked: () => _onRetestingElss(context),
              isHideRejectButton: true,
            ),
          ),
        ),
      ],
    );
  }

  _isEnableAcceptButton(ELssProviderQc provider) {
    if (provider.isNonRepairTypeDevice()) {
      return true;
    }

    if (provider.isRepairTypeDevice()) {
      return provider.isElssPartsSelectedForRepair();
    }

    return false;
  }

  _onRejectElss(BuildContext context) {
    showRejectRetestBottomSheetModal(context, ReasonType.reject, barcode);
  }

  _onRetestingElss(BuildContext context) {
    showRejectRetestBottomSheetModal(context, ReasonType.retest, barcode);
  }

  _submitDataForPartsLogic(L10n l10n, BuildContext context) {
    var provider = ELssProviderQc.of(context, listen: false);
    CshLoading().showLoading(context);
    provider.submitPartsForLogic(barcode).then((isOptionsAllowed) {
      CshLoading().hideLoading(context);
      if (Validator.isTrue(isOptionsAllowed)) {
        CshSnackBar.success(
            context: context,
            message: l10n.partsSubmittedSuccessfully,
            duration: SnackBarDuration.SHORT,
            snackBarPosition: SnackBarPosition.TOP);
        AllowedOptionCompScreenArguments args = AllowedOptionCompScreenArguments(
            arguments: AllowedOptionScreeArguments(barcode, detailsDataModel: provider.elssDeviceDetails));

        Navigator.of(context).pushReplacementNamed(AllowedOptionScreen.route, arguments: args);
      } else {
        ElssStatusCompArguments args =
            ElssStatusCompArguments(arguments: ElssStatusScreenArg(elssStatus: ElssStatus.submit, barcode: barcode));
        Navigator.pushReplacementNamed(
          context,
          ElssStatusScreen.routeName,
          arguments: args,
        );
      }
    }, onError: (error) {
      CshSnackBar.error(context: context, message: error);
      CshLoading().hideLoading(context);
    });
  }
}

class _BottomButtons extends StatelessWidget {
  final VoidCallback onRejectClicked;
  final VoidCallback onRetestClicked;
  final VoidCallback? onAcceptClicked;
  final bool isHideRejectButton;

  const _BottomButtons({
    Key? key,
    required this.onRejectClicked,
    required this.onRetestClicked,
    required this.onAcceptClicked,
    required this.isHideRejectButton,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var l10n = L10n(context);
    var theme = Theme.of(context);
    return Column(
      children: [
        Row(
          children: [
            if (!Validator.isTrue(isHideRejectButton)) ...[
              Expanded(
                child: CshMediumOutlineButton(
                  text: l10n.reject,
                  borderColor: theme.colorScheme.error,
                  onPressed: onRejectClicked,
                  textColor: theme.colorScheme.error,
                ),
              ),
              const SizedBox(width: Dimens.space_20),
            ],
            Expanded(
              child: CshMediumOutlineButton(
                text: l10n.retest,
                onPressed: onRetestClicked,
              ),
            ),
          ],
        ),
        const SizedBox(height: Dimens.space_16),
        SizedBox(
          width: double.infinity,
          child: CshMediumButton(
            text: l10n.submit,
            onPressed: onAcceptClicked,
          ),
        )
      ],
    );
  }
}
