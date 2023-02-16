import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import '../../common_models/elss_part.dart';
import '../l10n.dart';

class ElssPartWidget extends StatefulWidget {
  final ElssPart? dataModel;
  final int indexData;

  final Function(int)? onPartRemoved;
  final Function(int, String) onImageUploadCallback;
  final Function()? onRequiredSelected;
  final Function()? onNotRequiredSelected;

  const ElssPartWidget({
    Key? key,
    required this.onImageUploadCallback,
    required this.indexData,
    this.onPartRemoved,
    this.dataModel,
    this.onNotRequiredSelected,
    this.onRequiredSelected,
  }) : super(key: key);

  @override
  State<ElssPartWidget> createState() => _ElssPartWidgetState();
}

class _ElssPartWidgetState extends State<ElssPartWidget> {
  bool _isRequiredSelected = true;

  @override
  void initState() {
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
      child: (widget.dataModel?.isManualAdded ?? false)
          ? Container(
              height: Dimens.space_50,
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: Dimens.space_8),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      widget.dataModel?.partName ?? "",
                      style: theme.primaryTextTheme.overline,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      if (widget.onPartRemoved != null) {
                        widget.onPartRemoved!(widget.dataModel?.elssPartId ?? 100);
                      }
                    },
                    child: CshIcon(
                      FeatherIcons.trash,
                      iconColor: theme.errorColor,
                      iconSize: MobileIconSize.large,
                      padding: EdgeInsets.zero,
                    ),
                  ),
                ],
              ),
            )
          : Theme(
              data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
              child: ListTileTheme(
                dense: true,
                child: ExpansionTile(
                  tilePadding: const EdgeInsets.symmetric(horizontal: Dimens.space_8),
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
                          _requiredWidget(
                            theme,
                            l10n.required,
                            () {
                              _isRequiredSelected = true;

                              if (widget.onRequiredSelected != null) {
                                widget.onRequiredSelected!();
                              }
                              setState(() {});
                            },
                          ),
                          Container(width: Dimens.space_1, height: Dimens.space_12, color: theme.shadowColor),
                          _notRequiredWidget(
                            theme,
                            l10n.notRequired,
                            () {
                              _isRequiredSelected = false;

                              if (widget.onNotRequiredSelected != null) {
                                widget.onNotRequiredSelected!();
                              }
                              setState(() {});
                            },
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }

  _notRequiredWidget(ThemeData theme, String label, Function() onPressed) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: Dimens.space_6, horizontal: Dimens.space_6),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(Dimens.space_4),
          border: (_isRequiredSelected == false) ? Border.all(color: theme.errorColor, width: Dimens.space_1) : null,
        ),
        child: Row(
          children: [
            Image.asset(
              "assets/images/ic_error.png",
              height: Dimens.space_16,
              width: Dimens.space_16,
            ),
            const SizedBox(width: Dimens.space_10),
            Text(
              label,
              style: theme.primaryTextTheme.headline5?.copyWith(
                color: theme.errorColor,
              ),
            )
          ],
        ),
      ),
    );
  }

  _requiredWidget(ThemeData theme, String label, Function() onPressed) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: Dimens.space_6, horizontal: Dimens.space_6),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(Dimens.space_4),
          border: (_isRequiredSelected) ? Border.all(color: theme.primaryColor, width: Dimens.space_1) : null,
        ),
        child: Row(
          children: [
            Image.asset(
              "assets/images/ic_check.png",
              height: Dimens.space_16,
              width: Dimens.space_16,
            ),
            const SizedBox(width: Dimens.space_10),
            Text(
              label,
              style: theme.primaryTextTheme.headline5?.copyWith(
                color: theme.primaryColor,
              ),
            )
          ],
        ),
      ),
    );
  }
}
