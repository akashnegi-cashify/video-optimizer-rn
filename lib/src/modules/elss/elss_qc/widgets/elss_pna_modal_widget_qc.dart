import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import '../../common_models/elss_part.dart';
import '../../common_models/part_device_list.dart';
import '../../widgets/add_part_item_widget.dart';
import '../l10n.dart';

class ElssPnaModalWidgetQC extends StatelessWidget {
  final List<ElssPart> listOfSelectedParts;
  final Function(int, bool)? onCardSelectedCallback;
  final Function(List<ElssPart>)? onSubmitCallback;
  final VoidCallback? onAddPartButtonClicked;

  const ElssPnaModalWidgetQC({
    Key? key,
    required this.listOfSelectedParts,
    this.onCardSelectedCallback,
    this.onSubmitCallback,
    this.onAddPartButtonClicked,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var l10n = L10n(context);
    var theme = Theme.of(context);

    bool isPartListEmpty = Validator.isListNullOrEmpty(listOfSelectedParts);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: Dimens.space_12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: Dimens.space_16),
            child: Text(
              isPartListEmpty ? l10n.noPartsForPna : l10n.selectPartsForPna,
              style: theme.primaryTextTheme.headline3,
            ),
          ),
          const SizedBox(height: Dimens.space_8),
          SizedBox(
            width: double.infinity,
            height: 400.0,
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: Dimens.space_16, vertical: Dimens.space_8),
              itemBuilder: (context, index) {
                var partItem = PartItemDataResponse(
                  listOfSelectedParts[index].sku,
                  listOfSelectedParts[index].partColour,
                  listOfSelectedParts[index].partName,
                  partQuantity: listOfSelectedParts[index].quantity,
                  isCardSelected: false,
                );
                return AddPartItemList(
                  dataModel: partItem,
                  onPartSelected: (bool data) {
                    listOfSelectedParts[index].isPnaSelected = data;
                  },
                );
              },
              separatorBuilder: (context, index) {
                return const SizedBox(height: Dimens.space_8);
              },
              itemCount: listOfSelectedParts.length,
            ),
          ),
          ComboButton(
            padding: const EdgeInsets.fromLTRB(Dimens.space_16, Dimens.space_8, Dimens.space_16, 0.0),
            firstBtnText: l10n.cancel,
            secondBtnText: isPartListEmpty ? l10n.selectParts: l10n.submit,
            isFirstPrimary: true,
            buttonType: ButtonType.mini,
            firstBtnClick: () {
              Navigator.of(context).pop(true);
            },
            secondBtnClick: () {
              if (isPartListEmpty) {
                if (onAddPartButtonClicked != null) {
                  onAddPartButtonClicked!();
                }
                return;
              }

              var markedPnaList = isMarkedPnaList();
              if (Validator.isListNullOrEmpty(markedPnaList)) {
                CshSnackBar.error(
                  context: context,
                  message: l10n.checkMarkPartForPna,
                  snackBarPosition: SnackBarPosition.TOP,
                );
                return;
              }

              if (onSubmitCallback != null) {
                onSubmitCallback!(markedPnaList);
              }
            },
          )
        ],
      ),
    );
  }

  List<ElssPart> isMarkedPnaList() {
    return listOfSelectedParts.where((element) => element.isPnaSelected == true).toList();
  }
}
