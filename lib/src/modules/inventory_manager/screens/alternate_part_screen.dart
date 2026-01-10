import 'package:builder_project/builder_project.dart';
import 'package:components/components.dart';
import 'package:core_widgets/core_widgets.dart';
import 'package:csh_annotation/annotation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/src/services/service_groups.dart';
import 'package:provider/provider.dart';

import '../../../app_builder/app_builder_groups/groups.dart';
import '../l10n.dart';
import '../models/alternate_part_comp_param.dart';
import '../models/list_alternate_parts_response.dart';
import '../models/parts_details_response.dart';
import '../models/pending_device_list_response.dart';
import '../providers/alternate_part_list_provider.dart';
import '../widgets/alternate_part_item_widget.dart';
import 'assign_part_barcode_scanner.dart';

part 'alternate_part_screen.g.dart';

class AlternatePartArguments {
  final PendingDeviceDetailData? detailsModelData;
  final int prid;
  final PartDetailsData? itemDataModel;

  AlternatePartArguments({
    required this.prid,
    this.detailsModelData,
    this.itemDataModel,
  });
}

@CshPage(
    key: AlternatePartScreen.pageKey,
    params: AlternatePartCompParamKeys.values,
    pageGroup: PageGroup.alternatePartPageKey)
class AlternatePartCompArguments extends BaseArguments {
  final AlternatePartArguments? arguments;

  AlternatePartCompArguments({this.arguments}) : super(AlternatePartScreen.pageKey);

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = {};
    data[AlternatePartCompParamKeys.arguments.value] = arguments;
    return data;
  }
}

class AlternatePartScreen extends BaseScreen<AlternatePartCompArguments> {
  static const String pageKey = "TRC_alternate_part_screen";
  static const String route = "/alternate_part_screen";

  const AlternatePartScreen({super.key});

  @override
  Widget buildView(BuildContext context) {
    var args = getArguments(context);

    return PageWidget(
      pageKey: pageKey,
      initialValue: args?.toJson(),
    );
  }
}

class AlternatePartWidget extends StatefulWidget {
  final AlternatePartArguments? arg;

  const AlternatePartWidget({Key? key, this.arg}) : super(key: key);

  @override
  State<AlternatePartWidget> createState() => _AlternatePartWidgetState();
}

class _AlternatePartWidgetState extends State<AlternatePartWidget> {
  final CshListController _listController = CshListController();

