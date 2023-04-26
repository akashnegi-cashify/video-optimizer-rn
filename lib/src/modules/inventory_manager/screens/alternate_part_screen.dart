import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../l10n.dart';
import '../models/parts_details_response.dart';
import '../models/pending_device_list_response.dart';
import '../providers/alternate_part_list_provider.dart';
import '../widgets/alternate_part_item_widget.dart';
import 'assign_part_barcode_scanner.dart';

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

class AlternatePartScreen extends StatefulWidget {
  static const String route = "/alternate_part_screen";

  const AlternatePartScreen({Key? key}) : super(key: key);

  @override
  State<AlternatePartScreen> createState() => _AlternatePartScreenState();
}

class _AlternatePartScreenState extends State<AlternatePartScreen> {
  @override
  Widget build(BuildContext context) {
    var arg = ModalRoute.of(context)?.settings.arguments as AlternatePartArguments;
    var l10n = L10n(context);
    var theme = Theme.of(context);
    return ChangeNotifierProvider<AlternatePartListProvider>(
      create: (_) => AlternatePartListProvider(arg.prid),
      lazy: false,
      builder: (BuildContext insideContext, __) {
        var provider = AlternatePartListProvider.of(insideContext);
        if (provider.isDataLoading) {
          return const Scaffold(
            body: Center(
              child: SizedBox(
                width: Dimens.space_30,
                height: Dimens.space_30,
                child: CircularProgressIndicator(),
              ),
            ),
          );
        } else if (provider.isDataLoading == false && !Validator.isNullOrEmpty(provider.errorMessage)) {
          return Scaffold(
            appBar: CshHeader(
              l10n.alternatePartList,
              showBackBtn: true,
            ),
            body: Center(
              child: Row(
                children: [
                  const SizedBox.shrink(),
                  Expanded(
                    child: Text(
                      provider.errorMessage,
                      style: theme.primaryTextTheme.headline4,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
          );
        } else {
          return Scaffold(
            appBar: CshHeader(
              l10n.alternatePartList,
              showBackBtn: true,
            ),
            body: Padding(
              padding: const EdgeInsets.symmetric(vertical: Dimens.space_12),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: Dimens.space_8),
                    child: CshCard(
                      child: Column(
                        children: [
                          if (!Validator.isNullOrEmpty(arg.detailsModelData?.deviceBarcode)) ...[
                            _labelAndValueWidget(theme, l10n.deviceBarcode, arg.detailsModelData!.deviceBarcode!),
                            const SizedBox(height: Dimens.space_8),
                          ],
                          if (!Validator.isNullOrEmpty(arg.detailsModelData?.pt)) ...[
                            _labelAndValueWidget(theme, l10n.deviceName, arg.detailsModelData!.pt!),
                            const SizedBox(height: Dimens.space_8),
                          ],
                          if (!Validator.isNullOrEmpty(arg.detailsModelData?.engineerName)) ...[
                            _labelAndValueWidget(theme, l10n.engineerSName, arg.detailsModelData!.engineerName!),
                            const SizedBox(height: Dimens.space_8),
                          ],
                          if (!Validator.isNullOrEmpty(arg.detailsModelData?.lc)) ...[
                            _labelAndValueWidget(theme, l10n.location, arg.detailsModelData!.lc!),
                            const SizedBox(height: Dimens.space_8),
                          ],
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: Dimens.space_16),
                  _headerContainer(theme, l10n.originalPartRequest),
                  const SizedBox(height: Dimens.space_8),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: Dimens.space_8),
                    child: CshCard(
                      child: Column(
                        children: [
                          if (!Validator.isNullOrEmpty(arg.itemDataModel?.partName)) ...[
                            _labelAndValueWidget(theme, l10n.partName, arg.itemDataModel!.partName!),
                            const SizedBox(height: Dimens.space_6),
                          ],
                          if (!Validator.isNullOrEmpty(arg.itemDataModel?.sku)) ...[
                            _labelAndValueWidget(theme, l10n.partName, arg.itemDataModel!.sku!),
                            const SizedBox(height: Dimens.space_6),
                          ],
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: Dimens.space_16),
                  if (!Validator.isListNullOrEmpty(provider.listAlternatePartsResponse?.dataList)) ...[
                    _headerContainer(theme, l10n.alternatePartsAvailable),
                    ListView.separated(
                      shrinkWrap: true,
                      padding: const EdgeInsets.all(Dimens.space_8),
                      itemBuilder: (context, index) {
                        return AlternatePartItemWidget(
                          dataModel: provider.listAlternatePartsResponse!.dataList![index],
                          onRequestCallback: () {
                            _showRequestAlternatePartRequest(
                              context,
                              theme,
                              l10n,
                              arg.prid,
                              provider.listAlternatePartsResponse!.dataList![index].productName ?? "",
                              provider.listAlternatePartsResponse!.dataList![index].sku ?? "",
                              arg,
                            );
                          },
                        );
                      },
                      separatorBuilder: (context, index) {
                        return const SizedBox(height: Dimens.space_6);
                      },
                      itemCount: provider.listAlternatePartsResponse!.dataList!.length,
                    )
                  ]
                ],
              ),
            ),
          );
        }
      },
    );
  }

  _headerContainer(ThemeData theme, String label) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: Dimens.space_8),
      height: Dimens.space_50,
      width: double.infinity,
      alignment: Alignment.centerLeft,
      color: theme.primaryColor,
      padding: const EdgeInsets.symmetric(horizontal: Dimens.space_16),
      child: Text(
        label,
        style: theme.primaryTextTheme.headline4?.copyWith(color: theme.cardColor),
      ),
    );
  }

  _labelAndValueWidget(ThemeData theme, String label, String value) {
    return Row(
      children: [
        Expanded(
          child: Text(
            "$label: ",
            style: theme.primaryTextTheme.headline4?.copyWith(color: theme.primaryColor),
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: theme.primaryTextTheme.headline4,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            textDirection: TextDirection.rtl,
          ),
        )
      ],
    );
  }

  _showRequestAlternatePartRequest(BuildContext context, ThemeData theme, L10n l10n, int partId, String productName,
      String sku, AlternatePartArguments args) {
    showCshBottomSheet(
      context: context,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: Dimens.space_12, horizontal: Dimens.space_16),
        child: Column(
          children: [
            Text(
              "Are you sure you want to request part $sku",
              style: theme.primaryTextTheme.headline3,
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
                _requestAlternativePart(context, l10n, partId, productName, sku, args);
              },
            )
          ],
        ),
      ),
    );
  }

  _requestAlternativePart(
      BuildContext context, L10n l10n, int partId, String productName, String sku, AlternatePartArguments args) {
    var provider = AlternatePartListProvider.of(context, listen: false);
    CshLoading().showLoading(context);
    provider.alternatePartRequest(partId, productName, sku, args.detailsModelData?.did ?? -1).then((value) {
      CshLoading().hideLoading(context);
      if (value) {
        CshSnackBar.success(context: context, message: l10n.alternatePartDataFetched);
        AssignBarcodeScannerArguments arguments = AssignBarcodeScannerArguments(
            pendingDeviceDetailData: args.detailsModelData, detailsData: args.itemDataModel, prid: args.prid);
        Navigator.of(context).pushNamed(AssignBarcodeScannerScreen.route, arguments: arguments);
      }
    }, onError: (error) {
      CshLoading().hideLoading(context);
      CshSnackBar.error(context: context, message: error);
    });
  }
}
