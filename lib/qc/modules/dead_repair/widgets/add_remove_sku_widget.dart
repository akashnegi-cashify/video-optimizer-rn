import 'dart:async';

import 'package:core/core.dart';
import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:provider/provider.dart';
import '../../../../src/common/utils/csh_ml_scanner_util.dart';
import '../l10n.dart';
import '../providers/index.dart';
class AddRemoveSKU extends StatelessWidget {
  const AddRemoveSKU({super.key});

  @override
  Widget build(BuildContext context) {
    var l10n = L10n(context);
    var theme = Theme.of(context);
    var provider = DeviceDeadAcceptRejectProvider.of(context, listen: false);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: [
        CshTextNew.h4(l10n.repairPartSkUs),
        const SizedBox(height: Dimens.space_6),
        Flexible(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Flexible(
                flex: 2,
                child: CshTextFormField(
                  controller: provider.skuTextEditingController,
                  labelText: l10n.partSkUs,
                  helperText: null,
                  onChanged: (value) {
                    provider.isTextFieldEmpty = value.isEmpty;
                  },
                ),
              ),
              const SizedBox(width: Dimens.space_8),
              ValueListenableBuilder(
                  valueListenable: provider.skuTextEditingController,
                  builder: (context, value, child) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: Dimens.space_2),
                      child: CshBigButton(
                        text: value.text.isEmpty ? l10n.scan : l10n.add,
                        onPressed: () => value.text.isEmpty
                            ? _openScanner(context)
                            : addRemovePart(
                          context,
                          provider.skuTextEditingController.text,
                          true,
                        ),
                      ),
                    );
                  }),
            ],
          ),
        ),
        const SizedBox(height: Dimens.space_8),
        CshTextNew.h5(l10n.scanOneByOneSkus),
        const SizedBox(height: Dimens.space_8),
        Flexible(
          child: Selector<DeviceDeadAcceptRejectProvider, int>(
            selector: (context, provider) {
              return provider.skuList.length;
            },
            builder: (BuildContext context, value, Widget? child) {
              var provider = DeviceDeadAcceptRejectProvider.of(context, listen: false);

              return ScrollConfiguration(
                 behavior: const ScrollBehavior().copyWith(overscroll: false),
                child: ListView.separated(
                  shrinkWrap: true,
                  physics: const ScrollPhysics(),
                  itemBuilder: (context, index) {
                    return CshCard(
                      child: Row(
                        children: [
                          Expanded(child: CshTextNew.h3(provider.skuList[index])),
                          const SizedBox(width: Dimens.space_4),
                          CshIcon(
                            FeatherIcons.trash2,
                            padding: const EdgeInsets.all(Dimens.space_4),
                            iconColor: theme.colorScheme.error,
                            onClick: () {
                              addRemovePart(context, provider.skuList[index], false);
                            },
                          ),
                        ],
                      ),
                    );
                  },
                  separatorBuilder: (context, index) {
                    return const SizedBox(height: Dimens.space_12);
                  },
                  itemCount: value,
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  void _openScanner(BuildContext context) {
    CshMlScannerUtil().openScanner(context, onScanned: (value, controller) {
      addRemovePart(context, value.trim(), true).then((value) {
        Navigator.pop(context);
      });
    });
  }

  Future addRemovePart(BuildContext context, String sku, bool isAdd) {
    CshLoading().showLoading(context);
    FocusManager.instance.primaryFocus?.unfocus();
    var provider = DeviceDeadAcceptRejectProvider.of(context, listen: false);
    provider.skuTextEditingController.clear();
    var completer = Completer();
    provider.addRemovePart(sku, isAdd).listen((event) {
      CshLoading().hideLoading(context);
      if (event?.isValid == true) {
        var msg = event?.confirmMessage ?? "Success";
        CshSnackBar.success(context: context, message: msg);

        if (isAdd) {
          provider.addSku(sku);
        } else {
          provider.removeSku(sku);
        }

        completer.complete(msg);
      } else {
        var errorMsg = event?.confirmMessage ?? "Something Want Wrong";
        CshSnackBar.error(context: context, message: errorMsg);
        completer.completeError(errorMsg);
      }
    }, onError: (error, stackTrace) {
      var errorMsg = ApiErrorHelper.getErrorMessage(error) ?? "Something Want Wrong";
      Logger.debug('DeviceDeadAcceptRejectProvider.addPart', [errorMsg]);
      CshLoading().hideLoading(context);
      CshSnackBar.error(context: context, message: errorMsg);
      completer.completeError(errorMsg);
    });

    return completer.future;
  }
}
