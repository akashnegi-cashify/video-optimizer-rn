import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/qc/modules/re_qc/models/lot_device_list_response.dart';
import 'package:flutter_trc/src/common/widgets/searchbar_widget.dart';

class DeviceListTab extends StatelessWidget {
  final List<LotDeviceListData> deviceList;

  DeviceListTab({super.key, required this.deviceList});

  final ValueNotifier<String> queryNotifier = ValueNotifier("");

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.all(Dimens.space_16),
      child: ValueListenableBuilder<String>(
        builder: (_, value, child) {
          var list = _getDeviceList();
          return Column(
            children: [
              SearchbarWidget(
                hint: "Barcode",
                margin: EdgeInsets.zero,
                onQuery: (query) {
                  queryNotifier.value = query;
                },
              ),
              const SizedBox(height: Dimens.space_16),
              Expanded(
                child: Table(
                  border: TableBorder.all(),
                  columnWidths: const <int, TableColumnWidth>{
                    0: FlexColumnWidth(),
                    1: FlexColumnWidth(),
                  },
                  children: [
                    TableRow(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(Dimens.space_8),
                          child: Text("Barcode", style: theme.textTheme.displayMedium),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(Dimens.space_8),
                          child: Text("Status", style: theme.textTheme.displayMedium),
                        )
                      ],
                    ),
                    ...List.generate(list.length, (index) {
                      var data = list[index];
                      return TableRow(children: [
                        Padding(
                          padding: const EdgeInsets.all(Dimens.space_4),
                          child: Text(data.qrCode ?? "", style: theme.textTheme.titleMedium),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(Dimens.space_4),
                          child: Text(data.statusDescription ?? "", style: theme.textTheme.titleMedium),
                        )
                      ], decoration: BoxDecoration(color: index.isEven ? Colors.grey[200] : Colors.white));
                    })
                  ],
                ),
              ),
            ],
          );
        },
        valueListenable: queryNotifier,
      ),
    );
  }

  List<LotDeviceListData> _getDeviceList() {
    if (queryNotifier.value.isEmpty) {
      return deviceList;
    }

    return deviceList
        .where((element) => element.qrCode?.toLowerCase().contains(queryNotifier.value.toLowerCase()) ?? false)
        .toList();
  }
}
