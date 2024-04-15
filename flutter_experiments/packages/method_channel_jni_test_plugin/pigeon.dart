import 'package:pigeon/pigeon.dart';

@ConfigurePigeon(PigeonOptions(
  dartOut: 'lib/messages.g.dart',
  dartOptions: DartOptions(),
  // cppOptions: CppOptions(namespace: 'pigeon'),
  // cppHeaderOut: 'windows/runner/messages.g.h',
  // cppSourceOut: 'windows/runner/messages.g.cpp',
  // kotlinOut: 'android/app/src/main/kotlin/dev/flutter/pigeon/Messages.g.kt',
  // kotlinOptions: KotlinOptions(),
  javaOut:
      'android/src/main/java/th/thesis/method_channel_jni_test_plugin/Messages.java',
  javaOptions: JavaOptions(
    package: 'th.thesis.method_channel_jni_test_plugin',
    className: 'Messages',
  ),
  //swiftOut: 'ios/Runner/Messages.g.swift',
  //swiftOptions: SwiftOptions(),
  //objcHeaderOut: 'macos/Runner/messages.g.h',
  //objcSourceOut: 'macos/Runner/messages.g.m',
  // Set this to a unique prefix for your plugin or application, per Objective-C naming conventions.
  //objcOptions: ObjcOptions(prefix: 'PGN'),
  //copyrightHeader: 'pigeons/copyright.txt',
  //dartPackageName: 'pigeon_example_package',
))
@HostApi()
abstract class CppExperimentPigeon {
  String getCPPHelloWorld();
  String getAndroidVersion();
  String reverse(String str);
  int getAnswer();
  void provideAnswer();
  Uint8List benchmark(Uint8List request);
}
