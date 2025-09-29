import 'package:calculator_ui/calculator_ui.dart';
import 'package:core_widgets/core_widgets.dart' hide iterate;
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_trc/qc/modules/re_qc/dialog/d2c_pending_video_list_dialog.dart';
import 'package:flutter_trc/qc/modules/re_qc/models/re_qc_list_response.dart';
import 'package:flutter_trc/qc/modules/re_qc/providers/re_qc_list_provider.dart';
import 'package:flutter_trc/qc/modules/re_qc/screens/re_qc_detail_screen.dart';
import 'package:flutter_trc/qc/qc_common/lot_type_filters/screens/store_out_lot_filter_screen.dart';
import 'package:flutter_trc/src/common/widgets/search_with_dropdown_widget.dart';
import 'package:flutter_trc/src/utils/paginate_list_abstract.dart';

import '../l10n.dart';

enum _SearchType {
  lotName("ln", "Lot Name"),
  barcode("br", "Barcode");

  final String code;
  final String name;

  const _SearchType(this.code, this.name);
}

class ReQcListWidget extends StatefulWidget {
  const ReQcListWidget({super.key});

  @override
  State<ReQcListWidget> createState() => _ReQcListWidgetState();
}

class _ReQcListWidgetState extends PaginatedListState<ReQcListData, ReQcListWidget> {
  late final List<DropDownItem> _dropDownItems = [];
  DropDownItem? _selectedSearchType;

  final TextEditingController _searchController = TextEditingController();
  final TextInputDebounce _timer = TextInputDebounce();

  @override
  void initState() {
    for (var element in _SearchType.values) {
      _dropDownItems.add(DropDownItem(element.code, element.name));
    }
    _selectedSearchType = _dropDownItems[0];
    super.initState();
  }

