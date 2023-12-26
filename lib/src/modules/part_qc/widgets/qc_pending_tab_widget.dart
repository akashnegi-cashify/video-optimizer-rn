import 'dart:async';

import 'package:core/core.dart';
import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/src/common/utils/csh_ml_scanner_util.dart';
import 'package:flutter_trc/src/modules/part_qc/models/qc_parts_list_response.dart';
import 'package:flutter_trc/src/modules/part_qc/providers/pq_provider.dart';
import 'package:flutter_trc/src/modules/part_qc/widgets/qc_part_list_widget.dart';

import '../l10n.dart';

class QcPendingTabWidget extends StatefulWidget {
  const QcPendingTabWidget({Key? key}) : super(key: key);

  @override
  State<QcPendingTabWidget> createState() => _QcPendingTabWidgetState();
}

class _QcPendingTabWidgetState extends State<QcPendingTabWidget> {
  final _barcodeController = TextEditingController();
  final TextInputDebounce _debounce = TextInputDebounce();

  @override
  void initState() {
    scheduleMicrotask(() {
      var provider = PartQcProvider.of(context, listen: false);
      provider.fetchQcPartList();
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
          Padding(
            padding: const EdgeInsets.fromLTRB(Dimens.space_16, Dimens.space_16, Dimens.space_16, 0),
            child: CshTextFormField(
              hintText: "Search Barcode",
              hintStyle: theme.textTheme.labelSmall,
              controller: _barcodeController,
              onChanged: (_) {
                _debounce.start(() {
                  Logger.debug('mydebug-----_QcPendingTabWidgetState.build', [_barcodeController.text]);
                  _onSearch(provider);
                });
              },
              suffixIcon: InkWell(
                child: const Icon(Icons.qr_code_2),
                onTap: () {
                  CshMlScannerUtil().openScanner(context, onScanned: (scannedData, controller) {
                    Navigator.pop(context); // close scanner
                    _barcodeController.text = scannedData;
                    _onSearch(provider);
                  });
                },
              ),
            ),
          ),
          Expanded(
            child: (!Validator.isListNullOrEmpty(provider.partList))
                ? ListView.separated(
                    padding: const EdgeInsets.all(Dimens.space_16),
                    itemBuilder: (context, index) {
                      var item = provider.partList![index];
                      return QcPartListItemWidget(
                        dataModel: item,
                        onCardClicked: (bool isFaulty) async {
                          if (item.prid != null) {
                            _showUnlinkModal(context, theme, l10n, isFaulty, provider, item);
                          } else {
                            CshSnackBar.error(context: context, message: l10n.noPridFound);
                          }
                        },
                      );
                    },
                    separatorBuilder: (context, index) {
                      return const SizedBox(height: Dimens.space_8);
                    },
                    itemCount: provider.partList!.length,
                  )
                : Center(
                    child: Text(
                      l10n.noDataFound,
                      style: theme.primaryTextTheme.headlineMedium,
                    ),
                  ),
          )
        ],
      );
    }
  }

  _onSearch(PartQcProvider provider) {
    CshLoading().showLoading(context);
    provider.fetchQcPartList(pbr: _barcodeController.text).then((value) {
      CshLoading().hideLoading(context);
    }, onError: (error) {
      CshLoading().hideLoading(context);
      CshSnackBar.error(context: context, message: error);
    });
  }

  _showUnlinkModal(
      BuildContext context, ThemeData theme, L10n l10n, bool isFaulty, PartQcProvider provider, QcPartListData item) {
    showCshBottomSheet(
      context: context,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: Dimens.space_12, horizontal: Dimens.space_16),
        child: Column(
          children: [
            Text(
              isFaulty
                  ? l10n.areYouSureYouWantToMarkPartAsFaulty(item.partBarcode ?? "part")
                  : l10n.areYouSureYouWantToMarkPartAsOk(item.partBarcode ?? "part"),
              style: theme.primaryTextTheme.displaySmall,
            ),
            const SizedBox(height: Dimens.space_16),
            ComboButton(
              firstBtnText: l10n.no,
              secondBtnText: l10n.yes,
              buttonType: ButtonType.mini,
              isFirstPrimary: true,
              firstBtnClick: () {
                Navigator.of(context).pop();
              },
              secondBtnClick: () {
                Navigator.of(context).pop();
                _updatePartStatus(context, isFaulty, l10n, provider, item.prid!);
              },
            )
          ],
        ),
      ),
    );
  }

  _updatePartStatus(BuildContext context, bool isFaulty, L10n l10n, PartQcProvider provider, int prid) {
    CshLoading().showLoading(context);
    provider.updatePartStatus(isFaulty, prid).then((value) {
      CshLoading().hideLoading(context);
      if (value) {
        provider.fetchQcPartList(isForceRefreshScreen: true);
        CshSnackBar.success(context: context, message: l10n.statusUpdatedSuccessfully);
      }
    }, onError: (error) {
      CshLoading().hideLoading(context);
      CshSnackBar.error(context: context, message: error);
    });
  }

  @override
  void dispose() {
    _barcodeController.dispose();
    _debounce.stop();
    super.dispose();
  }
}
