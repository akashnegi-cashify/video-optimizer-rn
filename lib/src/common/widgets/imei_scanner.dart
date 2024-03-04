import 'package:builder_component/builder_component.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/src/app_builder/app_headers/qc_general_header/widgets/qc_general_header.dart';
import 'package:imei_serial_reader/imei_serial_reader.dart';
import 'package:imei_serial_reader/reader_type.dart';
import 'package:provider/provider.dart';

class ImeiScanner extends StatelessWidget {
  final Function(List<String>? scannedList)? onProceed;

  const ImeiScanner({super.key, this.onProceed});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const QcGeneralHeader('Imei Reader'),
      body: Center(
        child: ChangeNotifierProvider(
          create: (_) => PageParamProvider(),
          child: ImeiSerialReader(
            configurationModel: ImeiSerialReaderConfig(
              readerType: ReaderType.imeiReader.value,
              retryButtonText: 'Retry',
              doneButtonText: 'Done',
            ),
            onDoneCallback: (List<String>? scannedList) {
              onProceed?.call(scannedList);
            },
          ),
        ),
      ),
    );
  }
}
