import 'dart:async';
import 'package:core/core.dart';
import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import '../l10n.dart';
import '../models/elss_part.dart';
import '../resources/elss_action.dart';
import '../screens/add_device_media_screen.dart';

class ElssPartWidget extends StatefulWidget {
  final ElssPart? dataModel;
  final int indexData;
  final Function(String) onActionChanged;
  final Function(int)? onPartRemoved;
  final Function(int, String) onImageUploadCallback;

  const ElssPartWidget({
    Key? key,
    required this.onImageUploadCallback,
    required this.indexData,
    required this.onActionChanged,
    this.onPartRemoved,
    this.dataModel,
  }) : super(key: key);

  @override
  State<ElssPartWidget> createState() => _ElssPartWidgetState();
}

class _ElssPartWidgetState extends State<ElssPartWidget> {
  final List<String> actionList = [
    ElssAction.NOT_REQUIRED.value,
    ElssAction.NOT_REPAIRABLE.value,
    ElssAction.REPAIRABLE.value,
  ];

  String _optionSelected = ElssAction.NOT_REQUIRED.value;

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
                          iconColor: theme.errorColor,
                          iconSize: MobileIconSize.medium,
                          padding: EdgeInsets.zero,
                        ),
                      ),
                      const SizedBox(width: Dimens.space_4),
                    ],
                    Text(
                      widget.indexData.toString(),
                      style: theme.primaryTextTheme.headline4,
                    ),
                  ],
                ),
                const SizedBox(width: Dimens.space_4),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (!Validator.isNullOrEmpty(widget.dataModel?.partName)) ...[
                      Text(
                        widget.dataModel!.partName!,
                        style: theme.primaryTextTheme.subtitle2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: Dimens.space_4)
                    ],
                    if (!Validator.isNullOrEmpty(widget.dataModel?.sku)) ...[
                      Row(
                        children: [
                          Text("${l10n.sku}: ", style: theme.primaryTextTheme.subtitle2),
                          Text(
                            widget.dataModel!.sku!,
                            style: theme.primaryTextTheme.bodyText2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                      const SizedBox(height: Dimens.space_4)
                    ],
                    if (!Validator.isNullOrEmpty(widget.dataModel?.partColour)) ...[
                      Row(
                        children: [
                          Text("${l10n.colour}: ", style: theme.primaryTextTheme.headline4),
                          Text(
                            widget.dataModel!.partColour!,
                            style: theme.primaryTextTheme.bodyText2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                      const SizedBox(height: Dimens.space_4)
                    ],
                  ],
                )
              ],
            ),
          ),
          Row(
            children: [
              if (!Validator.isNullOrEmpty(widget.dataModel?.action))
                Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.symmetric(horizontal: Dimens.space_4),
                  decoration: BoxDecoration(
                      border: Border.all(color: theme.disabledColor),
                      borderRadius: const BorderRadius.all(Radius.circular(Dimens.space_4))),
                  child: DropdownButton<String>(
                    value: _optionSelected,
                    underline: const SizedBox(),
                    items: actionList.map((String items) {
                      return DropdownMenuItem(
                        value: items,
                        child: Text(
                          items,
                          style: theme.primaryTextTheme.headline5,
                        ),
                      );
                    }).toList(),
                    onChanged: (String? value) {
                      if (!Validator.isNullOrEmpty(value)) {
                        widget.onActionChanged(value!);
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
                  Logger.debug('mydebug------_ElssPartWidgetState.build', [widget.dataModel?.partsImageList]);
                  Logger.debug(
                      'mydebug------_ElssPartWidgetState.build_length', [widget.dataModel?.partsImageList?.length]);
                  AddDeviceMediaArguments args = AddDeviceMediaArguments(
                      partsImage: widget.dataModel?.partsImageList,
                      onImageUploadCallback: widget.onImageUploadCallback);
                  Navigator.of(context).pushNamed(AddDeviceMediaScreen.route, arguments: args);
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
}
