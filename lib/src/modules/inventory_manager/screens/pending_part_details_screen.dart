import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_trc/src/modules/inventory_manager/screens/alternate_part_screen.dart';
import 'package:provider/provider.dart';
import '../l10n.dart';
import '../models/assigned_device_details.dart';
import '../models/pending_device_list_response.dart';
import '../providers/pending_parts_details_provider.dart';
import '../resources/part_status_enum.dart';
import '../widgets/part_details_button_widget.dart';
import '../widgets/pending_part_details_info_widget.dart';
import 'assign_part_barcode_scanner.dart';
import 'assigned_part_details_screen.dart';

class PendingPartDetailsScreenArguments {
  final PendingDeviceDetailData? detailsModelData;
  final int prid;
  final int statusCode;

  PendingPartDetailsScreenArguments({
    required this.prid,
    this.detailsModelData,
    required this.statusCode,
  });
}

class PendingPartDetailsScreen extends StatelessWidget {
  static const String route = '/pending_part_details_screen';

  const PendingPartDetailsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var l10n = L10n(context);
    PendingPartDetailsScreenArguments args =
        ModalRoute.of(context)?.settings.arguments as PendingPartDetailsScreenArguments;

    return ChangeNotifierProvider<PendingPartDetailsProvider>(
      create: (_) => PendingPartDetailsProvider(args.prid, args.statusCode),
      lazy: false,
      builder: (BuildContext insideContext, __) {
        var provider = PendingPartDetailsProvider.of(insideContext);
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
        } else if (provider.isDataLoading == false && !Validator.isNullOrEmpty(provider.errorMessage)) {
          return Scaffold(
            appBar: CshHeader(
              l10n.pendingPartDetails,
              showBackBtn: true,
            ),
            body: Center(
              child: Row(
                children: [
                  const SizedBox.shrink(),
                  Expanded(
                    child: Text(
                      provider.errorMessage,
                      style: theme.primaryTextTheme.headline4,
                    ),
                  )
                ],
              ),
            ),
          );
        } else {
          return Scaffold(
            appBar: CshHeader(
              l10n.pendingPartDetails,
              showBackBtn: true,
            ),
            body: Padding(
              padding: const EdgeInsets.symmetric(vertical: Dimens.space_8, horizontal: Dimens.space_16),
              child: Column(
                children: [
                  _detailsWidget(args.detailsModelData, l10n, theme),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: Dimens.space_16),
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: CshIconButton(
                        text: l10n.sync,
                        prefixIcon: CshIcon(
                          FeatherIcons.refreshCw,
                          padding: const EdgeInsets.only(right: Dimens.space_6),
                          iconColor: theme.backgroundColor,
                          iconSize: MobileIconSize.medium,
                        ),
                        onPressed: () {
                          provider.syncData();
                        },
                      ),
                    ),
                  ),
                  PendingPartDetailsInfoWidget(
                    detailsData: provider.partsDetailsResponse?.partsDetails,
                    suggestedBarcode: provider.recommendedPartResponse?.dataResponse?.barcode,
                  ),
                  const Expanded(
                    child: SizedBox.shrink(),
                  ),
                  PartDetailsButtonWidget(
                    statusCode: args.statusCode,
                    cancelBtnOnPressed: () {
                      if (args.prid != null) {
                        _showCancelModal(insideContext, theme, l10n, args.prid);
                      } else {
                        CshSnackBar.error(context: context, message: l10n.pridIsNotPresent);
                      }
                    },
                    assignBtnOnPressed: () {
                      if (provider.partsDetailsResponse?.partsDetails?.prid != null) {
                        AssignBarcodeScannerArguments arguments = AssignBarcodeScannerArguments(
                            pendingDeviceDetailData: args.detailsModelData,
                            detailsData: provider.partsDetailsResponse?.partsDetails,
                            prid: provider.partsDetailsResponse!.partsDetails!.prid!);
                        Navigator.of(context).pushNamed(AssignBarcodeScannerScreen.route, arguments: arguments);
                      } else {
                        CshSnackBar.error(context: context, message: l10n.pridIsNotPresent);
                      }
                    },
                    deadPartOnPressed: () {
                      if (args.prid != null) {
                        _showLinkDeadPartModal(insideContext, theme, l10n, args.prid, args);
                      } else {
                        CshSnackBar.error(context: context, message: l10n.pridIsNotPresent);
                      }
                    },
                    alternatePartBtnOnPressed: () async {
                      if (args.prid != null) {
                        AlternatePartArguments arg = AlternatePartArguments(
                          prid: args.prid,
                          detailsModelData: args.detailsModelData,
                          itemDataModel: provider.partsDetailsResponse?.partsDetails,
                        );
                        await Navigator.of(context).pushNamed(AlternatePartScreen.route, arguments: arg);
                        provider.syncData();
                      } else {
                        CshSnackBar.error(context: context, message: l10n.pridIsNotPresent);
                      }
                    },
                  ),
                ],
              ),
            ),
          );
        }
      },
    );
  }

  _detailsWidget(PendingDeviceDetailData? detailsModelData, L10n l10n, ThemeData theme) {
    return CshCard(
      radius: CshRadius.rad8,
      elevation: CardElevation.dimen_10,
      child: Column(
        children: [
          if (!Validator.isNullOrEmpty(detailsModelData?.deviceBarcode)) ...[
            _labelValueWidget(theme, l10n.deviceBarcode, detailsModelData!.deviceBarcode!),
            const SizedBox(height: Dimens.space_8),
          ],
          if (!Validator.isNullOrEmpty(detailsModelData?.engineerName)) ...[
            _labelValueWidget(theme, l10n.engineerSName, detailsModelData!.engineerName!),
            const SizedBox(height: Dimens.space_8),
          ],
          if (!Validator.isNullOrEmpty(detailsModelData?.pt)) ...[
            _labelValueWidget(theme, l10n.deviceName, detailsModelData!.pt!),
            const SizedBox(height: Dimens.space_8),
          ],
          if (!Validator.isNullOrEmpty(detailsModelData?.lc)) ...[
            _labelValueWidget(theme, l10n.location, detailsModelData!.lc!),
            const SizedBox(height: Dimens.space_8),
          ],
        ],
      ),
    );
  }

  _showLinkDeadPartModal(
      BuildContext context, ThemeData theme, L10n l10n, int prid, PendingPartDetailsScreenArguments arg) {
    showCshBottomSheet(
      context: context,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: Dimens.space_12, horizontal: Dimens.space_16),
        child: Column(
          children: [
            Text(
              l10n.areYouSureYouWantToLinkDeadPart,
              style: theme.primaryTextTheme.headline3,
            ),
            const SizedBox(height: Dimens.space_16),
            ComboButton(
              firstBtnText: l10n.no,
              secondBtnText: l10n.yes,
              buttonType: ButtonType.mini,
              isFirstPrimary: true,
              firstBtnClick: () {
                Navigator.of(context).pop(true);
              },
              secondBtnClick: () {
                Navigator.of(context).pop();
                _linkDeadPart(context, theme, l10n, prid, arg);
              },
            )
          ],
        ),
      ),
    );
  }

  _showCancelModal(BuildContext context, ThemeData theme, L10n l10n, int prid) {
    showCshBottomSheet(
      context: context,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: Dimens.space_12, horizontal: Dimens.space_16),
        child: Column(
          children: [
            Text(
              l10n.areYouSureYouWantToCancel,
              style: theme.primaryTextTheme.headline3,
            ),
            const SizedBox(height: Dimens.space_16),
            ComboButton(
              firstBtnText: l10n.no,
              secondBtnText: l10n.yes,
              buttonType: ButtonType.mini,
              isFirstPrimary: true,
              firstBtnClick: () {
                Navigator.of(context).pop(true);
              },
              secondBtnClick: () {
                Navigator.of(context).pop();
                _cancelPendingPartItem(context, theme, l10n, prid);
              },
            )
          ],
        ),
      ),
    );
  }

  _cancelPendingPartItem(BuildContext context, ThemeData theme, L10n l10n, int prid) {
    var provider = PendingPartDetailsProvider.of(context, listen: false);
    CshLoading().showLoading(context);
    provider.cancelPartItem(prid).then((value) {
      CshLoading().hideLoading(context);
      CshSnackBar.success(context: context, message: l10n.partCanceledSuccessfully);
    }, onError: (error) {
      CshLoading().hideLoading(context);
      CshSnackBar.error(context: context, message: error);
    });
  }

  _linkDeadPart(BuildContext context, ThemeData theme, L10n l10n, int prid, PendingPartDetailsScreenArguments arg) {
    var provider = PendingPartDetailsProvider.of(context, listen: false);
    CshLoading().showLoading(context);
    provider.linkDeadPart(prid).then((value) {
      CshLoading().hideLoading(context);
      if (value) {
        CshSnackBar.success(context: context, message: l10n.deadPartLinkedSuccessfully);
        AssignedPartDetailsArguments args = AssignedPartDetailsArguments(
          prid: arg.prid,
          assignDeviceDetailsData: AssignDeviceDetailsData(
            did: arg.detailsModelData?.did,
            lc: arg.detailsModelData?.lc,
            engineerName: arg.detailsModelData?.engineerName,
            deviceBarcode: arg.detailsModelData?.deviceBarcode,
            grade: arg.detailsModelData?.grade,
            repairType: arg.detailsModelData?.repairType,
            productName: arg.detailsModelData?.pt,
          ),
        );

        Navigator.of(context).pushReplacementNamed(AssignedPartDetailsScreen.route, arguments: args);
      }
    }, onError: (error) {
      CshLoading().hideLoading(context);
      CshSnackBar.error(context: context, message: error);
    });
  }

  _labelValueWidget(ThemeData theme, String label, String value) {
    return Row(
      children: [
        Expanded(
          child: Text(
            label,
            style: theme.primaryTextTheme.headline5?.copyWith(color: theme.primaryColor),
          ),
        ),
        const SizedBox(width: Dimens.space_8),
        Expanded(
          child: Text(
            value,
            textDirection: TextDirection.rtl,
            style: theme.primaryTextTheme.headline5,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}
