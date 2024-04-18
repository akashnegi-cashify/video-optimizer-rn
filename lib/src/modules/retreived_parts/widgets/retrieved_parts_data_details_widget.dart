import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/src/modules/retreived_parts/widgets/retrieved_part_details_item_widget.dart';

import '../../engineer/models/retreived_part_required_list_reponse.dart';
import '../l10n.dart';
import '../providers/retrieved_part_data_provider.dart';
import '../utils/retrieved_parts_utils.dart';

class RetrievedPartsDataDetailsWidget extends StatefulWidget {
  final RetrievedPartRequiredResponse? dataModel;

  const RetrievedPartsDataDetailsWidget({
    super.key,
    this.dataModel,
  });

  @override
  State<RetrievedPartsDataDetailsWidget> createState() => _RetrievedPartsDataDetailsWidgetState();
}

class _RetrievedPartsDataDetailsWidgetState extends State<RetrievedPartsDataDetailsWidget> {
  @override
  Widget build(BuildContext context) {
    var l10n = L10n(context);
    var provider = RetrievedPartsDataProviders.of(context);
    return Column(
      children: [
        const SizedBox.shrink(),
        Expanded(
          child: ListView.separated(
            padding: const EdgeInsets.symmetric(vertical: Dimens.space_12, horizontal: Dimens.space_16),
            itemBuilder: (BuildContext context, int index) {
              return RetrievedPartDetailsItemWidget(itemModel: provider.partList[index]);
            },
            separatorBuilder: (BuildContext context, int index) {
              return const SizedBox(height: Dimens.space_12);
            },
            itemCount: provider.partList.length,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: Dimens.space_16),
          child: SizedBox(
            width: double.infinity,
            child: CshMediumButton(
              text: l10n.submit,
              onPressed: () {
                if (RetrievedPartsUtils.checkForMandatoryFields(widget.dataModel?.data?.partList) == false) {
                  CshSnackBar.error(
                    context: context,
                    message: l10n.completeRequiredFieldToSubmit,
                    duration: SnackBarDuration.SHORT,
                    snackBarPosition: SnackBarPosition.TOP,
                  );
                } else {
                  List<Map<String, dynamic>> data = provider.getBodyData();

                  if (Validator.isTrue(provider.isDeviceInProgress)) {
                    Map<String, dynamic> bodyData = {"rpd": data};
                    _updatePartsData(bodyData);
                  } else {
                    _orderParts();
                  }
                }
              },
            ),
          ),
        )
      ],
    );
  }

  _updatePartsData(Map<String, dynamic> data) {
    var provider = RetrievedPartsDataProviders.of(context, listen: false);
    CshLoading().showLoading(context);
    provider.updatePartsData(data).then((value) {
      CshLoading().hideLoading(context);
      _sendDeviceToInProgress();
    }, onError: (error) {
      CshLoading().hideLoading(context);
      CshSnackBar.error(context: context, message: error);
    });
  }

  _sendDeviceToInProgress() {
    CshLoading().showLoading(context);
    var provider = RetrievedPartsDataProviders.of(context, listen: false);
    provider.sendDeviceToInProgress().then((value) {
      CshLoading().hideLoading(context);
      CshSnackBar.success(context: context, message: "Data Updated and Sent to InProgress");
      Navigator.of(context).pop();
    }, onError: (error) {
      CshLoading().hideLoading(context);
      CshSnackBar.error(context: context, message: error);
    });
  }

  _orderParts() {
    CshLoading().showLoading(context);
    var provider = RetrievedPartsDataProviders.of(context, listen: false);
    provider.orderPartsWithRetrievedData().then((value) {
      CshLoading().hideLoading(context);
      CshSnackBar.success(context: context, message: "Parts Ordered Successfully");
      Navigator.of(context).pop();
      Navigator.of(context).pop();
    }, onError: (error) {
      CshLoading().hideLoading(context);
      CshSnackBar.error(context: context, message: error);
    });
  }
}
