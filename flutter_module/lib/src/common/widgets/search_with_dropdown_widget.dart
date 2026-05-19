import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/src/common/utils/csh_ml_scanner_util.dart';

class SearchWithDropdownWidget extends StatefulWidget {
  final List<SearchType> searchTypeValues;
  final Function(DropDownItem<SearchType> item) onDropDownChange;
  final Function(SearchType type, String value) onSearch;
  final EdgeInsets padding;

  const SearchWithDropdownWidget(
      {super.key,
      required this.searchTypeValues,
      required this.onDropDownChange,
      required this.onSearch,
      this.padding = EdgeInsets.zero});

  @override
  State<SearchWithDropdownWidget> createState() => _SearchWithDropdownWidgetState();
}

class _SearchWithDropdownWidgetState extends State<SearchWithDropdownWidget> {
  final TextEditingController _searchController = TextEditingController();
  final TextInputDebounce _timer = TextInputDebounce();
  DropDownItem<SearchType>? _selectedSearchType;
  final List<DropDownItem<SearchType>> _dropDownItems = [];

  @override
  void initState() {
    for (var element in widget.searchTypeValues) {
      _dropDownItems.add(DropDownItem(element.code, element.label, extraData: element));
    }
    _selectedSearchType = _dropDownItems[0];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: widget.padding,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Flexible(
            flex: 1,
            fit: FlexFit.tight,
            child: CshDropDown(
              items: _dropDownItems,
              selectedItem: _selectedSearchType,
              onChanged: (DropDownItem<SearchType> value) {
                setState(() {
                  _selectedSearchType = value;
                  _searchController.text = "";
                  if (_isBarcodeSearchSelected(value.id)) {
                    _openScanner();
                  }
                  widget.onDropDownChange(value);
                });
              },
            ),
          ),
          Flexible(
            flex: 2,
            fit: FlexFit.tight,
            child: CshTextFormField(
              hintText: _selectedSearchType?.extraData?.hintName ?? "",
              controller: _searchController,
              readOnly: _isBarcodeSearchSelected(_selectedSearchType?.id) ? true : false,
              onTap: () {
                if (_isBarcodeSearchSelected(_selectedSearchType?.id)) {
                  _openScanner();
                }
              },
              suffixIcon: _isBarcodeSearchSelected(_selectedSearchType?.id)
                  ? InkWell(child: const Icon(Icons.qr_code_2), onTap: () => _openScanner())
                  : null,
              onChanged: (value) {
                // if (value.length > 2) {
                _timer.start(() {
                  widget.onSearch(_selectedSearchType!.extraData!, value);
                });
                // }
              },
            ),
          ),
        ],
      ),
    );
  }

  bool _isBarcodeSearchSelected(String? id) {
    return id == "br";
  }

  void _openScanner() {
    CshMlScannerUtil().openScanner(context, onScanned: (scannedData, controller) {
      Navigator.pop(context); // close scanner
      _searchController.text = scannedData;
      widget.onSearch(_selectedSearchType!.extraData!, scannedData);
    });
  }
}

mixin SearchType {
  String get code;

  String get label;

  String get hintName;
}

enum LotSearchType with SearchType {
  lotName("ln", "Lot Name", "Search by name"),
  barcode("br", "Barcode", "Search by barcode");

  @override
  final String code;

  @override
  final String label;

  @override
  final String hintName;

  const LotSearchType(this.code, this.label, this.hintName);
}
