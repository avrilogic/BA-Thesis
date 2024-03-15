import 'package:method_channel_jni_test_plugin/messages.g.dart';

class MethodChannelJniTestPlugin {
  final pigeon = CppExperimentPigeon();
  Future<String?> getPlatformVersion() => pigeon.getAndroidVersion();
  Future<String> getCPPHelloWorld() => pigeon.getCPPHelloWorld();
  Future<String> reverse(String input) => pigeon.reverse(input);
  Future<int> getAnswer() => pigeon.getAnswer();
  Future<void> provideAnswer() => pigeon.provideAnswer();
}
