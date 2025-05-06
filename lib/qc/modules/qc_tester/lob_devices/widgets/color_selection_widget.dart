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
  String? selectedDeviceColor;
  String? selectedStrapColor;

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
    var theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.all(Dimens.space_16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  CshTextNew.subTitle1("Device/Dial Color"),
                  const SizedBox(height: Dimens.space_8),
                  ListView.separated(
                    itemCount: colors.length,
                    shrinkWrap: true,
                    itemBuilder: (_, index) {
                      var item = colors[index];
                      return CshRadio<String>(
                        value: item,
                        groupValue: selectedDeviceColor,
                        title: GestureDetector(
                          child: CshTextNew.subTitle1(item),
                          onTap: () {
                            setState(() {
                              selectedDeviceColor = item;
                            });
                          },
                        ),
                        onChanged: (value) {
                          setState(() {
                            selectedDeviceColor = value;
                          });
                        },
                      );
                    },
                    separatorBuilder: (BuildContext context, int index) {
                      return const SizedBox(height: Dimens.space_8);
                    },
                  ),
                  if (provider.strapColors == null) SizedBox.shrink(),
                  if (provider.strapColors != null) ...[
                    const SizedBox(height: Dimens.space_16),
                    CshTextNew.subTitle1("Strap Color"),
                    const SizedBox(height: Dimens.space_8),
                    provider.strapColors?.isEmpty == true
                        ? Text(
                            "Need to add Strap color",
                            style: theme.primaryTextTheme.titleMedium?.copyWith(color: theme.colorScheme.error),
                          )
                        : ListView.separated(
                            itemCount: provider.strapColors!.length,
                            shrinkWrap: true,
                            itemBuilder: (_, index) {
                              var item = provider.strapColors![index];
                              return CshRadio<String>(
                                value: item,
                                groupValue: selectedStrapColor,
                                title: GestureDetector(
                                  child: CshTextNew.subTitle1(item),
                                  onTap: () {
                                    setState(() {
                                      selectedStrapColor = item;
                                    });
                                  },
                                ),
                                onChanged: (value) {
                                  setState(() {
                                    selectedStrapColor = value;
                                  });
                                },
                              );
                            },
                            separatorBuilder: (BuildContext context, int index) {
                              return const SizedBox(height: Dimens.space_8);
                            },
                          ),
                  ],
                ],
              ),
            ),
          ),
          SizedBox(height: Dimens.space_16),
          Center(
            child: CshBigButton(
              text: "Proceed",
              onPressed: _isProceedEnabled(provider)
                  ? null
                  : () {
                      AnalyticsController.logEvent(ColorSelectedEvent(widget.deviceBarcode, selectedDeviceColor));
                      widget.onColorSelected?.call(selectedDeviceColor!);
                    },
            ),
          )
        ],
      ),
    );
  }

  bool _isProceedEnabled(ColorSelectionProvider provider) {
    if (selectedDeviceColor != null) {
      if (provider.strapColors == null) {
        return true;
      }

      if (selectedStrapColor != null) {
        return true;
      } else {
        return false;
      }
    }

    return false;
  }
}
