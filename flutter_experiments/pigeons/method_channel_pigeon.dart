import 'package:pigeon/pigeon.dart';

@ConfigurePigeon(PigeonOptions(
  dartOut: 'lib/experiments/pigeon_platform_channel/messages.g.dart',
  dartOptions: DartOptions(),
  javaOut: 'android/app/src/main/java/io/flutter/plugins/Messages.java',
  javaOptions: JavaOptions(
    package: 'io.flutter.plugins',
    className: 'Messages',
  ),
  copyrightHeader: 'pigeons/copyright.txt',
  dartPackageName: 'pigeon_example_package',
))
@HostApi()
abstract class MethodChannelPigeon {
  String reverse(String input);
  int add(int a, int b);
  int subtract(int a, int b);
  int multiply(int a, int b);
  int divide(int a, int b);
  ComplexStructure getComplexStructure();
}

class ComplexStructure {
  ComplexStructure({
    required this.a,
    required this.b,
    required this.c,
    required this.myList,
    required this.myKvMap,
  });
  int a;
  int b;
  String c;
  List<int?> myList;
  Map<String?, String?> myKvMap;
}
