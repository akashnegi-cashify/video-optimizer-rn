import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/src/modules/engineer/my_devices/wip_devices/models/engineer_part_info.dart';
import 'package:flutter_trc/src/modules/engineer/retreived_parts/widgets/retrieved_part_details_item_widget.dart';

import '../../models/retreived_part_required_list_reponse.dart';
import '../../my_devices/wip_devices/view_parts/widgets/assigned_parts_screen.dart';
import '../l10n.dart';
import '../providers/retrieved_part_data_provider.dart';
import '../utils/retrieved_parts_utils.dart';

class RetrievedPartsDataDetailsWidget extends StatefulWidget {
  final RetrievedPartRequiredResponse? dataModel;
  final EngineerPartInfo? partInfo;

  const RetrievedPartsDataDetailsWidget({
    super.key,
    this.dataModel,
    this.partInfo,
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
        Expanded(child: RetrievedPartDetailsItemWidget(itemModel: widget.partInfo)),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: Dimens.space_16),
          child: SizedBox(
            width: double.infinity,
            child: CshMediumButton(
              text: l10n.submit,
              onPressed: () {
                if (!provider.isMandatoryFieldsSubmitted()) {
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
      Navigator.popUntil(context, ModalRoute.withName(AssignedPartsScreen.route));
      Navigator.of(context).pushReplacementNamed(AssignedPartsScreen.route,
          arguments: AssignedPartsData(true, deviceBarcode: provider.deviceBarcode));
    }, onError: (error) {
      CshLoading().hideLoading(context);
      CshSnackBar.error(context: context, message: error);
    });
  }
}
