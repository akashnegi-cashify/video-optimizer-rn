import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:provider/provider.dart';
import '../../../screens/qr_barcode_scanner.dart';
import '../l10n.dart';
import '../models/assigned_device_details.dart';
import '../models/parts_details_response.dart';
import '../models/pending_device_list_response.dart';
import '../providers/assign_part_barcode_provider.dart';
import 'assigned_part_details_screen.dart';

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

class AssignBarcodeScannerScreen extends StatefulWidget {
  static const String route = "/assign_barcode_scanner_screen";

  const AssignBarcodeScannerScreen({Key? key}) : super(key: key);

  @override
  State<AssignBarcodeScannerScreen> createState() => _AssignBarcodeScannerScreenState();
}

class _AssignBarcodeScannerScreenState extends State<AssignBarcodeScannerScreen> {
  final TextEditingController _barcodeController = TextEditingController();

  bool _fieldActive = false;

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var l10n = L10n(context);
    var args = ModalRoute.of(context)?.settings.arguments as AssignBarcodeScannerArguments;
    return ChangeNotifierProvider<AssignPartBarcodeProvider>(
      create: (_) => AssignPartBarcodeProvider(args.prid),
      lazy: false,
      builder: (BuildContext insideContext, __) {
        return Scaffold(
          appBar: CshHeader(
            l10n.assignBarcodeScreen,
            showBackBtn: true,
          ),
          body: Padding(
            padding: const EdgeInsets.all(Dimens.space_8),
            child: Column(
              children: [
                _partDetailsWidget(theme, l10n, args),
                const SizedBox(height: Dimens.space_8),
                Expanded(
                  child: QrBarcodeScanner(
                    onResultantCallback: (String data) {
                      if (data.isNotEmpty) {
                        _assignBarcode(insideContext, data.trim(), args);
                      }
                    },
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: Dimens.space_120,
                  color: theme.backgroundColor,
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
                                    _assignBarcode(insideContext, data, args);
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
          ),
        );
      },
    );
  }

  _assignBarcode(BuildContext context, String barcode, AssignBarcodeScannerArguments arg) {
    var provider = AssignPartBarcodeProvider.of(context, listen: false);
    CshLoading().showLoading(context);
    provider.assignPartBarcode(barcode).then((value) {
      CshLoading().hideLoading(context);
      if (value) {
        CshSnackBar.success(context: context, message: "$barcode assigned successfully");
        AssignedPartDetailsArguments args = AssignedPartDetailsArguments(
          prid: arg.prid,
          assignDeviceDetailsData: AssignDeviceDetailsData(
            did: arg.pendingDeviceDetailData?.did,
            lc: arg.pendingDeviceDetailData?.lc,
            engineerName: arg.pendingDeviceDetailData?.engineerName,
            deviceBarcode: arg.pendingDeviceDetailData?.deviceBarcode,
            grade: arg.pendingDeviceDetailData?.grade,
            repairType: arg.pendingDeviceDetailData?.repairType,
            productName: arg.pendingDeviceDetailData?.pt,
          ),
        );
        Navigator.of(context).pop();
        Navigator.of(context).pop();
        Navigator.of(context).pushNamed(AssignedPartDetailsScreen.route, arguments: args);
      }
    }, onError: (error) {
      CshLoading().hideLoading(context);
      CshSnackBar.error(context: context, message: error);
    });
  }

  _partDetailsWidget(ThemeData theme, L10n l10n, AssignBarcodeScannerArguments data) {
    return CshCard(
      radius: CshRadius.rad8,
      elevation: CardElevation.dimen_10,
      padding: const EdgeInsets.all(Dimens.space_8),
      child: Column(
        children: [
          if (!Validator.isNullOrEmpty(data.detailsData?.partName)) ...[
            _labelValueWidget(theme, l10n.partName, data.detailsData!.partName!),
            const SizedBox(height: Dimens.space_8),
          ],
          if (!Validator.isNullOrEmpty(data.detailsData?.sku)) ...[
            _labelValueWidget(theme, l10n.partSku, data.detailsData!.sku!),
            const SizedBox(height: Dimens.space_8),
          ],
          if (!Validator.isNullOrEmpty(data.detailsData?.partColor)) ...[
            _labelValueWidget(theme, l10n.partColor, data.detailsData!.partColor!),
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
            style: theme.primaryTextTheme.headline5?.copyWith(color: theme.primaryColor),
          ),
        ),
        const SizedBox(width: Dimens.space_8),
        Expanded(
          child: Text(
            value,
            textDirection: TextDirection.rtl,
            style: theme.primaryTextTheme.headline5,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}
