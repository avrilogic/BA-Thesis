import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'platform_plugin_method_channel.dart';

abstract class PlatformPluginPlatform extends PlatformInterface {
  /// Constructs a PlatformPluginPlatform.
  PlatformPluginPlatform() : super(token: _token);

  static final Object _token = Object();

  static PlatformPluginPlatform _instance = MethodChannelPlatformPlugin();

  /// The default instance of [PlatformPluginPlatform] to use.
  ///
  /// Defaults to [MethodChannelPlatformPlugin].
  static PlatformPluginPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [PlatformPluginPlatform] when
  /// they register themselves.
  static set instance(PlatformPluginPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
