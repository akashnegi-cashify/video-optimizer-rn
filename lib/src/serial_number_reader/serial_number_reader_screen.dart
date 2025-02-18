import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/src/common/widgets/serial_text_reader_vision.dart';
import 'package:imei_serial_reader/reader_type.dart';

class SerialNumberReaderScreen extends StatefulWidget {
  const SerialNumberReaderScreen({super.key});

  @override
  State<SerialNumberReaderScreen> createState() => _SerialNumberReaderScreenState();
}

class _SerialNumberReaderScreenState extends State<SerialNumberReaderScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CshHeader("Serail Number Reader"),
      body: Column(
        children: [
          SerialTextVisionWidget(key: ValueKey("value"), readerType: ReaderType.serialNumberReader),
        ],
      ),
    );
  }
}
