import 'package:calculator_ui/calculator_ui.dart';
import 'package:components/list_page/config/list_api_config.dart';
import 'package:components/list_page/controller/csh_list_controller.dart';
import 'package:components/list_page/widgets/csh_api_list.dart';
import 'package:core_widgets/core_widgets.dart' hide iterate;
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_trc/qc/modules/re_qc/dialog/d2c_pending_video_list_dialog.dart';
import 'package:flutter_trc/qc/modules/re_qc/models/re_qc_list_response.dart';
import 'package:flutter_trc/qc/modules/re_qc/providers/re_qc_list_provider.dart';
import 'package:flutter_trc/qc/modules/re_qc/screens/re_qc_detail_screen.dart';
import 'package:flutter_trc/qc/qc_common/lot_type_filters/screens/store_out_lot_filter_screen.dart';
import 'package:flutter_trc/src/common/widgets/search_with_dropdown_widget.dart';
import 'package:flutter_trc/src/services/service_groups.dart';

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

class _ReQcListWidgetState extends State<ReQcListWidget> {
  late final List<DropDownItem> _dropDownItems = [];
  DropDownItem? _selectedSearchType;

  final TextEditingController _searchController = TextEditingController();
  final TextInputDebounce _timer = TextInputDebounce();

  final CshListController _listController = CshListController();

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
    _listController.refresh();
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
            _listController.refresh();
          },
        ),
        Expanded(
          child: Stack(
            children: [
              CshApiList<ReQcListData>(
                apiConfig: ListApiConfig(
                  apiUrl: "/re-qc/v1/list",
                  serviceGroup: TRCServiceGroups.qcConsole,
                ),
                controller: _listController,
                shimmerLoaderWidget: const CshShimmer(height: Dimens.space_60),
                itemFromJson: ReQcListData.fromJson,
                getRowWidget: (item, index) {
                  if (item != null) {
                    return InkWell(
                      onTap: () => _onItemClicked(item),
                      child: _ReQcListItemWidget(
                        index: index,
                        dataModel: item,
                        onSkipClick: () => _onSkipButtonClicked(item.lotId),
                      ),
                    );
                  }
                  return SizedBox.shrink();
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

  _onSkipButtonClicked(int? lotId) {
    var provider = ReQcListProvider.of(context, listen: false);
    CshLoading().showLoading(context);
    provider.skipReQc(lotId).then((value) {
      CshLoading().hideLoading(context);
      CshSnackBar.success(context: context, message: "Request Completed Successfully");
      _listController.refresh();
    }, onError: (error) {
      CshLoading().hideLoading(context);
      CshSnackBar.error(context: context, message: error);
    });
  }

  void _onItemClicked(ReQcListData item) {
    if ((item.pendingCount ?? 0) <= 0) {
      _completeReQc(item.lotId);
      return;
    }
    Navigator.pushNamed(context, ReQcDetailScreen.route, arguments: ReQcDetailScreenArguments(item));
  }

  _completeReQc(int? lotId) {
    var provider = ReQcListProvider.of(context, listen: false);
    CshLoading().showLoading(context);
    provider.completeReQc(lotId).then((value) {
      if (!Validator.isListNullOrEmpty(value)) {
        showD2cPendingVideoListDialog(
          context,
          value,
          onProceed: () {
            Navigator.pop(context); // dismiss D2cPendingVideoListDialog
            CshLoading().hideLoading(context);
            CshSnackBar.success(context: context, message: "Request Completed Successfully");
            _listController.refresh();
          },
        );
      } else {
        CshLoading().hideLoading(context);
        CshSnackBar.success(context: context, message: "Request Completed Successfully");
        _listController.refresh();
      }
    }, onError: (error) {
      CshLoading().hideLoading(context);
      showPopup(context, title: "Warning", desc: error, actions: [
        CshMediumButton(text: 'Cancel', onPressed: () => Navigator.pop(context)),
        CshMediumButton(
            text: 'Retry',
            onPressed: () {
              Navigator.pop(context);
              _completeReQc(lotId);
            }),
      ]);
    });
  }

  void _openFilterScreen(BuildContext context) {
    var provider = ReQcListProvider.of(context, listen: false);
    StoreOutLotFilterScreen.navigate(context, selectedLotType: provider.lotTypeFilters).then((value) {
      if (value != null && value is List<int>) {
        provider.lotTypeFilters = value;
        _listController.refresh();
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
        crossAxisAlignment: CrossAxisAlignment.stretch,
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
