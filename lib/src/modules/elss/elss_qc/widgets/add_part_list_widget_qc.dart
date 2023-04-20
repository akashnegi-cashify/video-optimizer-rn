import 'dart:async';
import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import '../../common_models/part_device_list.dart';
import '../l10n.dart';
import '../../widgets/add_part_item_widget.dart';
import '../providers/add_part_list_provider_qc.dart';

class AddPartListWidgetQc extends StatefulWidget {
  const AddPartListWidgetQc({
    Key? key,
  }) : super(key: key);

  @override
  State<AddPartListWidgetQc> createState() => _AddPartListWidgetQcState();
}

class _AddPartListWidgetQcState extends State<AddPartListWidgetQc> {
  final TextEditingController _searchController = TextEditingController();
  Timer? _timer;

  @override
  Widget build(BuildContext context) {
    var l10n = L10n(context);
    var theme = Theme.of(context);
    var provider = AddPartListProviderQc.of(context);
    return (!Validator.isListNullOrEmpty(provider.addPartsDataList))
        ? Padding(
            padding: const EdgeInsets.symmetric(vertical: Dimens.space_12, horizontal: Dimens.space_8),
            child: Column(
              children: [
                Stack(
                  alignment: Alignment.centerRight,
                  children: [
                    CshTextFormField(
                      controller: _searchController,
                      maxLines: 1,
                      counterText: "",
                      maxLength: 50,
                      hintText: l10n.searchPart,
                      onChanged: (data) {
                        if (_timer?.isActive ?? false) _timer?.cancel();
                        _timer = Timer(
                          const Duration(milliseconds: 500),
                          () {
                            if (!Validator.isNullOrEmpty(data)) {
                              provider.searchedQuery = data.trim();
                            }
                          },
                        );
                      },
                    ),
                    if (!Validator.isNullOrEmpty(provider.searchedQuery))
                      GestureDetector(
                        onTap: () {
                          provider.searchedQuery = null;
                          _searchController.clear();
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: Dimens.space_12),
                          child: CshIcon(
                            FeatherIcons.xCircle,
                            iconSize: MobileIconSize.medium,
                          ),
                        ),
                      ),
                  ],
                ),
                const SizedBox(height: Dimens.space_8),
                Expanded(
                  child: ListView.separated(
                    itemBuilder: (context, index) {

                      if (provider.addPartsDataList[index] != null) {
                        var addPartsData = provider.addPartsDataList[index];
                        return AddPartItemList(
                            dataModel: provider.addPartsDataList[index],
                            onPartSelected: (bool data) {
                              provider.onPartItemSelected(addPartsData, data);
                            });
                      }
                      return const SizedBox.shrink();
                    },
                    separatorBuilder: (context, index) {
                      return const SizedBox(height: Dimens.space_8);
                    },
                    itemCount: provider.addPartsDataList.length,
                  ),
                ),
                const SizedBox(height: Dimens.space_8),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: Dimens.space_8),
                  child: Row(
                    children: [
                      Expanded(
                        child: CshMediumButton(
                          text: l10n.cancel,
                          onPressed: () {
                            Navigator.of(context).pop(true);
                          },
                        ),
                      ),
                      const SizedBox(width: Dimens.space_10),
                      Expanded(
                        child: CshMediumButton(
                          text: l10n.addPart,
                          onPressed: () {
                            List<PartItemDataResponse> dataList = provider.getSelectedParts();
                            Navigator.of(context).pop(dataList);
                          },
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          )
        : Center(
            child: Text(
              l10n.noPartsFound,
              style: theme.primaryTextTheme.headline3,
            ),
          );
  }
}
