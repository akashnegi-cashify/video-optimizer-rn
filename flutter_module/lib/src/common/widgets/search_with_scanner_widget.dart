import 'dart:async';

import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/src/common/utils/csh_ml_scanner_util.dart';

class SearchWithScannerWidget extends StatefulWidget {
  final String hintText;
  final Function(String barcode, bool isManualSearch) onQuery;
  final String? initialValue;

  const SearchWithScannerWidget(this.hintText, {this.initialValue, required this.onQuery, super.key});

  @override
  State<SearchWithScannerWidget> createState() => _SearchWithScannerWidgetState();
}

class _SearchWithScannerWidgetState extends State<SearchWithScannerWidget> {
  late final TextEditingController _searchController;
  Timer? _timer;

  @override
  void initState() {
    _searchController = TextEditingController(text: widget.initialValue);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CshTextFormField(
      hintText: widget.hintText,
      controller: _searchController,
      suffixIcon: InkWell(
        child: const Icon(Icons.qr_code_2),
        onTap: () {
          CshMlScannerUtil().openScanner(context, onScanned: (scannedData, controller) {
            Navigator.pop(context); // close scanner
            _searchController.text = scannedData;
            widget.onQuery(scannedData, false);
          });
        },
      ),
      onChanged: (value) {
        if (Validator.isTrue(_timer?.isActive)) {
          _timer?.cancel();
        }
        _timer = Timer(const Duration(milliseconds: 500), () {
          widget.onQuery(value, true);
        });
      },
    );
  }
}
