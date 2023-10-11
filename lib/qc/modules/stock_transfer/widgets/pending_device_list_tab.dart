import 'package:calculator_ui/calculator_ui.dart';
import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/qc/modules/qc_tester/disputed_image_capture/screens/disputed_image_capture_barcode_scanner_screen.dart';
import 'package:flutter_trc/qc/modules/stock_transfer/models/pending_lot_detail_response.dart';
import 'package:flutter_trc/qc/modules/stock_transfer/providers/pending_lot_detail_provider.dart';
import 'package:flutter_trc/src/common/widgets/searchbar_widget.dart';
import 'package:ml_barcode_scanner/widgets/ml_barcode_scanner_widget.dart';

class PendingDeviceListTab extends StatefulWidget {
  const PendingDeviceListTab({super.key});

  @override
  State<PendingDeviceListTab> createState() => _PendingDeviceListTabState();
}

class _PendingDeviceListTabState extends State<PendingDeviceListTab> {
  @override
  Widget build(BuildContext context) {
    var provider = PendingLotDetailProvider.of(context);
    var data = provider.pendingLotDetailResponse;
    return Column(
      children: [
        const SizedBox(height: Dimens.space_8),
        CshTextNew.h2(data?.lotName ?? ""),
        const SizedBox(height: Dimens.space_4),
        CshTextNew.subTitle2("No of devices - ${data?.deviceCount}"),
        const SizedBox(height: Dimens.space_4),
        CshTextNew.subTitle2("Destination - ${data?.destinationFacility}"),
        const SizedBox(height: Dimens.space_4),
        CshTextNew.subTitle2("Status - ${data?.status}"),
        const SizedBox(height: Dimens.space_12),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: Dimens.space_16),
          child: Row(
            children: [
              Expanded(
                child: SearchbarWidget(
                  margin: EdgeInsets.zero,
                  hint: "Search barcode",
                  onQuery: (String query) {
                    provider.setQuery(query);
                  },
                ),
              ),
              const SizedBox(width: Dimens.space_8),
              InkWell(
                  onTap: () {
                    DisputedImageCaptureBarcodeScannerArguments args = DisputedImageCaptureBarcodeScannerArguments(
                        onScanDetected: (String scannedData, MlScannerController? controller) {
                          if (scannedData.isNotEmpty) {
                            Navigator.of(context).pop();
                            provider.setQuery(scannedData);
                          }
                        },
                        header: "Scan Barcode",
                        hintText: "Scan barcode");
                    Navigator.of(context).pushNamed(DisputedImageCaptureBarcodeScanner.route, arguments: args);
                  },
                  child: const Icon(Icons.qr_code_2, size: Dimens.space_32)),
            ],
          ),
        ),
        const SizedBox(height: Dimens.space_12),
        Expanded(
          child: CshList(
            rowCount: provider.deviceList?.length ?? 0,
            listPadding: const EdgeInsets.all(Dimens.space_16),
            getRowWidget: (index) {
              var item = provider.deviceList?[index];
              return SizedBox(
                  width: double.infinity,
                  child: _DeviceItemWidget(
                    item,
                    index: index,
                    onDeviceRemove: () {
                      CshLoading().showLoading(context);
                      provider.removeDeviceFromLot(item?.qrCode).then((value) {
                        CshLoading().hideLoading(context);
                      }, onError: (error) {
                        CshLoading().hideLoading(context);
                        CshSnackBar.error(context: context, message: error);
                      });
                    },
                  ));
            },
          ),
        )
      ],
    );
  }
}

class _DeviceItemWidget extends StatelessWidget {
  final PendingLotDeviceListData? item;
  final int index;
  final VoidCallback onDeviceRemove;

  const _DeviceItemWidget(this.item, {super.key, required this.index, required this.onDeviceRemove});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return CshCard(
      cardWidth: double.infinity,
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CshTextNew.h3("${index + 1}) ${item?.qrCode}"),
              const SizedBox(height: Dimens.space_16),
              _buildLabelValueWidget("Model", item?.model ?? "", theme),
              const SizedBox(height: Dimens.space_6),
              _buildLabelValueWidget("Brand", item?.brand ?? "", theme),
              const SizedBox(height: Dimens.space_6),
              _buildLabelValueWidget("Source", item?.source ?? "", theme),
              const SizedBox(height: Dimens.space_6),
              _buildLabelValueWidget("Added by", item?.createdBy ?? "", theme),
              const SizedBox(height: Dimens.space_6),
              _buildLabelValueWidget("Added at",
                  formatDate(timeStamp: item?.createdDate, pattern: DateFormats.dd_MMM_yyyy_HH_mm_ss.value), theme),
            ],
          ),
          Positioned(
            top: 0,
            right: 0,
            child: InkWell(
              onTap: () {
                showErrorDialog(context, "IMEI - ${item?.imeiNo}", "Information", "Ok", (p0) => Navigator.pop(context));
              },
              child: const Icon(Icons.info, size: Dimens.space_24),
            ),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: InkWell(
              onTap: () {
                showPopup(context,
                    title: "Remove Device",
                    desc: "Do you want to remove device ${item?.qrCode} from lot",
                    actions: [
                      CshMediumButton(
                        text: "Yes",
                        onPressed: () {
                          Navigator.pop(context); // dismissDialog
                          onDeviceRemove();
                        },
                      ),
                      CshMediumButton(
                        text: "No",
                        onPressed: () {
                          Navigator.pop(context); // dismissDialog
                        },
                      ),
                    ]);
              },
              child: const Icon(Icons.delete_forever, size: Dimens.space_24),
            ),
          )
        ],
      ),
    );
  }

  _buildLabelValueWidget(String label, String value, ThemeData theme) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Flexible(flex: 2, fit: FlexFit.tight, child: CshTextNew.bodyText2(label)),
        Flexible(flex: 5, child: Text(value, maxLines: 2, style: theme.primaryTextTheme.headlineMedium))
      ],
    );
  }
}
