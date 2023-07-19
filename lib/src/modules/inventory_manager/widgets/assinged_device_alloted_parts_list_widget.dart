import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';

import '../models/device_alloted_parts_response.dart';
import '../providers/assigned_device_details_provider.dart';
import '../screens/assigned_part_details_screen.dart';
import 'assingned_alloted_parts_item_widget.dart';

class AssignedDeviceAllottedPartsList extends StatelessWidget {
  final DeviceAllottedPartsResponse? dataModel;
  final String? errorMessage;
  final bool isLoading;

  const AssignedDeviceAllottedPartsList({
    Key? key,
    required this.isLoading,
    this.errorMessage,
    this.dataModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);

    var provider = AssignedDeviceDetailsProvider.of(context);
    return CshShimmer(
      show: isLoading,
      child: (!Validator.isNullOrEmpty(errorMessage))
          ? Center(
              child: Row(
                children: [
                  const SizedBox.shrink(),
                  Expanded(
                    child: Text(
                      errorMessage!,
                      style: theme.primaryTextTheme.headline4,
                    ),
                  )
                ],
              ),
            )
          : (!Validator.isListNullOrEmpty(dataModel?.allottedPartsList))
              ? ListView.separated(
                  itemBuilder: (context, index) {
                    return AssignedAllottedDeviceListItem(
                      dataModel: dataModel!.allottedPartsList![index],
                      onCardClicked: () async {
                        AssignedPartDetailsCompArguments arguments = AssignedPartDetailsCompArguments(
                            args: AssignedPartDetailsArguments(
                          assignDeviceDetailsData: provider.assignedDeviceDetails?.detailsData,
                          prid: dataModel!.allottedPartsList![index].prid ?? -1,
                        ));

                        await Navigator.of(context).pushNamed(AssignedPartDetailsScreen.route, arguments: arguments);
                        provider.refreshDataOnPage();
                      },
                    );
                  },
                  separatorBuilder: (context, index) {
                    return const SizedBox(height: Dimens.space_8);
                  },
                  itemCount: dataModel!.allottedPartsList!.length)
              : const SizedBox.shrink(),
    );
  }
}
