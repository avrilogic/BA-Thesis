import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'platform_plugin_platform_interface.dart';

/// An implementation of [PlatformPluginPlatform] that uses method channels.
class MethodChannelPlatformPlugin extends PlatformPluginPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('platform_plugin');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
}
