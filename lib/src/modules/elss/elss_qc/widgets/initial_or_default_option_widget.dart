import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import '../../../../utils/dotted_divider_line.dart';
import '../../common_models/channel_option_response.dart';
import '../l10n.dart';

class InitialOrDefaultWidget extends StatefulWidget {
  final ChannelOptionData? channelData;
  final String channelTitle;

  const InitialOrDefaultWidget({
    Key? key,
    required this.channelTitle,
    this.channelData,
  }) : super(key: key);

  @override
  State<InitialOrDefaultWidget> createState() => _InitialOrDefaultWidgetState();
}

class _InitialOrDefaultWidgetState extends State<InitialOrDefaultWidget> {
  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var l10n = L10n(context);
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.symmetric(vertical: Dimens.space_10, horizontal: Dimens.space_16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(Dimens.space_8),
        color: theme.shadowColor.withOpacity(0.1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.channelTitle,
            style: theme.primaryTextTheme.headline5,
          ),
          const SizedBox(height: Dimens.space_8),
          DottedLineDivider(
            dashWidth: Dimens.space_2,
            width: 0.5,
            color: theme.shadowColor,
          ),
          if (widget.channelData != null && (!Validator.isListNullOrEmpty(widget.channelData?.requestedParts)))
            Theme(
              data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
              child: ListTileTheme(
                dense: true,
                child: ExpansionTile(
                  tilePadding: EdgeInsets.zero,
                  title: Text(
                    l10n.listOfSkUs,
                    style: theme.primaryTextTheme.headline5,
                  ),
                  children: [
                    ListView.separated(
                      shrinkWrap: true,
                      primary: false,
                      itemCount: widget.channelData!.requestedParts!.length,
                      itemBuilder: (context, index) {
                        return Row(
                          children: [
                            Expanded(
                              child: Text(
                                "${index + 1}. ${widget.channelData!.requestedParts![index].sku}",
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            const SizedBox.shrink(),
                          ],
                        );
                      },
                      separatorBuilder: (context, index) {
                        return const SizedBox(height: Dimens.space_8);
                      },
                    ),
                  ],
                ),
              ),
            ),
          DottedLineDivider(
            dashWidth: Dimens.space_2,
            width: 0.5,
            color: theme.shadowColor,
          ),
          const SizedBox(height: Dimens.space_8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              (widget.channelData?.channelOptionPrice != null)
                  ? _labelValueWidget(theme, l10n.price, "₹${widget.channelData!.channelOptionPrice!}")
                  : const SizedBox.shrink(),
              (!Validator.isNullOrEmpty(widget.channelData?.channelName))
                  ? _labelValueWidget(theme, l10n.repairType, widget.channelData!.channelName!)
                  : const SizedBox.shrink(),
            ],
          ),
        ],
      ),
    );
  }

  _labelValueWidget(ThemeData theme, String label, String value) {
    return Row(
      children: [
        Text(
          "$label: ",
          style: theme.primaryTextTheme.overline,
        ),
        Text(
          value,
          style: theme.primaryTextTheme.headline5,
        )
      ],
    );
  }
}
