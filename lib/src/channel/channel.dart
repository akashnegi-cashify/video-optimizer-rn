import 'package:flutter/services.dart';
import '../types/platforms.dart';

const MethodChannel _channel = MethodChannel('in.cashify.flutter_boilerplate/plugin');

Future<Platform> getPlatform() async {
  final String? result = await _channel.invokeMethod<String>('getPlatform');
  switch (result) {
    case 'android':
      return Platform.ANDROID;
    case 'iOS':
      return Platform.IOS;
    case 'web':
      return Platform.WEB;
    default:
      return Platform.UNKNOWN;
  }
}
