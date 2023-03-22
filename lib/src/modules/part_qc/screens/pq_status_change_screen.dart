import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../l10n.dart';
import '../models/qc_parts_list_response.dart';
import '../providers/part_status_provider.dart';
import '../widgets/qc_part_list_widget.dart';

class PartQcPartStatusArguments {
  final QcPartListData? partDetails;

  PartQcPartStatusArguments({
    this.partDetails,
  });
}

class PartQcPartStatusScreen extends StatelessWidget {
  static const String route = "/part_qc_part_status_screen";

  const PartQcPartStatusScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var l10n = L10n(context);
    var arg = ModalRoute.of(context)?.settings.arguments as PartQcPartStatusArguments;
    return ChangeNotifierProvider<PartStatusProvider>(
      create: (_) => PartStatusProvider(arg.partDetails!.prid!),
      lazy: false,
      builder: (BuildContext innerContext, __) {
        return Scaffold(
          appBar: CshHeader(
            l10n.partStatus,
            showBackBtn: true,
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(vertical: Dimens.space_12, horizontal: Dimens.space_8),
            child: Column(
              children: [
                QcPartListItemWidget(dataModel: arg.partDetails),
                const Expanded(child: SizedBox.shrink()),
                ComboButton(
                  firstBtnText: l10n.faultySpare.toUpperCase(),
                  secondBtnText: l10n.spareOk.toUpperCase(),
                  buttonType: ButtonType.mini,
                  isFirstPrimary: true,
                  firstBtnClick: () {
                    _showUnlinkModal(innerContext, theme, l10n, true);
                  },
                  secondBtnClick: () {
                    _showUnlinkModal(innerContext, theme, l10n, false);
                  },
                )
              ],
            ),
          ),
        );
      },
    );
  }

  _showUnlinkModal(BuildContext context, ThemeData theme, L10n l10n, bool isFaulty) {
    showCshBottomSheet(
      context: context,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: Dimens.space_12, horizontal: Dimens.space_16),
        child: Column(
          children: [
            Text(
              isFaulty ? l10n.areYouSureYouWantToMarkPartAsFaulty : l10n.areYouSureYouWantToMarkPartAsOk,
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
                _updatePartStatus(context, isFaulty, l10n);
              },
            )
          ],
        ),
      ),
    );
  }

  _updatePartStatus(BuildContext context, bool isFaulty, L10n l10n) {
    var provider = PartStatusProvider.of(context, listen: false);

    CshLoading().showLoading(context);

    provider.updatePartStatus(isFaulty).then((value) {
      CshLoading().hideLoading(context);
      if (value) {
        CshSnackBar.success(context: context, message: l10n.statusUpdatedSuccessfully);
        Navigator.of(context).pop(true);
      }
    }, onError: (error) {
      CshLoading().hideLoading(context);
      CshSnackBar.error(context: context, message: error);
    });
  }
}
