import 'package:flutter_tts/flutter_tts.dart';

class CshTtsUtil {
  static final CshTtsUtil _instance = CshTtsUtil._internal();

  late FlutterTts _flutterTts;

  CshTtsUtil._internal() {
    _flutterTts = FlutterTts();
    _flutterTts.setVolume(1);
    _flutterTts.setSpeechRate(0.5);
  }

  factory CshTtsUtil() {
    return _instance;
  }

  speak(String value) {
    _flutterTts.speak(value);
  }
}
