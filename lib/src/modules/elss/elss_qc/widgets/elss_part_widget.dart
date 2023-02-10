import 'dart:async';
import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import '../../common_models/elss_part.dart';
import '../../common_resources/elss_action.dart';
import '../l10n.dart';

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
      child: Theme(
        data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
          title: Text(
            widget.dataModel?.partName ?? "",
            style: theme.primaryTextTheme.overline,
          ),
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(vertical: Dimens.space_12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _requiredNotRequiredWidget(theme, l10n.required, () {}, true),
                  Container(width: Dimens.space_1, height: Dimens.space_12, color: theme.dividerColor),
                  _requiredNotRequiredWidget(theme, l10n.notRequired, () {}, false),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  _requiredNotRequiredWidget(ThemeData theme, String label, Function() onPressed, bool isRequired) {
    return Row(
      children: [
        Image.asset(
          isRequired ? "assets/images/ic_check.png" : "assets/images/ic_error.png",
          height: Dimens.space_16,
          width: Dimens.space_16,
        ),
        const SizedBox(width: Dimens.space_10),
        Text(
          label,
          style: theme.primaryTextTheme.headline5?.copyWith(
            color: isRequired ? theme.primaryColor : theme.errorColor,
          ),
        )
      ],
    );
  }
}
