import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import '../../../../utils/dotted_divider_line.dart';
import '../../common_models/channel_option_response.dart';
import '../l10n.dart';

class ChannelSuggestionWidget extends StatelessWidget {
  final ChannelOptionData? dataModel;
  final String title;

  const ChannelSuggestionWidget({
    Key? key,
    required this.title,
    this.dataModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var l10n = L10n(context);
    return (dataModel != null)
        ? Container(
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
                  title,
                  style: theme.primaryTextTheme.headline5,
                ),
                if (dataModel != null && (!Validator.isListNullOrEmpty(dataModel?.requestedParts))) ...[
                  const SizedBox(height: Dimens.space_8),
                  DottedLineDivider(
                    dashWidth: Dimens.space_2,
                    width: 0.5,
                    color: theme.shadowColor,
                  ),
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
                            itemCount: dataModel!.requestedParts!.length,
                            itemBuilder: (context, index) {
                              return Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      "${index + 1}. ${dataModel!.requestedParts![index].sku}",
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
                ] else
                  const SizedBox(height: Dimens.space_8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        (dataModel?.isRubbingAllowed != null)
                            ? _labelValueWidget(theme, l10n.isRubbingAllowed, dataModel!.isRubbingAllowed!.toString())
                            : const SizedBox.shrink(),
                        const SizedBox(height: Dimens.space_8),
                        (!Validator.isNullOrEmpty(dataModel?.channelName))
                            ? _labelValueWidget(theme, l10n.repairType, dataModel!.channelName!)
                            : const SizedBox.shrink(),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        (dataModel?.grade != null)
                            ? _labelValueWidget(theme, l10n.grade, dataModel!.grade!)
                            : const SizedBox.shrink(),
                        const SizedBox(height: Dimens.space_8),
                        (dataModel?.channelOptionPrice != null)
                            ? _labelValueWidget(theme, l10n.price, "₹${dataModel!.channelOptionPrice!}")
                            : const SizedBox.shrink(),
                      ],
                    )
                  ],
                ),
              ],
            ),
          )
        : const SizedBox.shrink();
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
