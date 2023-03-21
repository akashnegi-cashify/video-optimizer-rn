import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../l10n.dart';
import '../models/return_part_response.dart';
import '../providers/return_item_status_provider.dart';
import '../widgets/return_list_item_widget.dart';

class ReturnStatusScreenArguments {
  final ReturnItemData? detailsModel;

  ReturnStatusScreenArguments({
    this.detailsModel,
  });
}

class ReturnStatusScreen extends StatelessWidget {
  static const String route = "/return_status_screen";

  const ReturnStatusScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var l10n = L10n(context);
    var arg = ModalRoute.of(context)?.settings.arguments as ReturnStatusScreenArguments;
    return ChangeNotifierProvider<ReturnItemStatusProvider>(
      create: (_) => ReturnItemStatusProvider(arg.detailsModel?.prid),
      lazy: false,
      builder: (BuildContext innerContext, __) {
        return Scaffold(
          appBar: CshHeader(
            l10n.itemStatus,
            showBackBtn: true,
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: Dimens.space_16, vertical: Dimens.space_12),
            child: Column(
              children: [
                ReturnListItemWidget(dataModel: arg.detailsModel),
                const Expanded(
                  child: SizedBox.shrink(),
                ),
                Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          _changeReturnItemStatus(innerContext, true, l10n);
                        },
                        child: Container(
                          height: Dimens.space_40,
                          color: theme.errorColor,
                          alignment: Alignment.center,
                          child: Text(
                            l10n.faultySpare,
                            style: theme.primaryTextTheme.headline6?.copyWith(color: theme.cardColor),
                            textAlign: TextAlign.center,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: Dimens.space_16),
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          _changeReturnItemStatus(innerContext, false, l10n);
                        },
                        child: Container(
                          height: Dimens.space_40,
                          color: theme.primaryColor,
                          alignment: Alignment.center,
                          child: Text(
                            l10n.sendPartBackToInventory,
                            style: theme.primaryTextTheme.headline6?.copyWith(color: theme.cardColor),
                            textAlign: TextAlign.center,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }

  _changeReturnItemStatus(BuildContext context, bool isFaulty, L10n l10n) {
    var provider = ReturnItemStatusProvider.of(context, listen: false);
    CshLoading().showLoading(context);
    provider.updateReturnPartItemStatus(isFaulty).then((value) {
      CshLoading().hideLoading(context);
      if (value) {
        CshSnackBar.success(context: context, message: l10n.statusChangedSuccessfully);
        Navigator.of(context).pop(true);
      }
    }, onError: (error) {
      CshLoading().hideLoading(context);
      CshSnackBar.error(context: context, message: error);
    });
  }
}