  @override
  Widget build(BuildContext context) {
    var l10n = L10n(context);
    var theme = Theme.of(context);

    return ChangeNotifierProvider<AlternatePartListProvider>(
      create: (_) => AlternatePartListProvider(widget.arg?.prid),
      lazy: false,
      builder: (BuildContext insideContext, __) {
        return Scaffold(
          appBar: CshHeader(
            l10n.alternatePartList,
            showBackBtn: true,
          ),
          body: Column(
            children: [
              // Device Info Card
              Padding(
                padding: const EdgeInsets.all(Dimens.space_8),
                child: CshCard(
                  child: Column(
                    children: [
                      if (!Validator.isNullOrEmpty(widget.arg?.detailsModelData?.deviceBarcode)) ...[
                        _labelAndValueWidget(theme, l10n.deviceBarcode, widget.arg!.detailsModelData!.deviceBarcode!),
                        const SizedBox(height: Dimens.space_8),
                      ],
                      if (!Validator.isNullOrEmpty(widget.arg?.detailsModelData?.productTitle)) ...[
                        _labelAndValueWidget(theme, l10n.deviceName, widget.arg!.detailsModelData!.productTitle!),
                        const SizedBox(height: Dimens.space_8),
                      ],
                      if (!Validator.isNullOrEmpty(widget.arg?.detailsModelData?.engineerName)) ...[
                        _labelAndValueWidget(theme, l10n.engineerSName, widget.arg!.detailsModelData!.engineerName!),
                        const SizedBox(height: Dimens.space_8),
                      ],
                      if (!Validator.isNullOrEmpty(widget.arg?.detailsModelData?.location)) ...[
                        _labelAndValueWidget(theme, l10n.location, widget.arg!.detailsModelData!.location!),
                      ],
                    ],
                  ),
                ),
              ),
              // Original Part Request Header
              _headerContainer(theme, l10n.originalPartRequest),
              const SizedBox(height: Dimens.space_8),
              // Original Part Info Card
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: Dimens.space_8),
                child: CshCard(
                  child: Column(
                    children: [
                      if (!Validator.isNullOrEmpty(widget.arg?.itemDataModel?.partName)) ...[
                        _labelAndValueWidget(theme, l10n.partName, widget.arg!.itemDataModel!.partName!),
                        const SizedBox(height: Dimens.space_6),
                      ],
                      if (!Validator.isNullOrEmpty(widget.arg?.itemDataModel?.sku)) ...[
                        _labelAndValueWidget(theme, l10n.sku, widget.arg!.itemDataModel!.sku!),
                      ],
                    ],
                  ),
                ),
              ),
              const SizedBox(height: Dimens.space_16),
              // Alternate Parts Header
              _headerContainer(theme, l10n.alternatePartsAvailable),
              // Alternate Parts List using CshApiList
              Expanded(
                child: CshApiList<ListAlternateData>(
                  apiConfig: ListApiConfig(
                    apiUrl: "/part/list-alternate-parts?prid=${widget.arg?.prid}",
                    serviceGroup: TRCServiceGroups.unifyTrc,
                  ),
                  filterConfig: FilterConfig(),
                  controller: _listController,
                  itemFromJson: ListAlternateData.fromJson,
                  shimmerLoaderWidget: const CshShimmer(height: Dimens.space_60),
                  listPadding: const EdgeInsets.all(Dimens.space_8),
                  verticalRowSpacing: Dimens.space_6,
                  isHideCoreFilterButton: true,
                  getRowWidget: (item, index) {
                    final data = item;
                    return AlternatePartItemWidget(
                      dataModel: data,
                      onRequestCallback: () {
                        _showRequestAlternatePartRequest(
                          context,
                          theme,
                          l10n,
                          widget.arg?.prid ?? 0,
                          data?.productName ?? "",
                          data?.sku ?? "",
                          data?.partVariantName ?? "",
                          widget.arg,
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _headerContainer(ThemeData theme, String label) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: Dimens.space_8),
      height: Dimens.space_50,
      width: double.infinity,
      alignment: Alignment.centerLeft,
      color: theme.primaryColor,
      padding: const EdgeInsets.symmetric(horizontal: Dimens.space_16),
      child: Text(
        label,
        style: theme.primaryTextTheme.headlineMedium?.copyWith(color: theme.cardColor),
      ),
    );
  }

  Widget _labelAndValueWidget(ThemeData theme, String label, String value) {
    return Row(
      children: [
        Expanded(
          child: Text(
            "$label: ",
            style: theme.primaryTextTheme.headlineMedium?.copyWith(color: theme.primaryColor),
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: theme.primaryTextTheme.headlineMedium,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            textDirection: TextDirection.rtl,
          ),
        )
      ],
    );
  }

  void _showRequestAlternatePartRequest(BuildContext context, ThemeData theme, L10n l10n, int partId,
      String productName, String sku, String partVariantName, AlternatePartArguments? args) {
    showCshBottomSheet(
      context: context,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: Dimens.space_12, horizontal: Dimens.space_16),
        child: Column(
          children: [
            Text(
              "Are you sure you want to request part $sku",
              style: theme.primaryTextTheme.displaySmall,
            ),
            const SizedBox(height: Dimens.space_16),
            ComboButton(
              firstBtnText: l10n.no,
              secondBtnText: l10n.yes,
              buttonType: ButtonType.mini,
              isFirstPrimary: true,
              firstBtnClick: () {
                Navigator.of(context).pop();
              },
              secondBtnClick: () {
                Navigator.of(context).pop();
                _requestAlternativePart(context, l10n, partId, productName, partVariantName, sku, args);
              },
            )
          ],
        ),
      ),
    );
  }

  void _requestAlternativePart(BuildContext context, L10n l10n, int partId, String productName, String partVariantName,
      String sku, AlternatePartArguments? args) {
    var provider = AlternatePartListProvider.of(context, listen: false);
    CshLoading().showLoading(context);
    provider
        .alternatePartRequest(partId, productName, sku, args?.detailsModelData?.deviceId ?? -1, partVariantName)
        .then((value) {
      CshLoading().hideLoading(context);
      if (value) {
        CshSnackBar.success(context: context, message: l10n.alternatePartDataFetched);
        AssignPartBarcodeCompArguments arg = AssignPartBarcodeCompArguments(
            arguments: AssignBarcodeScannerArguments(
                pendingDeviceDetailData: args?.detailsModelData,
                detailsData: args?.itemDataModel,
                prid: args?.prid ?? 0));

        Navigator.of(context).pushNamed(AssignPartBarcodeScreen.route, arguments: arg);
      }
    }, onError: (error) {
      CshLoading().hideLoading(context);
      CshSnackBar.error(context: context, message: error);
    });
  }
}
