import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_trc/src/libraries/logging/log_screen.dart';
import 'package:path_provider/path_provider.dart';

enum LogType {
  info("INFO"),
  error("ERROR"),
  success("SUCCESS");

  final String value;

  const LogType(this.value);
}

class LoggingService {
  static const String _fileName = 'cops_video_logs.txt';
  static File? _logFile;

  static Future<void> initialize() async {
    final directory = await getApplicationDocumentsDirectory();
    _logFile = File('${directory.path}/$_fileName');
    if (!await _logFile!.exists()) {
      await _logFile!.create();
    }
  }

  static File? get logFile => _logFile;

  static Future<void> log(String message, {String? barcode, LogType type = LogType.info}) async {
    if (_logFile == null) {
      await initialize();
    }
    final timestamp = DateTime.now().toIso8601String();
    final coloredMessage = '[${type.value}] $barcode: $timestamp: $message\n';
    await _logFile!.writeAsString(coloredMessage, mode: FileMode.writeOnlyAppend);
  }

  static Future<void> clearLog() async {
    if (_logFile == null) {
      return;
    }
    await _logFile!.writeAsString('');
  }

  static showLogScreen(BuildContext context) {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const LogScreen(),
        ));
  }

  static Future<String> getLogs() async {
    if (_logFile == null) {
      await initialize();
    }
    return await _logFile!.readAsString();
  }
}
