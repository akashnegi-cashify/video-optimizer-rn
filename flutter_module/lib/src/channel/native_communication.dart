import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:video_compress/video_compress.dart';

class NativeCommunication {
  static const MethodChannel _channel = MethodChannel('in.cashify.trc/plugin');

  static Future<MediaInfo?> compressVideo(
    String path, {
    bool deleteOrigin = true,
    bool? includeAudio,
    int? frameInterval,
    int frameRate = 30,
    double speed = 1.0,
  }) async {
    final jsonStr = await _channel.invokeMethod<String>('compressVideo', {
      'path': path,
      'deleteOrigin': deleteOrigin,
      'includeAudio': includeAudio,
      'frameRate': frameRate,
      'frameInterval': frameInterval,
      'setSpeed': speed,
    });

    if (jsonStr != null) {
      final jsonMap = jsonDecode(jsonStr);
      return MediaInfo.fromJson(jsonMap);
    } else {
      return null;
    }
  }
}
