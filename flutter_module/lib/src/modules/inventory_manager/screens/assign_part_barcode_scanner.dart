import 'package:builder_project/builder_project.dart';
import 'package:core_widgets/core_widgets.dart';
import 'package:csh_annotation/annotation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_trc/src/app_builder/app_builder_groups/groups.dart';
import 'package:ml_barcode_scanner/widgets/ml_barcode_scanner_widget.dart';
import 'package:provider/provider.dart';

import '../l10n.dart';
import '../models/assign_part_barcode_scanner_param.dart';
import '../models/assigned_device_details.dart';
import '../models/parts_details_response.dart';
import '../models/pending_device_list_response.dart';
import '../providers/assign_part_barcode_provider.dart';
import 'assigned_part_details_screen.dart';

part 'assign_part_barcode_scanner.g.dart';

@CshPage(
    key: AssignPartBarcodeScreen.pageKey,
    params: AssignPartBarcodeScannerParamKeys.values,
    pageGroup: PageGroup.assignPartBarcodeScannerPageKey)
class AssignPartBarcodeCompArguments extends BaseArguments {
  final AssignBarcodeScannerArguments? arguments;

  AssignPartBarcodeCompArguments({this.arguments}) : super(AssignPartBarcodeScreen.pageKey);

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = {};
    data[AssignPartBarcodeScannerParamKeys.arguments.value] = arguments;
    return data;
  }
}

class AssignPartBarcodeScreen extends BaseScreen<AssignPartBarcodeCompArguments> {
  static const String pageKey = "TRC_assign_part_barcode_screen";
  static const String route = "/assign_part_barcode_screen";

  const AssignPartBarcodeScreen({super.key});

  @override
  Widget buildView(BuildContext context) {
    var args = getArguments(context);
    return PageWidget(
      pageKey: pageKey,
      initialValue: args?.toJson(),
    );
  }
}

class AssignBarcodeScannerArguments {
  final PartDetailsData? detailsData;
  final int prid;
  final PendingDeviceDetailData? pendingDeviceDetailData;

  AssignBarcodeScannerArguments({
    this.detailsData,
    this.pendingDeviceDetailData,
    required this.prid,
  });
}

class AssignBarcodeScannerCompWidget extends StatefulWidget {
  final AssignBarcodeScannerArguments? args;

  const AssignBarcodeScannerCompWidget({
    Key? key,
    this.args,
  }) : super(key: key);

  @override
  State<AssignBarcodeScannerCompWidget> createState() => _AssignBarcodeScannerCompWidgetState();
}

class _AssignBarcodeScannerCompWidgetState extends State<AssignBarcodeScannerCompWidget> {
  final TextEditingController _barcodeController = TextEditingController();

  bool _fieldActive = false;

