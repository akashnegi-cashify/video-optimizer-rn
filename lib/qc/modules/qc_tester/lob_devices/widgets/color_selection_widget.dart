import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/qc/modules/qc_tester/lob_devices/providers/color_selection_provider.dart';
import 'package:flutter_trc/src/common/widgets/shimmer_list_widget.dart';
import 'package:flutter_trc/src/libraries/analytics/analytics_controller.dart';
import 'package:flutter_trc/src/libraries/analytics/events/color_selected_event.dart';
import 'package:flutter_trc/src/libraries/analytics/events/color_view_event.dart';

class ColorSelectionWidget extends StatefulWidget {
  final String? deviceBarcode;
  final Function(String color)? onColorSelected;

  const ColorSelectionWidget(this.deviceBarcode, this.onColorSelected, {super.key});

  @override
  State<ColorSelectionWidget> createState() => _ColorSelectionWidgetState();
}

class _ColorSelectionWidgetState extends State<ColorSelectionWidget> {
  String? selectedColor;

  @override
  void initState() {
    AnalyticsController.logEvent(ColorViewEvent(widget.deviceBarcode));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var provider = ColorSelectionProvider.of(context);
    if (provider.isLoading) {
      return const ShimmerListWidget(itemCount: 3, itemHeight: Dimens.space_50);
    }

    if (!Validator.isNullOrEmpty(provider.screenError)) {
      return Center(
        child: CshTextNew.bodyText1(provider.screenError!),
      );
    }

    var colors = provider.deviceColors!;

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
                      AnalyticsController.logEvent(ColorSelectedEvent(widget.deviceBarcode, selectedColor));
                      widget.onColorSelected?.call(selectedColor!);
                    },
            ),
          )
        ],
      ),
    );
  }
}
