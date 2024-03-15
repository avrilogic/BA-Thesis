import 'package:flutter/services.dart';
import 'package:flutter_experiments/logger/logger.dart';

class PlatformChannelData {
  static const platform = MethodChannel('th.thesis.platform_channel/battery');

  static Future<int?> getBatteryLevel() async {
    try {
      final int result = await platform.invokeMethod('getBatteryLevel');
      return result;
    } on PlatformException catch (e) {
      Logger.error('Failed to get battery level: ${e.message}');
      return null;
    }
  }
}
