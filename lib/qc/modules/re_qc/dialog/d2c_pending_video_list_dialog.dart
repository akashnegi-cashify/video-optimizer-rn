import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';

void showD2cPendingVideoListDialog(BuildContext context, List<String> deviceList, {required VoidCallback onProceed}) {
  showCshBottomSheet(
    context: context,
    isDismissible: false,
    child: PopScope(
      canPop: false,
      child: Container(
        margin: const EdgeInsets.all(Dimens.space_16),
        constraints: BoxConstraints(maxHeight: MediaQuery.of(context).size.height * 0.7),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: Dimens.space_8),
            CshTextNew.subTitle1("Pending Videos"),
            const SizedBox(height: Dimens.space_24),
            Expanded(
              child: ListView.separated(
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  var item = deviceList[index];
                  return CshCard(
                    child: Row(
                      children: [
                        CshTextNew.bodyText1("Barcode: ", isPrimary: false),
                        const SizedBox(width: Dimens.space_24),
                        CshTextNew.subTitle1(item),
                      ],
                    ),
                  );
                },
                separatorBuilder: (BuildContext context, int index) {
                  return const SizedBox(height: Dimens.space_16);
                },
                itemCount: deviceList.length,
              ),
            ),
            CshBigButton(
              text: "Got it",
              onPressed: () {
                onProceed();
              },
            )
          ],
        ),
      ),
    ),
  );
}
