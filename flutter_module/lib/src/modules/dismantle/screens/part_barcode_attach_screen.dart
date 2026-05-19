import 'package:core/core.dart';
import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/src/common/utils/csh_ml_scanner_util.dart';
import 'package:flutter_trc/src/header/trc_header.dart';
import 'package:flutter_trc/src/modules/dismantle/resources/dismantle_service.dart';

class PartBarcodeAttachScreen extends StatefulWidget {
  final String deviceBarcode;

  const PartBarcodeAttachScreen({super.key, required this.deviceBarcode});

  @override
  State<PartBarcodeAttachScreen> createState() => _PartBarcodeAttachScreenState();
}

class _PartBarcodeAttachScreenState extends State<PartBarcodeAttachScreen> {
  Map<String, String> _partTypes = {};
  final Map<String, String> _attachedBarcodes = {};
  bool _isLoading = true;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _loadPartTypes();
  }

  void _loadPartTypes() {
    DismantleService.getPartTypes().listen((event) {
      if (mounted) {
        setState(() {
          _isLoading = false;
          if (event != null && event.isSuccess && event.responseData != null) {
            _partTypes = event.responseData!;
          } else {
            _errorMessage = "Failed to load part types";
          }
        });
      }
    }, onError: (error) {
      if (mounted) {
        setState(() {
          _isLoading = false;
          _errorMessage = ApiErrorHelper.getErrorMessage(error) ?? "Something went wrong";
        });
      }
    });
  }

  void _onAttach(String partId, String partName) {
    CshMlScannerUtil().openScanner(
      context,
      header: "Scan $partName Barcode",
      onScanned: (scannedData, controller) {
        Navigator.pop(context);
        setState(() {
          _attachedBarcodes[partName] = scannedData.trim();
        });
      },
    );
  }

  void _onSubmit() {
    if (_attachedBarcodes.isEmpty) {
      CshSnackBar.error(context: context, message: "Please attach at least one barcode");
      return;
    }

    List<Map<String, String>> parts = _attachedBarcodes.entries
        .map((e) => {"partName": e.key, "barcode": e.value})
        .toList();

    CshLoading().showLoading(context);
    DismantleService.markDone(widget.deviceBarcode, parts).listen((event) {
      if (context.mounted) {
        CshLoading().hideLoading(context);
        if (event != null && event.isSuccess) {
          CshSnackBar.success(context: context, message: event.successMessage ?? "Device marked done");
          Navigator.pop(context, true);
        } else {
          CshSnackBar.error(
            context: context,
            message: event?.errorMsg ?? "Something went wrong",
            snackBarPosition: SnackBarPosition.TOP,
          );
        }
      }
    }, onError: (error) {
      if (context.mounted) {
        CshLoading().hideLoading(context);
        String errorMessage = ApiErrorHelper.getErrorMessage(error) ?? "Something went wrong";
        CshSnackBar.error(context: context, message: errorMessage);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TrcHeader("Attach Barcodes"),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _errorMessage != null
              ? Center(child: CshTextNew.h4(_errorMessage!))
              : Column(
                  children: [
                    Expanded(
                      child: ListView.separated(
                        padding: const EdgeInsets.all(Dimens.space_16),
                        itemCount: _partTypes.length,
                        separatorBuilder: (_, __) => const SizedBox(height: Dimens.space_12),
                        itemBuilder: (context, index) {
                          final partId = _partTypes.keys.elementAt(index);
                          final partName = _partTypes[partId]!;
                          final attachedBarcode = _attachedBarcodes[partName];

                          return CshCard(
                            child: Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      CshTextNew.subTitle2(partName),
                                      if (attachedBarcode != null)
                                        Padding(
                                          padding: const EdgeInsets.only(top: Dimens.space_4),
                                          child: CshTextNew.h4(attachedBarcode, isPrimary: false),
                                        ),
                                    ],
                                  ),
                                ),
                                CshMediumOutlineButton(
                                  text: attachedBarcode != null ? "Re-scan" : "Attach",
                                  onPressed: () => _onAttach(partId, partName),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(Dimens.space_16),
                      child: SizedBox(
                        width: double.infinity,
                        child: CshBigButton(
                          text: "Submit",
                          onPressed: _onSubmit,
                        ),
                      ),
                    ),
                  ],
                ),
    );
  }
}
