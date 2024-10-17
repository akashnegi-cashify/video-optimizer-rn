import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/qc/modules/qc_tester/lob_devices/providers/color_selection_provider.dart';
import 'package:flutter_trc/src/common/widgets/shimmer_list_widget.dart';
import 'package:flutter_trc/src/libraries/analytics/analytics_controller.dart';
import 'package:flutter_trc/src/libraries/analytics/events/color_selected_event.dart';
import 'package:flutter_trc/src/libraries/analytics/events/color_view_event.dart';

class ColorSelectionWidget extends StatelessWidget {
  final String? deviceBarcode;
  final Function(String color)? onColorSelected;

  ColorSelectionWidget(this.deviceBarcode, this.onColorSelected, {super.key}) {
    AnalyticsController.logEvent(ColorViewEvent(deviceBarcode));
  }

  @override
  Widget build(BuildContext context) {
    var provider = ColorSelectionProvider.of(context, listen: false);
    return FutureBuilder<List<String>?>(
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const ShimmerListWidget(itemCount: 3, itemHeight: Dimens.space_50);
        }

        if (snapshot.hasError) {
          return Center(
            child: CshTextNew.bodyText1(snapshot.error.toString()),
          );
        }

        var colors = snapshot.data!;
        String? selectedColor;

        return StatefulBuilder(
          builder: (BuildContext context, void Function(void Function()) setState) {
            return Padding(
              padding: const EdgeInsets.all(Dimens.space_16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: ListView.separated(
                      itemCount: colors.length,
                      shrinkWrap: true,
                      itemBuilder: (_, index) {
                        var item = colors[index];
                        return CshRadio<String>(
                          value: item,
                          groupValue: selectedColor,
                          title: GestureDetector(
                            child: CshTextNew.subTitle1(item),
                            onTap: () {
                              setState(() {
                                selectedColor = item;
                              });
                            },
                          ),
                          onChanged: (value) {
                            setState(() {
                              selectedColor = value;
                            });
                          },
                        );
                      },
                      separatorBuilder: (BuildContext context, int index) {
                        return const SizedBox(height: Dimens.space_8);
                      },
                    ),
                  ),
                  Center(
                    child: CshBigButton(
                      text: "Proceed",
                      onPressed: selectedColor == null
                          ? null
                          : () {
                              AnalyticsController.logEvent(ColorSelectedEvent(deviceBarcode, selectedColor));
                              onColorSelected?.call(selectedColor!);
                            },
                    ),
                  )
                ],
              ),
            );
          },
        );
      },
      future: provider.getDeviceColors(),
    );
  }
}