  @override
  void initState() {
    _barcodeController.addListener(
      () {
        if (_barcodeController.text.isNotEmpty) {
          _fieldActive = true;
        } else {
          _fieldActive = false;
        }
        setState(() {});
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var l10n = L10n(context);

    return ChangeNotifierProvider<AssignPartBarcodeProvider>(
      create: (_) => AssignPartBarcodeProvider(widget.args?.prid),
      lazy: false,
      builder: (BuildContext insideContext, __) {
        return Padding(
          padding: const EdgeInsets.all(Dimens.space_8),
          child: Column(
            children: [
              _partDetailsWidget(theme, l10n, widget.args),
              const SizedBox(height: Dimens.space_8),
              Expanded(
                child: MlBarcodeScannerWidget(
                  allowDuplicateScan: false,
                  isPlayScanSound: true,
                  zoomScale: 0.5,
                  onScannerDetected: (String value, MlScannerController controller) {
                    if (value.isNotEmpty) {
                      _assignBarcode(insideContext, value.trim(), widget.args);
                    }
                  },
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                height: Dimens.space_120,
                color: theme.colorScheme.background,
                alignment: Alignment.center,
                padding: const EdgeInsets.symmetric(horizontal: Dimens.space_8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Stack(
                        alignment: Alignment.centerRight,
                        children: [
                          CshTextFormField(
                            controller: _barcodeController,
                            counterText: "",
                            autofocus: false,
                            maxLength: 50,
                            maxLines: 1,
                            hintText: l10n.enterBarcode,
                          ),
                          if (_fieldActive)
                            GestureDetector(
                              onTap: () {
                                _barcodeController.clear();
                                _fieldActive = false;
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
                    ),
                    const SizedBox(width: Dimens.space_8),
                    Padding(
                      padding: const EdgeInsets.only(bottom: Dimens.space_16),
                      child: CshMediumButton(
                        text: l10n.next,
                        onPressed: _fieldActive
                            ? () {
                                if (_barcodeController.text.isNotEmpty) {
                                  String data = _barcodeController.text.trim();
                                  _assignBarcode(insideContext, data, widget.args);
                                }
                              }
                            : null,
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  _assignBarcode(BuildContext context, String barcode, AssignBarcodeScannerArguments? arg) {
    var provider = AssignPartBarcodeProvider.of(context, listen: false);
    CshLoading().showLoading(context);
    provider.assignPartBarcode(barcode).then((value) {
      if (context.mounted) {
        CshLoading().hideLoading(context);
        if (value) {
          CshSnackBar.success(context: context, message: "$barcode assigned successfully");
          AssignedPartDetailsCompArguments arguments = AssignedPartDetailsCompArguments(
              args: AssignedPartDetailsArguments(
            prid: arg?.prid ?? 0,
            assignDeviceDetailsData: AssignDeviceDetailsData(
              did: arg?.pendingDeviceDetailData?.deviceId,
              lc: arg?.pendingDeviceDetailData?.location,
              engineerName: arg?.pendingDeviceDetailData?.engineerName,
              deviceBarcode: arg?.pendingDeviceDetailData?.deviceBarcode,
              grade: arg?.pendingDeviceDetailData?.grade,
              repairType: arg?.pendingDeviceDetailData?.repairType,
              productName: arg?.pendingDeviceDetailData?.productTitle,
            ),
          ));

          Navigator.of(context).pop();
          Navigator.of(context).pop();

          Navigator.of(context).pushNamed(AssignedPartDetailsScreen.route, arguments: arguments);
        }
      }
    }, onError: (error) {
      if (context.mounted) {
        CshSnackBar.error(context: context, message: error);
        CshLoading().hideLoading(context);
      }
    });
  }

  _partDetailsWidget(ThemeData theme, L10n l10n, AssignBarcodeScannerArguments? data) {
    return CshCard(
      radius: CshRadius.rad8,
      elevation: CardElevation.dimen_10,
      padding: const EdgeInsets.all(Dimens.space_8),
      child: Column(
        children: [
          if (!Validator.isNullOrEmpty(data?.detailsData?.partName)) ...[
            _labelValueWidget(theme, l10n.partName, data!.detailsData!.partName!),
            const SizedBox(height: Dimens.space_8),
          ],
          if (!Validator.isNullOrEmpty(data?.detailsData?.sku)) ...[
            _labelValueWidget(theme, l10n.partSku, data!.detailsData!.sku!),
            const SizedBox(height: Dimens.space_8),
          ],
          if (!Validator.isNullOrEmpty(data?.detailsData?.partColor)) ...[
            _labelValueWidget(theme, l10n.partColor, data!.detailsData!.partColor!),
          ],
        ],
      ),
    );
  }

  _labelValueWidget(ThemeData theme, String label, String value) {
    return Row(
      children: [
        Expanded(
          child: Text(
            label,
            style: theme.primaryTextTheme.headlineSmall?.copyWith(color: theme.primaryColor),
          ),
        ),
        const SizedBox(width: Dimens.space_8),
        Expanded(
          child: Text(
            value,
            textDirection: TextDirection.rtl,
            style: theme.primaryTextTheme.headlineSmall,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}
