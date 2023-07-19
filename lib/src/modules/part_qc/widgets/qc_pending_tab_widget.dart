import 'dart:async';

import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/src/modules/part_qc/providers/pq_provider.dart';
import 'package:flutter_trc/src/modules/part_qc/widgets/qc_part_list_widget.dart';

import '../l10n.dart';
import '../screens/pq_status_change_screen.dart';

class QcPendingTabWidget extends StatefulWidget {
  const QcPendingTabWidget({Key? key}) : super(key: key);

  @override
  State<QcPendingTabWidget> createState() => _QcPendingTabWidgetState();
}

class _QcPendingTabWidgetState extends State<QcPendingTabWidget> {
  @override
  void initState() {
    scheduleMicrotask(() {
      var provider = PartQcProvider.of(context, listen: false);
      provider.fetchQcPartList(pbr: "");
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var provider = PartQcProvider.of(context);
    var theme = Theme.of(context);
    var l10n = L10n(context);
    if (provider.isDataLoading) {
      return const Center(
        child: SizedBox(
          height: Dimens.space_30,
          width: Dimens.space_30,
          child: CircularProgressIndicator(),
        ),
      );
    } else if (provider.isDataLoading == false && !Validator.isNullOrEmpty(provider.errorMessage)) {
      return Center(
        child: Row(
          children: [
            const SizedBox.shrink(),
            Expanded(
              child: Text(
                provider.errorMessage,
                style: theme.primaryTextTheme.headline4,
                textAlign: TextAlign.center,
              ),
            )
          ],
        ),
      );
    } else {
      return Column(
        children: [
          const SizedBox.shrink(),
          Expanded(
            child: (!Validator.isListNullOrEmpty(provider.qcPartsListResponse?.dataList))
                ? ListView.separated(
                    padding: const EdgeInsets.symmetric(vertical: Dimens.space_12, horizontal: Dimens.space_8),
                    itemBuilder: (context, index) {
                      return QcPartListItemWidget(
                        dataModel: provider.qcPartsListResponse!.dataList![index],
                        onCardClicked: () async {
                          if (provider.qcPartsListResponse!.dataList![index].prid != null) {
                            PartQcPartStatusScreenArguments arg = PartQcPartStatusScreenArguments(
                                partDetails: provider.qcPartsListResponse!.dataList![index]);
                            await Navigator.of(context).pushNamed(PartQcPartStatusScreen.route, arguments: arg);
                            provider.fetchQcPartList(pbr: "");
                          } else {
                            CshSnackBar.error(context: context, message: l10n.noPridFound);
                          }
                        },
                      );
                    },
                    separatorBuilder: (context, index) {
                      return const SizedBox(height: Dimens.space_8);
                    },
                    itemCount: provider.qcPartsListResponse!.dataList!.length,
                  )
                : Center(
                    child: Text(
                      l10n.noDataFound,
                      style: theme.primaryTextTheme.headline4,
                    ),
                  ),
          )
        ],
      );
    }
  }
}
