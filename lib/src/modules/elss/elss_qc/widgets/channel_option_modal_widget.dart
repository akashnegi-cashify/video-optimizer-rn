import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:image_picker/image_picker.dart';

import '../../common_models/channel_option_response.dart';
import '../l10n.dart';
import 'option_sku_tile_widget.dart';

class ChannelOptionModalWidget extends StatefulWidget {
  final ChannelOptionData? dataModel;
  final Function() onPnaCallback;
  final Function() onDoneCallback;

  const ChannelOptionModalWidget({
    Key? key,
    this.dataModel,
    required this.onDoneCallback,
    required this.onPnaCallback,
  }) : super(key: key);

  @override
  State<ChannelOptionModalWidget> createState() => _ChannelOptionModalWidgetState();
}

class _ChannelOptionModalWidgetState extends State<ChannelOptionModalWidget> {
  final ImagePicker picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    var l10n = L10n(context);
    var theme = Theme.of(context);
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.8,
      width: MediaQuery.of(context).size.width,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: Dimens.space_16, vertical: Dimens.space_20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(l10n.channelSuggestion, style: theme.primaryTextTheme.headline3),
                CshIcon(
                  FeatherIcons.x,
                  iconSize: MobileIconSize.large,
                  onClick: () => Navigator.of(context).pop(true),
                  padding: EdgeInsets.zero,
                )
              ],
            ),
            const SizedBox(height: Dimens.space_16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                (!Validator.isNullOrEmpty(widget.dataModel?.channelName))
                    ? RichText(
                        text: TextSpan(
                          text: "${l10n.repairType}: ",
                          style: theme.primaryTextTheme.overline,
                          children: <TextSpan>[
                            TextSpan(
                              text: widget.dataModel!.channelName!,
                              style: theme.primaryTextTheme.headline5,
                            )
                          ],
                        ),
                      )
                    : const SizedBox.shrink(),
                (widget.dataModel?.channelOptionPrice != null)
                    ? RichText(
                        text: TextSpan(
                          text: "${l10n.profit}: ",
                          style: theme.primaryTextTheme.overline,
                          children: <TextSpan>[
                            TextSpan(
                              text: "₹${widget.dataModel!.channelOptionPrice!}",
                              style: theme.primaryTextTheme.headline5?.copyWith(color: theme.primaryColor),
                            )
                          ],
                        ),
                      )
                    : const SizedBox.shrink(),
              ],
            ),
            const SizedBox(height: Dimens.space_8),
            if (widget.dataModel?.isRubbingAllowed != null)
              RichText(
                text: TextSpan(
                  text: "${l10n.isRubbingAllowed}: ",
                  style: theme.primaryTextTheme.overline,
                  children: <TextSpan>[
                    TextSpan(
                      text: "${widget.dataModel!.isRubbingAllowed!}",
                      style: theme.primaryTextTheme.headline5,
                    )
                  ],
                ),
              ),
            Expanded(
              child: (!Validator.isListNullOrEmpty(widget.dataModel?.requestedParts))
                  ? ListView.separated(
                      padding: const EdgeInsets.symmetric(vertical: Dimens.space_30),
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return OptionSkuTileWidget(
                          (index + 1),
                          dataModel: widget.dataModel!.requestedParts![index],
                        );
                      },
                      separatorBuilder: (context, index) {
                        return const SizedBox(height: Dimens.space_8);
                      },
                      itemCount: widget.dataModel!.requestedParts!.length,
                    )
                  : const SizedBox.shrink(),
            ),
            ComboButton(
              firstBtnText: l10n.pna,
              secondBtnText: l10n.submit,
              isFirstPrimary: true,
              firstBtnClick: widget.onPnaCallback,
              secondBtnClick: widget.onDoneCallback,
              buttonType: ButtonType.mini,
              padding: EdgeInsets.zero,
            )
          ],
        ),
      ),
    );
  }
}
