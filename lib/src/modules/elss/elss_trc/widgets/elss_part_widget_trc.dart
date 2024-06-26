import 'dart:async';

import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';

import '../../common_models/elss_part.dart';
import '../l10n.dart';
import '../screens/add_device_media_screen_trc.dart';

class ElssPartWidgetTrc extends StatefulWidget {
  final ElssPart? dataModel;
  final int indexData;
  final Function(String) onActionChanged;
  final Function(int)? onPartRemoved;
  final Function(int, String) onImageUploadCallback;

  const ElssPartWidgetTrc({
    Key? key,
    required this.onImageUploadCallback,
    required this.indexData,
    required this.onActionChanged,
    this.onPartRemoved,
    this.dataModel,
  }) : super(key: key);

  @override
  State<ElssPartWidgetTrc> createState() => _ElssPartWidgetTrcState();
}

class _ElssPartWidgetTrcState extends State<ElssPartWidgetTrc> {
  final List<String> actionList = ["Not Required", "Required", "Not Repairable"];

  String _optionSelected = "Required";

  @override
  void initState() {
    scheduleMicrotask(() {
      if (!Validator.isNullOrEmpty(widget.dataModel?.action) && widget.dataModel!.action != "UnKnown") {
        int index = actionList.indexWhere((element) => element == widget.dataModel!.action!);
        if (index != -1) {
          _optionSelected = actionList[index];
          setState(() {});
        }
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var l10n = L10n(context);

    return CshCard(
      radius: CshRadius.rad4,
      elevation: CardElevation.dimen_10,
      padding: const EdgeInsets.all(Dimens.space_8),
      child: Row(
        children: [
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    if (widget.dataModel?.action == null) ...[
                      GestureDetector(
                        onTap: () {
                          if (widget.onPartRemoved != null) {
                            widget.onPartRemoved!(widget.dataModel?.elssPartId ?? 100);
                          }
                        },
                        child: CshIcon(
                          FeatherIcons.xCircle,
                          iconColor: theme.colorScheme.error,
                          iconSize: MobileIconSize.medium,
                          padding: EdgeInsets.zero,
                        ),
                      ),
                      const SizedBox(width: Dimens.space_4),
                    ],
                    Text(
                      widget.indexData.toString(),
                      style: theme.primaryTextTheme.headlineMedium,
                    ),
                  ],
                ),
                const SizedBox(width: Dimens.space_4),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (!Validator.isNullOrEmpty(widget.dataModel?.partName)) ...[
                        Text(
                          widget.dataModel!.partName!,
                          style: theme.primaryTextTheme.titleSmall,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: Dimens.space_4)
                      ],
                      if (!Validator.isNullOrEmpty(widget.dataModel?.sku)) ...[
                        Row(
                          children: [
                            Text("${l10n.sku}: ", style: theme.primaryTextTheme.headlineMedium),
                            Expanded(
                              child: Text(
                                widget.dataModel!.sku!,
                                maxLines: 1,
                                style: theme.primaryTextTheme.bodyMedium,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: Dimens.space_4)
                      ],
                    ],
                  ),
                )
              ],
            ),
          ),
          const SizedBox(width: Dimens.space_2),
          Row(
            children: [
              if (!Validator.isNullOrEmpty(widget.dataModel?.action))
                Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.symmetric(horizontal: Dimens.space_4),
                  decoration: BoxDecoration(
                    border: Border.all(color: theme.disabledColor),
                    borderRadius: const BorderRadius.all(
                      Radius.circular(Dimens.space_4),
                    ),
                  ),
                  child: DropdownButton<String>(
                    value: _optionSelected,
                    underline: const SizedBox(),
                    items: actionList.map((String items) {
                      return DropdownMenuItem(
                        value: items,
                        child: Text(
                          items,
                          style: theme.primaryTextTheme.headlineSmall,
                        ),
                      );
                    }).toList(),
                    onChanged: (String? value) {
                      if (!Validator.isNullOrEmpty(value)) {
                        widget.onActionChanged(_getValueOfDropDown(value!));
                        _optionSelected = value;
                        setState(() {});
                      }
                    },
                    icon: const Icon(FeatherIcons.chevronDown),
                  ),
                ),
              const SizedBox(width: Dimens.space_8),
              GestureDetector(
                onTap: () {
                  AddDeviceMediaArgumentsTrc args = AddDeviceMediaArgumentsTrc(
                    partsImage: widget.dataModel?.partsImageList,
                    onImageUploadCallback: widget.onImageUploadCallback,
                  );
                  AddDeviceMediaScreenTrcArguments arg = AddDeviceMediaScreenTrcArguments(argumentsData: args);
                  Navigator.of(context).pushNamed(AddDeviceMediaScreenTrc.route, arguments: arg);
                },
                child: CshIcon(
                  FeatherIcons.camera,
                  iconSize: MobileIconSize.large,
                  iconColor: theme.primaryColor,
                ),
              )
            ],
          )
        ],
      ),
    );
  }

  _getValueOfDropDown(String value) {
    if (value == "Not Required") {
      return "Not Required";
    } else if (value == "Required") {
      return "Repairable";
    } else {
      return "Not Repairable";
    }
  }
}