  _setSearchFilterAndReset(SearchType type, String value) {
    var provider = ReQcListProvider.of(context, listen: false);
    if (type == LotSearchType.barcode) {
      provider.deviceBarcode = value;
    } else {
      provider.lotName = value;
    }
    resetAndRefreshScreen();
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var l10n = L10n(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SearchWithDropdownWidget(
          padding: const EdgeInsets.fromLTRB(Dimens.space_16, Dimens.space_16, Dimens.space_16, 0),
          searchTypeValues: LotSearchType.values,
          onSearch: (type, value) {
            _setSearchFilterAndReset(type, value);
          },
          onDropDownChange: (item) {
            var provider = ReQcListProvider.of(context, listen: false);
            provider.resetSearchFilters();
            resetAndRefreshScreen();
          },
        ),
        Expanded(
          child: Stack(
            children: [
              iterate(
                (item, index) {
                  return InkWell(
                    onTap: () => _onItemClicked(item),
                    child: _ReQcListItemWidget(
                      index: index,
                      dataModel: item,
                      onSkipClick: () => _onSkipButtonClicked(item.lotGroupName),
                    ),
                  );
                },
                padding: const EdgeInsets.fromLTRB(Dimens.space_16, 0, Dimens.space_16, Dimens.space_16),
                separator: const SizedBox(height: Dimens.space_8),
                onRefresh: () async {},
                onNoDataFound: () {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CshTextNew.subTitle1(l10n.noDataFound),
                        const SizedBox(height: Dimens.space_12),
                        CshMediumButton(
                          text: l10n.refresh,
                          onPressed: () {
                            resetAndRefreshScreen();
                          },
                        )
                      ],
                    ),
                  );
                },
                onError: (String error) {
                  return Center(
                    child: Row(
                      children: [
                        const SizedBox.shrink(),
                        Expanded(
                          child: Text(
                            error,
                            style: theme.primaryTextTheme.displaySmall,
                            textAlign: TextAlign.center,
                          ),
                        )
                      ],
                    ),
                  );
                },
              ),
              Positioned(
                bottom: Dimens.space_16,
                right: Dimens.space_16,
                child: FloatingActionButton(
                  heroTag: "filter",
                  onPressed: () => _openFilterScreen(context),
                  backgroundColor: theme.primaryColor,
                  child: CshIcon(FeatherIcons.filter, iconSize: MobileIconSize.large),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }

  _onSkipButtonClicked(String? lotGroupName) {
    var provider = ReQcListProvider.of(context, listen: false);
    CshLoading().showLoading(context);
    provider.skipReQc(lotGroupName).then((value) {
      CshLoading().hideLoading(context);
      CshSnackBar.success(context: context, message: "Request Completed Successfully");
      resetAndRefreshScreen();
    }, onError: (error) {
      CshLoading().hideLoading(context);
      CshSnackBar.error(context: context, message: error);
    });
  }

  @override
  void requestApi(int pageNo, {Function(List<ReQcListData>? list)? onSuccess, Function(String errorMessage)? onError}) {
    var provider = ReQcListProvider.of(context, listen: false);
    provider.getReQcList(pageSize, pageNo * pageSize).then((value) {
      onSuccess?.call(value);
    }, onError: (error) {
      onError?.call(error);
    });
  }

  void _onItemClicked(ReQcListData item) {
    if ((item.pendingCount ?? 0) <= 0) {
      _completeReQc(item.lotGroupName);
      return;
    }
    Navigator.pushNamed(context, ReQcDetailScreen.route, arguments: ReQcDetailScreenArguments(item));
  }

  _completeReQc(String? lotGroupName) {
    var provider = ReQcListProvider.of(context, listen: false);
    CshLoading().showLoading(context);
    provider.completeReQc(lotGroupName).then((value) {
      if (!Validator.isListNullOrEmpty(value)) {
        showD2cPendingVideoListDialog(
          context,
          value,
          onProceed: () {
            Navigator.pop(context); // dismiss D2cPendingVideoListDialog
            CshLoading().hideLoading(context);
            CshSnackBar.success(context: context, message: "Request Completed Successfully");
            resetAndRefreshScreen();
          },
        );
      } else {
        CshLoading().hideLoading(context);
        CshSnackBar.success(context: context, message: "Request Completed Successfully");
        resetAndRefreshScreen();
      }
    }, onError: (error) {
      CshLoading().hideLoading(context);
      showPopup(context, title: "Warning", desc: error, actions: [
        CshMediumButton(text: 'Cancel', onPressed: () => Navigator.pop(context)),
        CshMediumButton(
            text: 'Retry',
            onPressed: () {
              Navigator.pop(context);
              _completeReQc(lotGroupName);
            }),
      ]);
    });
  }

  void _openFilterScreen(BuildContext context) {
    var provider = ReQcListProvider.of(context, listen: false);
    StoreOutLotFilterScreen.navigate(context, selectedLotType: provider.lotTypeFilters).then((value) {
      if (value != null && value is List<int>) {
        provider.lotTypeFilters = value;
        resetAndRefreshScreen();
      }
    });
  }

  @override
  void dispose() {
    _timer.stop();
    _searchController.dispose();
    super.dispose();
  }

  bool _isSearchTypeBarcode() {
    return _selectedSearchType?.id == _SearchType.barcode.code;
  }
}

class _ReQcListItemWidget extends StatelessWidget {
  final ReQcListData dataModel;
  final int index;
  final VoidCallback onSkipClick;

  const _ReQcListItemWidget({required this.dataModel, required this.index, required this.onSkipClick, super.key});

  @override
  Widget build(BuildContext context) {
    String title = "#${index + 1} - ${dataModel.lotGroupName ?? ""}";
    var theme = Theme.of(context);
    var l10n = L10n(context);
    return CshCard(
      padding: const EdgeInsets.all(Dimens.space_16),
      bgColor: _getColor(dataModel.auditCount, dataModel.pendingCount, theme),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CshTextNew.subTitle1(title),
          const SizedBox(height: Dimens.space_4),
          CshTextNew.subTitle1("${l10n.lotQty} - ${dataModel.lotCount ?? 0}"),
          const SizedBox(height: Dimens.space_4),
          CshTextNew.subTitle1("${l10n.doneQty} - ${dataModel.doneCount ?? 0}"),
          const SizedBox(height: Dimens.space_4),
          CshTextNew.subTitle1("${l10n.pendingQty} - ${dataModel.pendingCount ?? 0}"),
          const SizedBox(height: Dimens.space_4),
          CshTextNew.subTitle1("${l10n.auditQty} - ${dataModel.auditCount ?? 0}"),
          const SizedBox(height: Dimens.space_4),
          CshTextNew.subTitle1("${l10n.lotType} - ${dataModel.lotType ?? ""}"),
          const SizedBox(height: Dimens.space_4),
          if (Validator.isTrue(dataModel.skipReQc))
            CshMediumButton(
              text: l10n.skip,
              onPressed: () {
                onSkipClick();
              },
            ),
        ],
      ),
    );
  }

  Color _getColor(int? auditCount, int? pendingCount, ThemeData theme) {
    CustomColors customTheme = theme.extension<CustomColors>() as CustomColors;
    if ((pendingCount ?? 0) > 0) {
      return customTheme.warnColor;
    } else if ((auditCount ?? 0) > 0) {
      return theme.colorScheme.error;
    } else {
      return theme.cardColor;
    }
  }
}
