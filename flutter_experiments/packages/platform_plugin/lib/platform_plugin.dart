
import 'platform_plugin_platform_interface.dart';

class PlatformPlugin {
  Future<String?> getPlatformVersion() {
    return PlatformPluginPlatform.instance.getPlatformVersion();
  }
}
