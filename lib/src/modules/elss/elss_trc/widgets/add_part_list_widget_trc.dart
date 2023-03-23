import 'dart:async';
import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import '../../common_models/part_device_list.dart';
import '../l10n.dart';
import '../providers/add_part_list_provider_trc.dart';
import '../../widgets/add_part_item_widget.dart';

class AddPartListWidgetTrc extends StatefulWidget {
  const AddPartListWidgetTrc({
    Key? key,
  }) : super(key: key);

  @override
  State<AddPartListWidgetTrc> createState() => _AddPartListWidgetTrcState();
}

class _AddPartListWidgetTrcState extends State<AddPartListWidgetTrc> {
  final TextEditingController _searchController = TextEditingController();
  bool _isFieldActive = false, _searchedActive = false;
  List<PartItemDataResponse> _searchedData = [];
  TextInputDebounce _timer = TextInputDebounce();

  @override
  void initState() {
    _searchController.addListener(() {
      if (_searchController.text.isNotEmpty) {
        _isFieldActive = true;
      } else {
        _isFieldActive = false;
      }
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var l10n = L10n(context);
    var theme = Theme.of(context);
    var provider = AddPartListProviderTrc.of(context);
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
                        _timer.start(() {
                          if (!Validator.isNullOrEmpty(data)) {
                            _searchPartsByProductName(provider.addPartsDataList, data.trim());
                          } else {
                            _searchedActive = false;
                            _searchedData.clear();
                            setState(() {});
                          }
                        });
                      },
                    ),
                    if (_isFieldActive)
                      GestureDetector(
                        onTap: () {
                          _searchController.clear();
                          _isFieldActive = false;
                          _searchedActive = false;
                          _searchedData.clear();
                          setState(() {});
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
                if (_searchedActive)
                  Expanded(
                    child: (_searchedData.isNotEmpty)
                        ? ListView.separated(
                            itemBuilder: (context, index) {
                              return AddPartItemList(
                                dataModel: _searchedData[index],
                                onPartSelected: (bool data) {
                                  provider.selectedPartFromList(_searchedData[index].partId!, data);
                                },
                              );
                            },
                            separatorBuilder: (context, index) {
                              return const SizedBox(height: Dimens.space_8);
                            },
                            itemCount: _searchedData.length,
                          )
                        : Center(
                            child: Text(
                              l10n.noResultsFound,
                              style: theme.primaryTextTheme.headline3,
                            ),
                          ),
                  ),
                if (!_searchedActive)
                  Expanded(
                    child: ListView.separated(
                      itemBuilder: (context, index) {
                        if (provider.addPartsDataList[index] != null) {
                          return AddPartItemList(
                              dataModel: provider.addPartsDataList[index],
                              onPartSelected: (bool data) {
                                provider.addPartsDataList[index].isCardSelected = data;
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

  _searchPartsByProductName(List<PartItemDataResponse> dataList, String productName) {
    _searchedData = dataList.where((element) {
      if (!Validator.isNullOrEmpty(element.productName)) {
        return element.productName!.toLowerCase().contains(productName.toLowerCase());
      } else {
        return false;
      }
    }).toList();
    _searchedActive = true;

    setState(() {});
  }

  @override
  void dispose() {
    _timer.stop();
    super.dispose();
  }
}
