import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/src/modules/elss/common_screen/elss_home_screen.dart';
import 'package:flutter_trc/src/modules/elss/elss_qc/providers/elss_reject_retest_reason_selection_provider.dart';
import 'package:flutter_trc/src/modules/elss/elss_qc/resources/elss_status.dart';
import 'package:flutter_trc/src/modules/elss/elss_qc/resources/reject_retest_reason_list_response.dart';
import 'package:flutter_trc/src/modules/elss/elss_qc/screens/elss_status_screen.dart';
import 'package:provider/provider.dart';

import '../l10n.dart';

enum ReasonType { retest, reject }

showRejectRetestBottomSheetModal(
  BuildContext context,
  ReasonType type,
  String barcode,
) {
  showCshBottomSheet(
      isDismissible: true,
      isScrollControlled: true,
      context: context,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _RejectRetestReasonSelectionList(type, barcode),
        ],
      ));
}

class _RejectRetestReasonSelectionList extends StatefulWidget {
  final ReasonType type;
  final String barcode;

  const _RejectRetestReasonSelectionList(this.type, this.barcode, {Key? key}) : super(key: key);

  @override
  State<_RejectRetestReasonSelectionList> createState() => _RejectRetestReasonSelectionListState();
}

class _RejectRetestReasonSelectionListState extends State<_RejectRetestReasonSelectionList> {
  @override
  Widget build(BuildContext context) {
    var l10n = L10n(context);
    return ChangeNotifierProvider(
      create: (_) => ElssRejectRetestReasonSelectionProvider(widget.type),
      lazy: false,
      builder: (BuildContext providerContext, child) {
        var provider = ElssRejectRetestReasonSelectionProvider.of(providerContext);
        String title = provider.isReasonTypeReject ? l10n.selectRejectReasons : l10n.selectRetestReasons;
        return Padding(
          padding: const EdgeInsets.fromLTRB(Dimens.space_8, Dimens.space_20, Dimens.space_16, Dimens.space_20),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: Dimens.space_16),
                    child: CshTextNew.h3(title),
                  ),
                  CshIcon.assets(
                    "assets/images/ic_close.png",
                    iconSize: MobileIconSize.small,
                    onClick: () => Navigator.pop(context),
                  )
                ],
              ),
              const SizedBox(height: Dimens.space_4),
              provider.isShowErrorScreen()
                  ? Center(
                      child: Padding(
                      padding: const EdgeInsets.all(Dimens.space_16),
                      child: CshTextNew.h2(provider.screenErrorMessage ?? "Something went wrong"),
                    ))
                  : provider.isScreenLoading
                      ? const Center(
                          child: SizedBox(
                            height: Dimens.space_30,
                            width: Dimens.space_30,
                            child: CircularProgressIndicator(),
                          ),
                        )
                      : Container(
                          constraints: BoxConstraints(maxHeight: MediaQuery.of(context).size.height * 0.7),
                          child: ListView.builder(
                            shrinkWrap: true,
                            itemBuilder: (BuildContext context, int index) {
                              var item = provider.reasonList?[index];
                              return _ReasonListItems(
                                item,
                                onItemSelected: (value) {
                                  provider.onReasonItemSelected(value, item!.id!);
                                },
                              );
                            },
                            itemCount: provider.reasonList?.length ?? 0,
                          ),
                        ),
              const SizedBox(height: Dimens.space_16),
              if (!provider.isScreenLoading)
                SizedBox(
                  width: double.infinity,
                  child: CshMediumButton(
                    text: l10n.submit,
                    onPressed: () => _onSubmitButtonClicked(providerContext),
                  ),
                )
            ],
          ),
        );
      },
    );
  }

  _onSubmitButtonClicked(BuildContext providerContext) {
    var provider = ElssRejectRetestReasonSelectionProvider.of(providerContext, listen: false);
    if (!provider.isReasonSelected()) {
      CshSnackBar.error(context: context, message: "Select atleast one reason", snackBarPosition: SnackBarPosition.TOP);
      return;
    }

    CshLoading().showLoading(context);
    provider.submitElssRejectRetest(widget.barcode).then((value) {
      CshLoading().hideLoading(context);
      if (provider.isReasonTypeReject) {
        Navigator.pushReplacementNamed(
          context,
          ElssStatusScreen.routeName,
          arguments: ElssStatusScreenArg(elssStatus: ElssStatus.reject, barcode: widget.barcode),
        );
      } else {
        CshSnackBar.success(context: context, message: "Moved to Retesting successfully!!");
        Navigator.pushNamedAndRemoveUntil(context, ElssHomeScreen.route, (route) => false, arguments: true);
      }
    }, onError: (errorMessage) {
      CshLoading().hideLoading(context);
      CshSnackBar.error(context: context, message: errorMessage.toString(), snackBarPosition: SnackBarPosition.TOP);
    });
  }
}

class _ReasonListItems extends StatelessWidget {
  final RejectRetestReasonListItem? item;
  Function(bool? value)? onItemSelected;

  _ReasonListItems(this.item, {Key? key, this.onItemSelected}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CshCheckbox(
          isSelected: item?.isSelected ?? false,
          visualDensity: VisualDensity.standard,
          onChanged: (value) {
            if (onItemSelected != null) {
              onItemSelected!(value);
            }
          },
        ),
        GestureDetector(
            onTap: () {
              if (onItemSelected != null) {
                onItemSelected!(!(item!.isSelected));
              }
            },
            child: Padding(
              padding: const EdgeInsets.all(Dimens.space_8),
              child: CshTextNew.bodyText2(item?.label ?? ""),
            )),
      ],
    );
  }
}
