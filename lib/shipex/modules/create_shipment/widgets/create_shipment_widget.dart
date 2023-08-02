import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/shipex/modules/create_shipment/models/box_list_response.dart';

import '../l10n.dart';
import '../models/create_shipment_param.dart';
import '../models/shipment_provider_list_response.dart';
import '../models/suborder_group_list_response.dart';
import '../providers/create_shipment_provider.dart';
import '../screen/create_manual_shipment_screen.dart';
import 'order_group_card_widget.dart';

class CreateShipmentWidget extends StatelessWidget {
  final CreateShipmentParam? paramModel;

  const CreateShipmentWidget({
    super.key,
    this.paramModel,
  });

  @override
  Widget build(BuildContext context) {
    var provider = CreateShipmentProvider.of(context);

    var l10n = L10n(context);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: Dimens.space_12, horizontal: Dimens.space_16),
      child: Column(
        children: [
          OrderGroupWidget(
            dataModel:
                SubOrderGroupListData(null, paramModel?.lotName, null, null, null, paramModel?.devicesQuantity, null),
          ),
          const SizedBox(height: Dimens.space_12),
          CshShimmer(
            show: provider.boxDataLoading,
            child: (!Validator.isListNullOrEmpty(provider.boxList))
                ? CshDropDown(
                    hintText: l10n.selectBox,
                    onChanged: (DropDownItem item) {
                      provider.onBoxChange(BoxListData(id: int.parse(item.id!), boxName: item.label));
                    },
                    selectedItem: DropDownItem(provider.boxList?.first.id.toString(), provider.boxList?.first.boxName),
                    items: List.generate(
                      provider.boxList!.length,
                      (index) => DropDownItem(provider.boxList![index].id.toString(), provider.boxList![index].boxName),
                    ),
                  )
                : const SizedBox.shrink(),
          ),
          const SizedBox(height: Dimens.space_12),
          CshShimmer(
            show: (provider.providerDataListLoading || provider.estimatedProviderDataLoading),
            child: (!Validator.isListNullOrEmpty(provider.providerList))
                ? CshDropDown(
                    hintText: l10n.selectBox,
                    onChanged: (DropDownItem data) {
                      provider.onProviderChange(ShipmentProviderListData(key: data.id, name: data.label));
                    },
                    selectedItem: provider.estimatedProvider != null
                        ? DropDownItem(provider.estimatedProvider?.key, provider.estimatedProvider?.name)
                        : null,
                    items: List.generate(
                      provider.providerList!.length,
                      (index) => DropDownItem(provider.providerList![index].key, provider.providerList![index].name),
                    ),
                  )
                : const SizedBox.shrink(),
          ),
          const Expanded(child: SizedBox.shrink()),
          SizedBox(
            width: double.infinity,
            child: CshMediumButton(
              text: l10n.update,
              onPressed: () {
                CreateManualShipmentScreenArguments args = CreateManualShipmentScreenArguments(
                    facilityId: paramModel?.facilityId,
                    boxId: provider.selectedBox?.id,
                    isManualShipment: true,
                    pinCode: paramModel?.pinCode ?? "",
                    shipmentId: paramModel?.shipmentId ?? 0,
                    groupId: (!Validator.isNullOrEmpty(paramModel?.groupId)) ? int.parse(paramModel!.groupId!) : 0);
                Navigator.of(context).pushNamed(CreateManualShipmentScreen.route, arguments: args);
              },
            ),
          ),
          const SizedBox(height: Dimens.space_8),
          SizedBox(
            width: double.infinity,
            child: CshMediumButton(
              text: l10n.createManualShipment,
              onPressed: () {
                if (provider.selectedBox == null) {
                  CshSnackBar.error(context: context, message: "Select Box To proceed");
                } else {
                  CreateManualShipmentScreenArguments args = CreateManualShipmentScreenArguments(
                      facilityId: paramModel?.facilityId,
                      boxId: provider.selectedBox?.id,
                      isManualShipment: false,
                      shipmentId: paramModel?.shipmentId ?? 0,
                      pinCode: paramModel?.pinCode ?? "",
                      groupId: (!Validator.isNullOrEmpty(paramModel?.groupId)) ? int.parse(paramModel!.groupId!) : 0);
                  Navigator.of(context).pushNamed(CreateManualShipmentScreen.route, arguments: args);
                }
              },
            ),
          ),
          const SizedBox(height: Dimens.space_8),
          SizedBox(
            width: double.infinity,
            child: CshMediumButton(
              text: l10n.generate,
              onPressed: () {
                _generateShipment(context,
                    facilityId: (paramModel?.facilityId != null) ? paramModel!.facilityId!.toString() : "",
                    groupId: (!Validator.isNullOrEmpty(paramModel?.groupId)) ? int.parse(paramModel!.groupId!) : 0);
              },
            ),
          ),
          const SizedBox(height: Dimens.space_8),
          SizedBox(
            width: double.infinity,
            child: CshMediumButton(
              text: l10n.exit,
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ),
        ],
      ),
    );
  }

  _generateShipment(context, {required String facilityId, required int groupId}) {
    var provider = CreateShipmentProvider.of(context, listen: false);
    CshLoading().showLoading(context);
    provider.generateShipment(facilityId, groupId).then((value) {
      CshLoading().hideLoading(context);
      if (value) {
        CshSnackBar.success(context: context, message: "Shipment Generated");
        Navigator.of(context).pop();
      }
    }, onError: (error) {
      CshLoading().hideLoading(context);
      CshSnackBar.error(context: context, message: error);
    });
  }
}
