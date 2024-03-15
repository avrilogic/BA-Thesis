import 'dart:core';

import 'package:flutter/material.dart';
import 'package:flutter_experiments/experiments/platform_channel/platform_channel_data.dart';

class PlatformChannelProvider extends ChangeNotifier {
  bool _isChannelEnabled = false;
  int? _batteryLevel;

  bool get isChannelEnabled => _isChannelEnabled;
  String get batteryLevel => _batteryLevel == null
      ? 'Unknown battery level.'
      : 'Battery level at $_batteryLevel % ';

  void toggleChannel(bool? value) {
    _isChannelEnabled = value ?? !_isChannelEnabled;
    notifyListeners();
  }

  Future<void> getBatteryLevel() async {
    _batteryLevel = await PlatformChannelData.getBatteryLevel();
    notifyListeners();
  }

  void resetBatteryLevel() {
    _batteryLevel = null;
    notifyListeners();
  }
}
