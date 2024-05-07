import 'dart:async';

import 'package:builder_component/builder_component.dart';
import 'package:camera/camera.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/src/app_builder/app_headers/qc_general_header/widgets/qc_general_header.dart';
import 'package:flutter_trc/src/libraries/firebase/remote_config_helper.dart';
import 'package:imei_serial_reader/imei_serial_reader.dart';
import 'package:imei_serial_reader/reader_type.dart';
import 'package:provider/provider.dart';

class ImeiScanner extends StatefulWidget {
  final Function(List<String>? scannedList)? onProceed;
  final VoidCallback? onTimeOut;

  const ImeiScanner({super.key, this.onProceed, this.onTimeOut});

  @override
  State<ImeiScanner> createState() => _ImeiScannerState();
}

class _ImeiScannerState extends State<ImeiScanner> {
  Timer? _timer;

  @override
  void initState() {
    scheduleMicrotask(() {
      var timeOutInSec = RemoteConfigHelper().getInt(AppRemoteConfig.KEY_IMEI_READER_TIMEOUT_SEC);
      _timer = Timer(Duration(seconds: timeOutInSec), () {
        widget.onTimeOut?.call();
      });
      super.initState();
    });
  }

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
            onDoneCallback: (List<String>? scannedList, {CameraImage? imageRawData}) {
              widget.onProceed?.call(scannedList);
            },
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}
