import 'package:core/core.dart';
import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/src/common/receive_device/laptop_receive_device_enum.dart';
import 'package:flutter_trc/src/common/receive_device/receive_device_service.dart';
import 'package:flutter_trc/src/common/utils/csh_ml_scanner_util.dart';
import 'package:flutter_trc/src/header/trc_header.dart';
import 'package:flutter_trc/src/libraries/shared_preferences/app_preferences.dart';
import 'package:flutter_trc/src/modules/laptop_assembly/resources/assembly_parts_response.dart';
import 'package:flutter_trc/src/modules/laptop_assembly/resources/laptop_assembly_service.dart';
import 'package:flutter_trc/src/modules/laptop_assembly/widgets/assembly_scan_progress_view.dart';
import 'package:flutter_trc/src/modules/laptop_assembly/widgets/child_part_widget.dart';

const int _kAssemblyScannedStatusCode = 143;

class AssemblyPartsDetailScreen extends StatefulWidget {
  final String parentBarcode;

  const AssemblyPartsDetailScreen({super.key, required this.parentBarcode});

  @override
  State<AssemblyPartsDetailScreen> createState() => _AssemblyPartsDetailScreenState();
}

class _AssemblyPartsDetailScreenState extends State<AssemblyPartsDetailScreen> {
  bool _isLoading = true;
  String? _errorMessage;
  List<AssemblyChildPart> _parts = [];
  final ValueNotifier<List<String>> _sessionScans = ValueNotifier<List<String>>([]);

  int get _scannedCount => _parts.where((p) => p.statusCode == _kAssemblyScannedStatusCode).length;
  bool get _allScanned => _parts.isNotEmpty && _scannedCount == _parts.length;

  @override
  void initState() {
    super.initState();
    _loadParts();
  }

  @override
  void dispose() {
    _sessionScans.dispose();
    super.dispose();
  }

  void _loadParts() {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });
    LaptopAssemblyService.getChildParts(widget.parentBarcode).listen((event) {
      if (!mounted) return;
      setState(() {
        _isLoading = false;
        if (event != null && event.isSuccess) {
          _parts = event.responseData ?? [];
        } else {
          _errorMessage = event?.errorMsg ?? "Failed to load child parts";
        }
      });
    }, onError: (error) {
      if (!mounted) return;
      setState(() {
        _isLoading = false;
        _errorMessage = ApiErrorHelper.getErrorMessage(error) ?? "Something went wrong";
      });
    });
  }

  void _openScanner() {
    _sessionScans.value = [];
    CshMlScannerUtil().openScanner(
      context,
      header: "Scan Child Part",
      bottomView: AssemblyScanProgressView(
        parentBarcode: widget.parentBarcode,
        scannedBarcodes: _sessionScans,
        onManualSubmit: (barcode) => _submitScan(barcode),
      ),
      onScanned: (barcode, controller) => _submitScan(barcode, controller: controller),
      onDidPop: _loadParts,
    );
  }

  void _submitScan(String barcode, {dynamic controller}) {
    controller?.stop();
    final int facilityId = AppPreferences.trc.getFacility()?.id ?? 0;
    ReceiveDeviceService.scanDevice(barcode, LaptopReceiveDeviceEnum.laptopAssembly, facilityId).listen((event) {
      if (!mounted) return;
      _sessionScans.value = [barcode, ..._sessionScans.value];
      CshSnackBar.success(context: context, message: event?.successMsg ?? "Child device scanned");
    }, onError: (error) {
      if (!mounted) return;
      String errorMessage = ApiErrorHelper.getErrorMessage(error) ?? "Something went wrong";
      CshSnackBar.error(context: context, message: errorMessage);
    }, onDone: () {
      Future.delayed(const Duration(milliseconds: 300), () {
        controller?.start();
      });
    });
  }

  void _onMarkDone() {
    showDialog(
      context: context,
      useRootNavigator: false,
      builder: (dialogContext) {
        return AlertDialog(
          title: CshTextNew.subTitle1("Confirm"),
          content: CshTextNew.h4("Mark assembly done for ${widget.parentBarcode}?"),
          actions: [
            TextButton(onPressed: () => Navigator.pop(dialogContext), child: CshTextNew.h4("Cancel")),
            TextButton(
              onPressed: () {
                Navigator.pop(dialogContext);
                _callMarkDone();
              },
              child: CshTextNew.h4("Proceed"),
            ),
          ],
        );
      },
    );
  }

  void _callMarkDone() {
    CshLoading().showLoading(context);
    LaptopAssemblyService.markDone(widget.parentBarcode).listen((event) {
      if (!mounted) return;
      CshLoading().hideLoading(context);
      if (event != null && event.isSuccess) {
        CshSnackBar.success(context: context, message: event.successMsg ?? "Assembly done");
        Navigator.pop(context, true);
      } else {
        CshSnackBar.error(
          context: context,
          message: event?.errorMsg ?? "Something went wrong",
          snackBarPosition: SnackBarPosition.TOP,
        );
      }
    }, onError: (error) {
      if (!mounted) return;
      CshLoading().hideLoading(context);
      String errorMessage = ApiErrorHelper.getErrorMessage(error) ?? "Something went wrong";
      CshSnackBar.error(context: context, message: errorMessage);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TrcHeader("Assembly Parts"),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _errorMessage != null
              ? _buildErrorState()
              : _parts.isEmpty
                  ? _buildEmptyState()
                  : _buildPartsList(),
      bottomNavigationBar: _isLoading || _errorMessage != null ? null : _buildBottomBar(),
    );
  }

  Widget _buildPartsList() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(Dimens.space_16, Dimens.space_16, Dimens.space_16, Dimens.space_8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CshTextNew.subTitle1(widget.parentBarcode),
              const SizedBox(height: Dimens.space_4),
              CshTextNew.h4("Progress: $_scannedCount / ${_parts.length} scanned", isPrimary: false),
            ],
          ),
        ),
        Expanded(
          child: ListView.separated(
            padding: const EdgeInsets.symmetric(horizontal: Dimens.space_16, vertical: Dimens.space_8),
            itemCount: _parts.length,
            separatorBuilder: (_, __) => const SizedBox(height: Dimens.space_12),
            itemBuilder: (_, i) => ChildPartWidget(part: _parts[i]),
          ),
        ),
      ],
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(Dimens.space_24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CshTextNew.h4("No child parts found", isPrimary: false),
            const SizedBox(height: Dimens.space_16),
            CshMediumOutlineButton(text: "Refresh", onPressed: _loadParts),
          ],
        ),
      ),
    );
  }

  Widget _buildErrorState() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(Dimens.space_24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CshTextNew.h4(_errorMessage!),
            const SizedBox(height: Dimens.space_16),
            CshMediumOutlineButton(text: "Retry", onPressed: _loadParts),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomBar() {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(Dimens.space_16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            CshBigButton(text: "Scan Child Parts", onPressed: _openScanner),
            if (_parts.isNotEmpty) ...[
              const SizedBox(height: Dimens.space_12),
              CshBigButton(
                text: "Mark Assembly Done",
                onPressed: _allScanned ? _onMarkDone : null,
              ),
            ],
          ],
        ),
      ),
    );
  }
}
