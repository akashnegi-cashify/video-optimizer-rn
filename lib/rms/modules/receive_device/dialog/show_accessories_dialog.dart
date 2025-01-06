import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';

import '../resources/accessories_data.dart';

Future showAccessoriesDialog(BuildContext context, List<AccessoriesData> accessoriesList,
    {required Function(List<AccessoriesData> selectedAccessories) onAccessoriesSelected}) {
  return showCshBottomSheet(
    isDismissible: true,
    context: context,
    child: StatefulBuilder(builder: (_, setState) {
      return Container(
        height: MediaQuery.of(context).size.height * 0.5,
        padding: const EdgeInsets.all(Dimens.space_16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const CshTextNew.h4("Select accessories"),
            const SizedBox(height: Dimens.space_24),
            Expanded(
              child: ListView.separated(
                itemCount: accessoriesList.length,
                itemBuilder: (_, index) {
                  var item = accessoriesList[index];
                  return CshCheckbox(
                    title: InkWell(
                        onTap: () {
                          setState(() {
                            item.isSelected = !item.isSelected;
                          });
                        },
                        child: CshTextNew.subTitle1(item.name)),
                    isSelected: item.isSelected,
                    onChanged: (value) {
                      setState(() {
                        item.isSelected = value!;
                      });
                    },
                  );
                },
                separatorBuilder: (BuildContext context, int index) {
                  return const SizedBox(height: Dimens.space_16);
                },
              ),
            ),
            const SizedBox(height: Dimens.space_16),
            Center(
              child: CshBigButton(
                text: "Proceed",
                onPressed: () {
                  accessoriesList.removeWhere((element) => element.isSelected == false);
                  onAccessoriesSelected(accessoriesList);
                },
              ),
            )
          ],
        ),
      );
    }),
  );
}
