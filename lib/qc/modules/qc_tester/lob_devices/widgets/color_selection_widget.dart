import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/qc/modules/qc_tester/lob_devices/providers/color_selection_provider.dart';
import 'package:flutter_trc/src/common/widgets/shimmer_list_widget.dart';
import 'package:flutter_trc/src/libraries/analytics/analytics_controller.dart';
import 'package:flutter_trc/src/libraries/analytics/events/color_selected_event.dart';
import 'package:flutter_trc/src/libraries/analytics/events/color_view_event.dart';

import '../l10n.dart';

class ColorSelectionWidget extends StatefulWidget {
  final String? deviceBarcode;
  final Function(String color, String? strapColor)? onColorSelected;

  const ColorSelectionWidget(this.deviceBarcode, this.onColorSelected, {super.key});

  @override
  State<ColorSelectionWidget> createState() => _ColorSelectionWidgetState();
}

class _ColorSelectionWidgetState extends State<ColorSelectionWidget> {
  String? _selectedDeviceColor;
  String? _selectedStrapColor;

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
    var l10n = L10n(context);

    return Padding(
      padding: const EdgeInsets.all(Dimens.space_16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _ColorCard(
                    l10n.deviceDialColor,
                    colors,
                    selectedColor: _selectedDeviceColor,
                    onColorSelected: (color) {
                      setState(() {
                        _selectedDeviceColor = color;
                      });
                    },
                  ),
                  if (provider.strapColors != null)
                    Padding(
                      padding: const EdgeInsets.only(top: Dimens.space_16),
                      child: _ColorCard(
                        l10n.strapColor,
                        provider.strapColors,
                        selectedColor: _selectedStrapColor,
                        onColorSelected: (color) {
                          setState(() {
                            _selectedStrapColor = color;
                          });
                        },
                      ),
                    ),
                ],
              ),
            ),
          ),
          SizedBox(height: Dimens.space_16),
          Center(
            child: CshBigButton(
              text: l10n.proceed,
              onPressed: _isProceedEnabled(provider)
                  ? () {
                      AnalyticsController.logEvent(ColorSelectedEvent(widget.deviceBarcode, _selectedDeviceColor));
                      widget.onColorSelected?.call(_selectedDeviceColor!, _selectedStrapColor);
                    }
                  : null,
            ),
          )
        ],
      ),
    );
  }

  bool _isProceedEnabled(ColorSelectionProvider provider) {
    if (_selectedDeviceColor != null) {
      if (provider.strapColors == null) {
        return true;
      }

      if (_selectedStrapColor != null) {
        return true;
      } else {
        return false;
      }
    }

    return false;
  }
}

class _ColorCard extends StatelessWidget {
  final String title;
  final List<String>? colors;
  final Function(String color)? onColorSelected;
  final String? selectedColor;

  const _ColorCard(this.title, this.colors, {super.key, required this.onColorSelected, this.selectedColor});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return CshCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          CshTextNew.subTitle1(title),
          const SizedBox(height: Dimens.space_8),
          colors?.isEmpty == true
              ? Text(
                  "Need to add $title",
                  style: theme.primaryTextTheme.titleMedium?.copyWith(color: theme.colorScheme.error),
                )
              : ListView.separated(
                  itemCount: colors!.length,
                  primary: false,
                  shrinkWrap: true,
                  itemBuilder: (_, index) {
                    var item = colors![index];
                    return CshRadio<String>(
                      value: item,
                      groupValue: selectedColor,
                      title: GestureDetector(
                        child: CshTextNew.subTitle1(item),
                        onTap: () {
                          onColorSelected?.call(item);
                        },
                      ),
                      onChanged: (value) {
                        onColorSelected?.call(item);
                      },
                    );
                  },
                  separatorBuilder: (BuildContext context, int index) {
                    return const SizedBox(height: Dimens.space_8);
                  },
                ),
        ],
      ),
    );
  }
}
